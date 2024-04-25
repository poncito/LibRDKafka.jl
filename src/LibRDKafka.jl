module LibRDKafka

using Dates

include("generated/LibRDKafkaGen.jl")
using .LibRDKafkaGen

include("unsafestring.jl")
include("unsafevector.jl")

export kafkaconsumer, kafkaproducer, KafkaTopic, KafkaTopicPartitionList
export KafkaQueue

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

# we make this mutable because of the AbstractVector interface
mutable struct KafkaTopicPartitionList <: AbstractVector{rd_kafka_topic_partition_t}
    ptr::Ptr{rd_kafka_topic_partition_list_t}
    function KafkaTopicPartitionList(size::Int = 0)
        ptr = rd_kafka_topic_partition_list_new(size)
        @assert ptr != C_NULL "failed new topic partition list"
        new(ptr)
    end
end

function destroy!(tpl::KafkaTopicPartitionList)
    rd_kafka_topic_partition_list_destroy(tpl.ptr) 
    tpl.ptr = 0
    tpl
end

Base.size(tpl::KafkaTopicPartitionList) = (tpl.ptr == 0 ? 0 : unsafe_load(Ptr{Cint}(tpl.ptr)),)
function Base.getindex(tpl::KafkaTopicPartitionList, i::Integer)
    @assert 1 <= i <= length(tpl) # todo: boundscheck
    elems_ptr = unsafe_load(Ptr{Ptr{rd_kafka_topic_partition_t}}(tpl.ptr + 8))
    unsafe_load(elems_ptr + (i - 1) * sizeof(rd_kafka_topic_partition_t))
end

function Base.push!(tpl::KafkaTopicPartitionList, topic::String, partition::Integer, offset::Integer)
    push!(tpl, topic, partition)
    setoffset!(tpl, topic, partition, offset)
end

function Base.push!(tpl::KafkaTopicPartitionList, topic::String, partition::Integer=RD_KAFKA_PARTITION_UA)
    GC.@preserve topic begin
        rd_kafka_topic_partition_list_add(tpl.ptr, pointer(topic), partition)
        tpl
    end
end

function setoffset!(tpl::KafkaTopicPartitionList, topic::String, partition::Integer, offset::Int)
    GC.@preserve topic begin
        err = rd_kafka_topic_partition_list_set_offset(tpl.ptr, pointer(topic), partition, offset)
        try_throw_kafka_error(err)
        tpl
    end
end

struct KafkaHandle
    ptr::Ptr{rd_kafka_t}
    function KafkaHandle(handle::rd_kafka_type_t, conf::Ptr{rd_kafka_conf_t})
        errstr = zeros(UInt8, 512)
        ptr = rd_kafka_new(handle, conf, errstr, 512)
        if ptr == C_NULL
            rd_kafka_conf_destroy(conf)
            error(String(errstr))
        else
            new(ptr)
        end
    end
end

destroy!(handle::KafkaHandle) = rd_kafka_destroy(handle.ptr)

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

function assign!(client::KafkaHandle, topicpartition::KafkaTopicPartitionList)
    err = rd_kafka_assign(client.ptr, topicpartition.ptr)
    try_throw_kafka_error(err)
    client
end


"""
    function settimestamp!(client::KafkaHandle, tpl::KafkaTopicPartitionList, timestamp::DateTime; timeout_ms = 1000) 
"""
function settimestamp!(client::KafkaHandle, tpl::KafkaTopicPartitionList, timestamp::DateTime; timeout_ms = 1000) 
    ts_int = _datetime2epoch(timestamp)
    obj = unsafe_load(tpl.ptr)
    for i = 0:obj.cnt-1
        partition_ptr = obj.elems + sizeof(rd_kafka_topic_partition_s) * i
        ptr_offset = Ptr{Int64}(partition_ptr + 16)
        unsafe_store!(ptr_offset, ts_int) # todo: make this safer
    end
    err = rd_kafka_offsets_for_times(client.ptr, tpl.ptr, timeout_ms)

    try_throw_kafka_error(err)
    tpl
end

function commit!(client::KafkaHandle, tpl::KafkaTopicPartitionList, async::Integer=0)
    err = rd_kafka_commit(client.ptr, tpl.ptr, async)
    try_throw_kafka_error(err)
    client
end

struct UnsafeKafkaMessage
    ptr::Ptr{rd_kafka_message_t}
end

function UnsafeKafkaMessage(f::Function, args...; kwargs...)
    message = UnsafeKafkaMessage(args...; kwargs...)
    try
        f(message)
    finally
        destroy!(message)
    end
end

Base.propertynames(::UnsafeKafkaMessage) = (:payload, :partition, :key, :offset, :timestamp, :topicname, :err)

function Base.getproperty(msg::UnsafeKafkaMessage, s::Symbol)
    ptr = getfield(msg, :ptr)
    msg = unsafe_load(ptr)
    if s == :payload
        UnsafeVector(msg.payload |> Ptr{UInt8}, msg.len)
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
    elseif s == :topicname
        rd_kafka_topic_name(msg.rkt) |> UnsafeString
    elseif s == :err
        msg.err
    else
        error("type UnsafeKafkaMessage has no property $s")
    end
end

function Base.take!(handle::Function, client::KafkaHandle, timeout_ms)
    rkmessage = rd_kafka_consumer_poll(client.ptr, timeout_ms)
    rkmessage == C_NULL && return false

    UnsafeKafkaMessage(rkmessage) do message
        if message.err == RD_KAFKA_RESP_ERR_NO_ERROR
            handle(message)
            rd_kafka_message_destroy(rkmessage)
            true
        else
            @info "error" message.err
            false
        end
    end

    true
end

function unsafe_take!(client::KafkaHandle, timeout_ms)
    rkmessage = rd_kafka_consumer_poll(client.ptr, timeout_ms)
    if rkmessage == C_NULL
        nothing
    else
        UnsafeKafkaMessage(rkmessage)
    end
end

destroy!(message::UnsafeKafkaMessage) = rd_kafka_message_destroy(getfield(message, :ptr))

struct KafkaTopic
    ptr::Ptr{rd_kafka_topic_t}
    function KafkaTopic(handle::Ptr{rd_kafka_t}, topic, conf::Ptr{rd_kafka_topic_conf_t})
        ptr = rd_kafka_topic_new(handle, topic, conf)
        if ptr == C_NULL
            rd_kafka_topic_conf_destroy(conf) # already destroyed in case of success
            error("error creating topic handle: $topic")
        end
        new(ptr)
    end
end

function KafkaTopic(f::Function, args...; kwargs...)
    topic = KafkaTopic(args...; kwargs...)
    try
        f(topic)
    finally
        destroy!(topic)
    end
end

destroy!(topic::KafkaTopic) = rd_kafka_topic_destroy(topic.ptr)

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

# function Base.put!(handle::KafkaHandle, topic::String, key, payload, partition; timestamp=nothing)
#     GC.@preserve payload key begin
#         err = rd_kafka_producev(
#             handle.ptr,
#             RD_KAFKA_V_TOPIC, topic,
#             RD_KAFKA_VTYPE_PARTITION, partition,
#             RD_KAFKA_V_MSGFLAGS, RD_KAFKA_MSG_F_COPY,
#             RD_KAFKA_V_VALUE, payload, payload_len,
#             RD_KAFKA_V_KEY, key, key_len,
#             RD_KAFKA_V_TIMESTAMP, timestamp,
#             partition,
#             RD_KAFKA_MSG_F_COPY,
#             payload |> pointer,
#             length(payload),
#             key |> pointer,
#             length(key),
#             C_NULL,
#         )
#     end
#     try_throw_kafka_error(err)
#     topic
# end

function query_watermark_offsets(handle::KafkaHandle, topic::Union{String,UnsafeString}, partition::Integer, timeout_ms::Integer)
    low = Ref{Int64}()
    high = Ref{Int64}()
    err = rd_kafka_query_watermark_offsets(handle.ptr, topic, partition, low, high, timeout_ms)
    try_throw_kafka_error(err)
    low[], high[]
end

function get_topic_name(topic::KafkaTopic)
    ptr = rd_kafka_topic_name(topic.ptr)
    UnsafeString(ptr)
end

struct KafkaQueue
    ptr::Ptr{rd_kafka_queue_t}
end

function KafkaQueue(handle::KafkaHandle)
    ptr = rd_kafka_queue_new(handle.ptr)
    KafkaQueue(ptr)
end

function KafkaQueue(f::Function, handle::KafkaHandle)
    queue = KafkaQueue(handle)
    try
        f(queue)
    finally
        destroy!(queue)
    end
end

destroy!(queue::KafkaQueue) = rd_kafka_queue_destroy(queue.ptr)

function create_pipe()
    fds = Vector{Int32}(undef, 2)  # Array to store the two file descriptors
    result = ccall((:pipe), Int32, (Ptr{Int32},), fds)
    if result != 0
        error("Failed to create a pipe")
    end
    fd_read, fd_write = fds
   return fd_read, fd_write
end

function consume_start(consumer::KafkaHandle, queue::KafkaQueue, topic::String, partition::Integer, offset::Integer)
    KafkaTopic(consumer, topic) do topic
        err = rd_kafka_consume_start_queue(
            topic.ptr,
            partition,
            offset,
            queue.ptr,
        )
        try_throw_kafka_error(err)
    end
end

function consume_stop(consumer::KafkaHandle, topic::String, partition::Integer)
    KafkaTopic(consumer, topic) do topic
        err = rd_kafka_consume_stop(
            topic.ptr,
            partition,
        )
        try_throw_kafka_error(err)
    end
end

function Base.foreach(f::Function, queue::KafkaQueue)
    fd_read, fd_write = create_pipe()
    try
        stream_read = open(Libc.dup(RawFD(fd_read)))
         
        rd_kafka_queue_io_event_enable(queue.ptr, fd_write, zeros(UInt8, 1), 1)

        while true
            while true
                rkmessage = rd_kafka_consume_queue(queue.ptr, 0)
                rkmessage == C_NULL && break

                message = UnsafeKafkaMessage(rkmessage)
                try
                    err = message.err
                    if err == LibRDKafka.RD_KAFKA_RESP_ERR_NO_ERROR
                        errf = f(message)
                        errf == 0 || return errf
                    elseif err == LibRDKafka.RD_KAFKA_RESP_ERR__PARTITION_EOF
                        @info "RD_KAFKA_RESP_ERR__PARTITION_EOF"
                        continue
                    else
                        @info "message error" err
                        return
                    end
                finally
                    destroy!(message)
                end
            end
            read(stream_read, UInt8)
        end
    finally
        ccall((:close), Int32, (Int32,), fd_read)
        ccall((:close), Int32, (Int32,), fd_write)
    end
    nothing
end

end # module LibRDKafka
