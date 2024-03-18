module LibRDKafka

include("generated/LibRDKafkaGen.jl")
using .LibRDKafkaGen

include("unsafestring.jl")

export kafkaconsumer, kafkaproducer, KafkaTopic, KafkaSubscription

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

function Base.push!(tpl::KafkaTopicPartitionList, topic::String, partition::Integer)
    rd_kafka_topic_partition_list_add(tpl.ptr, pointer(topic), partition)
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
    if err != RD_KAFKA_RESP_ERR_NO_ERROR
        ptr = rd_kafka_err2str(err)
        str = UnsafeString(ptr)
        error(str)
    end
    client
end

struct KafkaSubscription
    topic::String
    partition::Int
end

function subscribe!(client::KafkaHandle, subscriptions::AbstractVector{KafkaSubscription})
    tpl = KafkaTopicPartitionList(length(subscriptions))

    for s in subscriptions
        push!(tpl, s.topic, s.partition)
    end
    subscribe!(client, tpl)
    client
end

struct UnsafeKafkaMessage
    raw::rd_kafka_message_t
end

Base.propertynames(::UnsafeKafkaMessage) = (:topicname, :payload, :partition, :key, :offset)

function Base.getproperty(msg::UnsafeKafkaMessage, s::Symbol)
    raw = getfield(msg, :raw)
    if s == :topicname
        ptr = rd_kafka_topic_name(raw.rkt)
        UnsafeString(ptr)
    elseif s == :payload
        UnsafeString(raw.payload |> Ptr{UInt8}, raw.len)
    elseif s == :key
        UnsafeString(raw.key |> Ptr{UInt8}, raw.key_len)
    elseif s == :partition
        Int(raw.partition)
    elseif s == :offset
        raw.offset
    else
        error("type UnsafeKafkaMessage has no property $s")
    end
end

function Base.take!(handle::Function, client::KafkaHandle, timeout_ms)
    rkmessage = rd_kafka_consumer_poll(client.ptr, timeout_ms)
    if rkmessage != C_NULL
        message = UnsafeKafkaMessage(unsafe_load(rkmessage))
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
    errno = rd_kafka_produce(
        topic.ptr,
        partition,
        0,
        payload |> pointer,
        length(payload),
        key |> pointer,
        length(key),
        C_NULL,
    )
    if errno == RD_KAFKA_RESP_ERR_NO_ERROR
        return topic
    else
        error("error number: $errno")
    end
end

# todo:
# - use blobs
# - remove string allocation


end # module LibRDKafka
