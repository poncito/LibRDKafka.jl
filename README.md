# LibRDKafka

This library uses `Clang.jl` to generate Julia bindings for the C library librdkafka.

It also provides a Julia API to consume and produce data.
Its goal is to hide the "manual" memory management, to reduce the risks
associated with unsafe code and pointer manipulations.
It is meant to stay as close as possible from the C API otherwise.

## Example
```julia
brokers = "localhost:9092"
groupid = "my_consumer_group_id"
topic = "test"

consumer = kafkaconsumer(brokers, groupid)
LibRDKafka.subscribe!(consumer, [KafkaSubscription("test", 0)])

producer = kafkaproducer(brokers)
topic = KafkaTopic(producer, topic)
put!(topic, "key", "message")

take!(consumer, 1000) do msg
    @info "msg" msg.payload msg.topicname
end
```
