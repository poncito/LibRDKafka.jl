module LibRDKafka

using Dates

include("generated/LibRDKafkaGen.jl")
using .LibRDKafkaGen

include("unsafestring.jl")

export kafkaconsumer, kafkaproducer, KafkaTopic, KafkaTopicPartitionList

_datetime2epoch(x::DateTime) = (Dates.value(x) - Dates.UNIXEPOCH)
_epoch2datetime(x::Int) = DateTime(1970) + Millisecond(x)

function try_throw_kafka_error(err::Union{Int32,rd_kafka_resp_err_t})
    if err != RD_KAFKA_RESP_ERR_NO_ERROR
        ptr = rd_kafka_err2str(err)
        str = UnsafeString(ptr)
        error(str)
    end
end

function make_kafka_conf(conf::AbstractDict)
    ptr = rd_kafka_conf_new()
    @assert ptr != C_NULL
    errstr = zeros(UInt8, 512)

    for (k, v) in conf
        status = rd_kafka_conf_set(ptr, string(k), string(v), errstr, 512)
        if status != RD_KAFKA_CONF_OK
            errstr = String(errstr)
            error(errstr)
        end
    end
    ptr
end

function make_kafka_topic_conf(conf::AbstractDict)
    ptr = rd_kafka_topic_conf_new()
    @assert ptr != C_NULL
    errstr = zeros(UInt8, 512)

    for (k, v) in conf
        kstr = string(k)
        vstr = string(v)

        status = rd_kafka_topic_conf_set(ptr, kstr, vstr, errstr, 512)
        if status != RD_KAFKA_CONF_OK
            error("error setting value $vstr for key $kstr")
        end
    end
    ptr
end

mutable struct KafkaTopicPartitionList
    ptr::Ptr{rd_kafka_topic_partition_list_t}
    function KafkaTopicPartitionList(size::Int = 0)
        ptr = rd_kafka_topic_partition_list_new(size)
        @assert ptr != C_NULL "failed new topic partition list"
        tpl = new(ptr)
        finalizer(tpl) do x
            rd_kafka_topic_partition_list_destroy(x.ptr)
        end
        tpl
    end
end

function Base.push!(tpl::KafkaTopicPartitionList, topic::String, partition::Integer, offset::Integer)
    push!(tpl, topic, partition)
    setoffset!(tpl, topic, partition, offset)
end

function Base.push!(tpl::KafkaTopicPartitionList, topic::String, partition::Integer)
    GC.@preserve topic begin
        rd_kafka_topic_partition_list_add(tpl.ptr, pointer(topic), partition)
    end
end

function setoffset!(tpl::KafkaTopicPartitionList, topic::String, partition::Integer, offset::Int)
    GC.@preserve topic begin
        err = rd_kafka_topic_partition_list_set_offset(tpl.ptr, pointer(topic), partition, offset)
        try_throw_kafka_error(err)
        tpl
    end
end

mutable struct KafkaHandle
    const ptr::Ptr{rd_kafka_t}
    function KafkaHandle(handle::rd_kafka_type_t, conf::Ptr{rd_kafka_conf_t})
        errstr = zeros(UInt8, 512)
        ptr = rd_kafka_new(handle, conf, errstr, 512)
        if ptr == C_NULL
            rd_kafka_conf_destroy(conf)
            error(String(errstr))
        else
            client = new(ptr)
            finalizer(client) do x
                rd_kafka_destroy(x.ptr)
            end
            client
        end
    end
end

function kafkaconsumer(
    bootstrapservers::String,
    groupid::String;
    conf::AbstractDict = Dict(),
)
    conf["bootstrap.servers"] = bootstrapservers
    conf["group.id"] = groupid
    ptr = make_kafka_conf(conf)
    KafkaHandle(RD_KAFKA_CONSUMER, ptr)
end

function kafkaproducer(bootstrapservers::String; conf::AbstractDict = Dict())
    conf["bootstrap.servers"] = bootstrapservers
    ptr = make_kafka_conf(conf)
    KafkaHandle(RD_KAFKA_PRODUCER, ptr)
end

function subscribe!(client::KafkaHandle, topicpartition::KafkaTopicPartitionList)
    err = rd_kafka_subscribe(client.ptr, topicpartition.ptr)
    try_throw_kafka_error(err)
    client
end


"""
    function settimestamp!(client::KafkaHandle, tpl::KafkaTopicPartitionList, timestamp::DateTime; timeout_ms = 1000) 

This method should be called after `subscribe!`.
"""
function settimestamp!(client::KafkaHandle, tpl::KafkaTopicPartitionList, timestamp::DateTime; timeout_ms = 1000) 
    ts_int = _datetime2epoch(timestamp)
    obj = unsafe_load(tpl.ptr)
    for i = 0:obj.cnt-1
        partition_ptr = obj.elems + 8 * i
        unsafe_store!(Ptr{Int64}(partition_ptr + 16), ts_int) # todo: make this safer
    end
    err = rd_kafka_offsets_for_times(client.ptr, tpl.ptr, timeout_ms)
    try_throw_kafka_error(err)
    tpl
end

struct UnsafeKafkaMessage
    ptr::Ptr{rd_kafka_message_t}
end

Base.propertynames(::UnsafeKafkaMessage) = (:payload, :partition, :key, :offset, :timestamp)

function Base.getproperty(msg::UnsafeKafkaMessage, s::Symbol)
    ptr = getfield(msg, :ptr)
    msg = unsafe_load(ptr)
    @info "msg" msg
    if s == :payload
        UnsafeString(msg.payload |> Ptr{UInt8}, msg.len)
    elseif s == :key
        UnsafeString(msg.key |> Ptr{UInt8}, msg.key_len)
    elseif s == :partition
        Int(msg.partition)
    elseif s == :offset
        msg.offset
    elseif s == :timestamp
        typeref = Ref{rd_kafka_timestamp_type_t}()
        GC.@preserve typeref begin
            time_ms = rd_kafka_message_timestamp(ptr, typeref)
            _epoch2datetime(time_ms)
        end
    else
        error("type UnsafeKafkaMessage has no property $s")
    end
end

function Base.take!(handle::Function, client::KafkaHandle, timeout_ms)
    rkmessage = rd_kafka_consumer_poll(client.ptr, timeout_ms)
    if rkmessage != C_NULL
        message = UnsafeKafkaMessage(rkmessage)
        handle(message)
        rd_kafka_message_destroy(rkmessage)
        true
    else
        false
    end
end

mutable struct KafkaTopic
    const ptr::Ptr{rd_kafka_topic_t}
    function KafkaTopic(handle::Ptr{rd_kafka_t}, topic, conf::Ptr{rd_kafka_topic_conf_t})
        ptr = rd_kafka_topic_new(handle, topic, conf)
        if ptr == C_NULL
            rd_kafka_topic_conf_destroy(conf) # already destroyed in case of success
            error("error creating topic handle: $topic")
        end
        t = new(ptr)
        finalizer(t) do x
            rd_kafka_topic_destroy(x.ptr)
        end
        t
    end
end

function KafkaTopic(producer::KafkaHandle, topic; conf::AbstractDict = Dict())
    confptr = make_kafka_topic_conf(conf)
    KafkaTopic(producer.ptr, topic, confptr)
end

function Base.put!(topic::KafkaTopic, key, payload, partition = RD_KAFKA_PARTITION_UA)
    GC.@preserve payload key begin
        err = rd_kafka_produce(
            topic.ptr,
            partition,
            RD_KAFKA_MSG_F_COPY,
            payload |> pointer,
            length(payload),
            key |> pointer,
            length(key),
            C_NULL,
        )
    end
    try_throw_kafka_error(err)
    topic
end

# todo:
# - use blobs
# - remove string allocation


end # module LibRDKafka
