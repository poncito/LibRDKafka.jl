module LibRDKafkaGen

using librdkafka_jll
export librdkafka_jll

using CEnum

const RD_KAFKA_DEBUG_CONTEXTS = (
    "all,generic,broker,topic,metadata,feature,queue,msg,protocol,cgrp,security,fetch,interceptor,plugin,consumer,admin,eos,mock,assignor,conf"
)
const RD_KAFKA_PARTITION_UA = -1


mutable struct rd_kafka_topic_s end

const rd_kafka_topic_t = rd_kafka_topic_s

mutable struct rd_kafka_headers_s end

const rd_kafka_headers_t = rd_kafka_headers_s

function rd_kafka_version()
    ccall((:rd_kafka_version, librdkafka), Cint, ())
end

function rd_kafka_version_str()
    ccall((:rd_kafka_version_str, librdkafka), Ptr{Cchar}, ())
end

@cenum rd_kafka_type_t::UInt32 begin
    RD_KAFKA_PRODUCER = 0
    RD_KAFKA_CONSUMER = 1
end

@cenum rd_kafka_timestamp_type_t::UInt32 begin
    RD_KAFKA_TIMESTAMP_NOT_AVAILABLE = 0
    RD_KAFKA_TIMESTAMP_CREATE_TIME = 1
    RD_KAFKA_TIMESTAMP_LOG_APPEND_TIME = 2
end

function rd_kafka_get_debug_contexts()
    ccall((:rd_kafka_get_debug_contexts, librdkafka), Ptr{Cchar}, ())
end

mutable struct rd_kafka_s end

const rd_kafka_t = rd_kafka_s

mutable struct rd_kafka_conf_s end

const rd_kafka_conf_t = rd_kafka_conf_s

mutable struct rd_kafka_topic_conf_s end

const rd_kafka_topic_conf_t = rd_kafka_topic_conf_s

mutable struct rd_kafka_queue_s end

const rd_kafka_queue_t = rd_kafka_queue_s

mutable struct rd_kafka_op_s end

const rd_kafka_event_t = rd_kafka_op_s

mutable struct rd_kafka_topic_result_s end

const rd_kafka_topic_result_t = rd_kafka_topic_result_s

mutable struct rd_kafka_consumer_group_metadata_s end

const rd_kafka_consumer_group_metadata_t = rd_kafka_consumer_group_metadata_s

mutable struct rd_kafka_error_s end

const rd_kafka_error_t = rd_kafka_error_s

mutable struct rd_kafka_group_result_s end

const rd_kafka_group_result_t = rd_kafka_group_result_s

mutable struct rd_kafka_acl_result_s end

const rd_kafka_acl_result_t = rd_kafka_acl_result_s

mutable struct rd_kafka_Uuid_s end

const rd_kafka_Uuid_t = rd_kafka_Uuid_s

@cenum rd_kafka_resp_err_t::Int32 begin
    RD_KAFKA_RESP_ERR__BEGIN = -200
    RD_KAFKA_RESP_ERR__BAD_MSG = -199
    RD_KAFKA_RESP_ERR__BAD_COMPRESSION = -198
    RD_KAFKA_RESP_ERR__DESTROY = -197
    RD_KAFKA_RESP_ERR__FAIL = -196
    RD_KAFKA_RESP_ERR__TRANSPORT = -195
    RD_KAFKA_RESP_ERR__CRIT_SYS_RESOURCE = -194
    RD_KAFKA_RESP_ERR__RESOLVE = -193
    RD_KAFKA_RESP_ERR__MSG_TIMED_OUT = -192
    RD_KAFKA_RESP_ERR__PARTITION_EOF = -191
    RD_KAFKA_RESP_ERR__UNKNOWN_PARTITION = -190
    RD_KAFKA_RESP_ERR__FS = -189
    RD_KAFKA_RESP_ERR__UNKNOWN_TOPIC = -188
    RD_KAFKA_RESP_ERR__ALL_BROKERS_DOWN = -187
    RD_KAFKA_RESP_ERR__INVALID_ARG = -186
    RD_KAFKA_RESP_ERR__TIMED_OUT = -185
    RD_KAFKA_RESP_ERR__QUEUE_FULL = -184
    RD_KAFKA_RESP_ERR__ISR_INSUFF = -183
    RD_KAFKA_RESP_ERR__NODE_UPDATE = -182
    RD_KAFKA_RESP_ERR__SSL = -181
    RD_KAFKA_RESP_ERR__WAIT_COORD = -180
    RD_KAFKA_RESP_ERR__UNKNOWN_GROUP = -179
    RD_KAFKA_RESP_ERR__IN_PROGRESS = -178
    RD_KAFKA_RESP_ERR__PREV_IN_PROGRESS = -177
    RD_KAFKA_RESP_ERR__EXISTING_SUBSCRIPTION = -176
    RD_KAFKA_RESP_ERR__ASSIGN_PARTITIONS = -175
    RD_KAFKA_RESP_ERR__REVOKE_PARTITIONS = -174
    RD_KAFKA_RESP_ERR__CONFLICT = -173
    RD_KAFKA_RESP_ERR__STATE = -172
    RD_KAFKA_RESP_ERR__UNKNOWN_PROTOCOL = -171
    RD_KAFKA_RESP_ERR__NOT_IMPLEMENTED = -170
    RD_KAFKA_RESP_ERR__AUTHENTICATION = -169
    RD_KAFKA_RESP_ERR__NO_OFFSET = -168
    RD_KAFKA_RESP_ERR__OUTDATED = -167
    RD_KAFKA_RESP_ERR__TIMED_OUT_QUEUE = -166
    RD_KAFKA_RESP_ERR__UNSUPPORTED_FEATURE = -165
    RD_KAFKA_RESP_ERR__WAIT_CACHE = -164
    RD_KAFKA_RESP_ERR__INTR = -163
    RD_KAFKA_RESP_ERR__KEY_SERIALIZATION = -162
    RD_KAFKA_RESP_ERR__VALUE_SERIALIZATION = -161
    RD_KAFKA_RESP_ERR__KEY_DESERIALIZATION = -160
    RD_KAFKA_RESP_ERR__VALUE_DESERIALIZATION = -159
    RD_KAFKA_RESP_ERR__PARTIAL = -158
    RD_KAFKA_RESP_ERR__READ_ONLY = -157
    RD_KAFKA_RESP_ERR__NOENT = -156
    RD_KAFKA_RESP_ERR__UNDERFLOW = -155
    RD_KAFKA_RESP_ERR__INVALID_TYPE = -154
    RD_KAFKA_RESP_ERR__RETRY = -153
    RD_KAFKA_RESP_ERR__PURGE_QUEUE = -152
    RD_KAFKA_RESP_ERR__PURGE_INFLIGHT = -151
    RD_KAFKA_RESP_ERR__FATAL = -150
    RD_KAFKA_RESP_ERR__INCONSISTENT = -149
    RD_KAFKA_RESP_ERR__GAPLESS_GUARANTEE = -148
    RD_KAFKA_RESP_ERR__MAX_POLL_EXCEEDED = -147
    RD_KAFKA_RESP_ERR__UNKNOWN_BROKER = -146
    RD_KAFKA_RESP_ERR__NOT_CONFIGURED = -145
    RD_KAFKA_RESP_ERR__FENCED = -144
    RD_KAFKA_RESP_ERR__APPLICATION = -143
    RD_KAFKA_RESP_ERR__ASSIGNMENT_LOST = -142
    RD_KAFKA_RESP_ERR__NOOP = -141
    RD_KAFKA_RESP_ERR__AUTO_OFFSET_RESET = -140
    RD_KAFKA_RESP_ERR__LOG_TRUNCATION = -139
    RD_KAFKA_RESP_ERR__END = -100
    RD_KAFKA_RESP_ERR_UNKNOWN = -1
    RD_KAFKA_RESP_ERR_NO_ERROR = 0
    RD_KAFKA_RESP_ERR_OFFSET_OUT_OF_RANGE = 1
    RD_KAFKA_RESP_ERR_INVALID_MSG = 2
    RD_KAFKA_RESP_ERR_UNKNOWN_TOPIC_OR_PART = 3
    RD_KAFKA_RESP_ERR_INVALID_MSG_SIZE = 4
    RD_KAFKA_RESP_ERR_LEADER_NOT_AVAILABLE = 5
    RD_KAFKA_RESP_ERR_NOT_LEADER_FOR_PARTITION = 6
    RD_KAFKA_RESP_ERR_REQUEST_TIMED_OUT = 7
    RD_KAFKA_RESP_ERR_BROKER_NOT_AVAILABLE = 8
    RD_KAFKA_RESP_ERR_REPLICA_NOT_AVAILABLE = 9
    RD_KAFKA_RESP_ERR_MSG_SIZE_TOO_LARGE = 10
    RD_KAFKA_RESP_ERR_STALE_CTRL_EPOCH = 11
    RD_KAFKA_RESP_ERR_OFFSET_METADATA_TOO_LARGE = 12
    RD_KAFKA_RESP_ERR_NETWORK_EXCEPTION = 13
    RD_KAFKA_RESP_ERR_COORDINATOR_LOAD_IN_PROGRESS = 14
    RD_KAFKA_RESP_ERR_COORDINATOR_NOT_AVAILABLE = 15
    RD_KAFKA_RESP_ERR_NOT_COORDINATOR = 16
    RD_KAFKA_RESP_ERR_TOPIC_EXCEPTION = 17
    RD_KAFKA_RESP_ERR_RECORD_LIST_TOO_LARGE = 18
    RD_KAFKA_RESP_ERR_NOT_ENOUGH_REPLICAS = 19
    RD_KAFKA_RESP_ERR_NOT_ENOUGH_REPLICAS_AFTER_APPEND = 20
    RD_KAFKA_RESP_ERR_INVALID_REQUIRED_ACKS = 21
    RD_KAFKA_RESP_ERR_ILLEGAL_GENERATION = 22
    RD_KAFKA_RESP_ERR_INCONSISTENT_GROUP_PROTOCOL = 23
    RD_KAFKA_RESP_ERR_INVALID_GROUP_ID = 24
    RD_KAFKA_RESP_ERR_UNKNOWN_MEMBER_ID = 25
    RD_KAFKA_RESP_ERR_INVALID_SESSION_TIMEOUT = 26
    RD_KAFKA_RESP_ERR_REBALANCE_IN_PROGRESS = 27
    RD_KAFKA_RESP_ERR_INVALID_COMMIT_OFFSET_SIZE = 28
    RD_KAFKA_RESP_ERR_TOPIC_AUTHORIZATION_FAILED = 29
    RD_KAFKA_RESP_ERR_GROUP_AUTHORIZATION_FAILED = 30
    RD_KAFKA_RESP_ERR_CLUSTER_AUTHORIZATION_FAILED = 31
    RD_KAFKA_RESP_ERR_INVALID_TIMESTAMP = 32
    RD_KAFKA_RESP_ERR_UNSUPPORTED_SASL_MECHANISM = 33
    RD_KAFKA_RESP_ERR_ILLEGAL_SASL_STATE = 34
    RD_KAFKA_RESP_ERR_UNSUPPORTED_VERSION = 35
    RD_KAFKA_RESP_ERR_TOPIC_ALREADY_EXISTS = 36
    RD_KAFKA_RESP_ERR_INVALID_PARTITIONS = 37
    RD_KAFKA_RESP_ERR_INVALID_REPLICATION_FACTOR = 38
    RD_KAFKA_RESP_ERR_INVALID_REPLICA_ASSIGNMENT = 39
    RD_KAFKA_RESP_ERR_INVALID_CONFIG = 40
    RD_KAFKA_RESP_ERR_NOT_CONTROLLER = 41
    RD_KAFKA_RESP_ERR_INVALID_REQUEST = 42
    RD_KAFKA_RESP_ERR_UNSUPPORTED_FOR_MESSAGE_FORMAT = 43
    RD_KAFKA_RESP_ERR_POLICY_VIOLATION = 44
    RD_KAFKA_RESP_ERR_OUT_OF_ORDER_SEQUENCE_NUMBER = 45
    RD_KAFKA_RESP_ERR_DUPLICATE_SEQUENCE_NUMBER = 46
    RD_KAFKA_RESP_ERR_INVALID_PRODUCER_EPOCH = 47
    RD_KAFKA_RESP_ERR_INVALID_TXN_STATE = 48
    RD_KAFKA_RESP_ERR_INVALID_PRODUCER_ID_MAPPING = 49
    RD_KAFKA_RESP_ERR_INVALID_TRANSACTION_TIMEOUT = 50
    RD_KAFKA_RESP_ERR_CONCURRENT_TRANSACTIONS = 51
    RD_KAFKA_RESP_ERR_TRANSACTION_COORDINATOR_FENCED = 52
    RD_KAFKA_RESP_ERR_TRANSACTIONAL_ID_AUTHORIZATION_FAILED = 53
    RD_KAFKA_RESP_ERR_SECURITY_DISABLED = 54
    RD_KAFKA_RESP_ERR_OPERATION_NOT_ATTEMPTED = 55
    RD_KAFKA_RESP_ERR_KAFKA_STORAGE_ERROR = 56
    RD_KAFKA_RESP_ERR_LOG_DIR_NOT_FOUND = 57
    RD_KAFKA_RESP_ERR_SASL_AUTHENTICATION_FAILED = 58
    RD_KAFKA_RESP_ERR_UNKNOWN_PRODUCER_ID = 59
    RD_KAFKA_RESP_ERR_REASSIGNMENT_IN_PROGRESS = 60
    RD_KAFKA_RESP_ERR_DELEGATION_TOKEN_AUTH_DISABLED = 61
    RD_KAFKA_RESP_ERR_DELEGATION_TOKEN_NOT_FOUND = 62
    RD_KAFKA_RESP_ERR_DELEGATION_TOKEN_OWNER_MISMATCH = 63
    RD_KAFKA_RESP_ERR_DELEGATION_TOKEN_REQUEST_NOT_ALLOWED = 64
    RD_KAFKA_RESP_ERR_DELEGATION_TOKEN_AUTHORIZATION_FAILED = 65
    RD_KAFKA_RESP_ERR_DELEGATION_TOKEN_EXPIRED = 66
    RD_KAFKA_RESP_ERR_INVALID_PRINCIPAL_TYPE = 67
    RD_KAFKA_RESP_ERR_NON_EMPTY_GROUP = 68
    RD_KAFKA_RESP_ERR_GROUP_ID_NOT_FOUND = 69
    RD_KAFKA_RESP_ERR_FETCH_SESSION_ID_NOT_FOUND = 70
    RD_KAFKA_RESP_ERR_INVALID_FETCH_SESSION_EPOCH = 71
    RD_KAFKA_RESP_ERR_LISTENER_NOT_FOUND = 72
    RD_KAFKA_RESP_ERR_TOPIC_DELETION_DISABLED = 73
    RD_KAFKA_RESP_ERR_FENCED_LEADER_EPOCH = 74
    RD_KAFKA_RESP_ERR_UNKNOWN_LEADER_EPOCH = 75
    RD_KAFKA_RESP_ERR_UNSUPPORTED_COMPRESSION_TYPE = 76
    RD_KAFKA_RESP_ERR_STALE_BROKER_EPOCH = 77
    RD_KAFKA_RESP_ERR_OFFSET_NOT_AVAILABLE = 78
    RD_KAFKA_RESP_ERR_MEMBER_ID_REQUIRED = 79
    RD_KAFKA_RESP_ERR_PREFERRED_LEADER_NOT_AVAILABLE = 80
    RD_KAFKA_RESP_ERR_GROUP_MAX_SIZE_REACHED = 81
    RD_KAFKA_RESP_ERR_FENCED_INSTANCE_ID = 82
    RD_KAFKA_RESP_ERR_ELIGIBLE_LEADERS_NOT_AVAILABLE = 83
    RD_KAFKA_RESP_ERR_ELECTION_NOT_NEEDED = 84
    RD_KAFKA_RESP_ERR_NO_REASSIGNMENT_IN_PROGRESS = 85
    RD_KAFKA_RESP_ERR_GROUP_SUBSCRIBED_TO_TOPIC = 86
    RD_KAFKA_RESP_ERR_INVALID_RECORD = 87
    RD_KAFKA_RESP_ERR_UNSTABLE_OFFSET_COMMIT = 88
    RD_KAFKA_RESP_ERR_THROTTLING_QUOTA_EXCEEDED = 89
    RD_KAFKA_RESP_ERR_PRODUCER_FENCED = 90
    RD_KAFKA_RESP_ERR_RESOURCE_NOT_FOUND = 91
    RD_KAFKA_RESP_ERR_DUPLICATE_RESOURCE = 92
    RD_KAFKA_RESP_ERR_UNACCEPTABLE_CREDENTIAL = 93
    RD_KAFKA_RESP_ERR_INCONSISTENT_VOTER_SET = 94
    RD_KAFKA_RESP_ERR_INVALID_UPDATE_VERSION = 95
    RD_KAFKA_RESP_ERR_FEATURE_UPDATE_FAILED = 96
    RD_KAFKA_RESP_ERR_PRINCIPAL_DESERIALIZATION_FAILURE = 97
    RD_KAFKA_RESP_ERR_END_ALL = 98
end

struct rd_kafka_err_desc
    code::rd_kafka_resp_err_t
    name::Ptr{Cchar}
    desc::Ptr{Cchar}
end

function rd_kafka_get_err_descs(errdescs, cntp)
    ccall(
        (:rd_kafka_get_err_descs, librdkafka),
        Cvoid,
        (Ptr{Ptr{rd_kafka_err_desc}}, Ptr{Csize_t}),
        errdescs,
        cntp,
    )
end

function rd_kafka_err2str(err)
    ccall((:rd_kafka_err2str, librdkafka), Ptr{Cchar}, (rd_kafka_resp_err_t,), err)
end

function rd_kafka_err2name(err)
    ccall((:rd_kafka_err2name, librdkafka), Ptr{Cchar}, (rd_kafka_resp_err_t,), err)
end

function rd_kafka_last_error()
    ccall((:rd_kafka_last_error, librdkafka), rd_kafka_resp_err_t, ())
end

function rd_kafka_errno2err(errnox)
    ccall((:rd_kafka_errno2err, librdkafka), rd_kafka_resp_err_t, (Cint,), errnox)
end

function rd_kafka_errno()
    ccall((:rd_kafka_errno, librdkafka), Cint, ())
end

function rd_kafka_fatal_error(rk, errstr, errstr_size)
    ccall(
        (:rd_kafka_fatal_error, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_t}, Ptr{Cchar}, Csize_t),
        rk,
        errstr,
        errstr_size,
    )
end

function rd_kafka_test_fatal_error(rk, err, reason)
    ccall(
        (:rd_kafka_test_fatal_error, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_t}, rd_kafka_resp_err_t, Ptr{Cchar}),
        rk,
        err,
        reason,
    )
end

function rd_kafka_error_code(error)
    ccall(
        (:rd_kafka_error_code, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_error_t},),
        error,
    )
end

function rd_kafka_error_name(error)
    ccall((:rd_kafka_error_name, librdkafka), Ptr{Cchar}, (Ptr{rd_kafka_error_t},), error)
end

function rd_kafka_error_string(error)
    ccall((:rd_kafka_error_string, librdkafka), Ptr{Cchar}, (Ptr{rd_kafka_error_t},), error)
end

function rd_kafka_error_is_fatal(error)
    ccall((:rd_kafka_error_is_fatal, librdkafka), Cint, (Ptr{rd_kafka_error_t},), error)
end

function rd_kafka_error_is_retriable(error)
    ccall((:rd_kafka_error_is_retriable, librdkafka), Cint, (Ptr{rd_kafka_error_t},), error)
end

function rd_kafka_error_txn_requires_abort(error)
    ccall(
        (:rd_kafka_error_txn_requires_abort, librdkafka),
        Cint,
        (Ptr{rd_kafka_error_t},),
        error,
    )
end

function rd_kafka_error_destroy(error)
    ccall((:rd_kafka_error_destroy, librdkafka), Cvoid, (Ptr{rd_kafka_error_t},), error)
end

struct rd_kafka_topic_partition_s
    topic::Ptr{Cchar}
    partition::Int32
    offset::Int64
    metadata::Ptr{Cvoid}
    metadata_size::Csize_t
    opaque::Ptr{Cvoid}
    err::rd_kafka_resp_err_t
    _private::Ptr{Cvoid}
end

const rd_kafka_topic_partition_t = rd_kafka_topic_partition_s

function rd_kafka_topic_partition_destroy(rktpar)
    ccall(
        (:rd_kafka_topic_partition_destroy, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_topic_partition_t},),
        rktpar,
    )
end

function rd_kafka_topic_partition_set_leader_epoch(rktpar, leader_epoch)
    ccall(
        (:rd_kafka_topic_partition_set_leader_epoch, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_topic_partition_t}, Int32),
        rktpar,
        leader_epoch,
    )
end

function rd_kafka_topic_partition_get_leader_epoch(rktpar)
    ccall(
        (:rd_kafka_topic_partition_get_leader_epoch, librdkafka),
        Int32,
        (Ptr{rd_kafka_topic_partition_t},),
        rktpar,
    )
end

struct rd_kafka_topic_partition_list_s
    cnt::Cint
    size::Cint
    elems::Ptr{rd_kafka_topic_partition_t}
end

const rd_kafka_topic_partition_list_t = rd_kafka_topic_partition_list_s

function rd_kafka_topic_partition_list_new(size)
    ccall(
        (:rd_kafka_topic_partition_list_new, librdkafka),
        Ptr{rd_kafka_topic_partition_list_t},
        (Cint,),
        size,
    )
end

function rd_kafka_topic_partition_list_destroy(rkparlist)
    ccall(
        (:rd_kafka_topic_partition_list_destroy, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_topic_partition_list_t},),
        rkparlist,
    )
end

function rd_kafka_topic_partition_list_add(rktparlist, topic, partition)
    ccall(
        (:rd_kafka_topic_partition_list_add, librdkafka),
        Ptr{rd_kafka_topic_partition_t},
        (Ptr{rd_kafka_topic_partition_list_t}, Ptr{Cchar}, Int32),
        rktparlist,
        topic,
        partition,
    )
end

function rd_kafka_topic_partition_list_add_range(rktparlist, topic, start, stop)
    ccall(
        (:rd_kafka_topic_partition_list_add_range, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_topic_partition_list_t}, Ptr{Cchar}, Int32, Int32),
        rktparlist,
        topic,
        start,
        stop,
    )
end

function rd_kafka_topic_partition_list_del(rktparlist, topic, partition)
    ccall(
        (:rd_kafka_topic_partition_list_del, librdkafka),
        Cint,
        (Ptr{rd_kafka_topic_partition_list_t}, Ptr{Cchar}, Int32),
        rktparlist,
        topic,
        partition,
    )
end

function rd_kafka_topic_partition_list_del_by_idx(rktparlist, idx)
    ccall(
        (:rd_kafka_topic_partition_list_del_by_idx, librdkafka),
        Cint,
        (Ptr{rd_kafka_topic_partition_list_t}, Cint),
        rktparlist,
        idx,
    )
end

function rd_kafka_topic_partition_list_copy(src)
    ccall(
        (:rd_kafka_topic_partition_list_copy, librdkafka),
        Ptr{rd_kafka_topic_partition_list_t},
        (Ptr{rd_kafka_topic_partition_list_t},),
        src,
    )
end

function rd_kafka_topic_partition_list_set_offset(rktparlist, topic, partition, offset)
    ccall(
        (:rd_kafka_topic_partition_list_set_offset, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_topic_partition_list_t}, Ptr{Cchar}, Int32, Int64),
        rktparlist,
        topic,
        partition,
        offset,
    )
end

function rd_kafka_topic_partition_list_find(rktparlist, topic, partition)
    ccall(
        (:rd_kafka_topic_partition_list_find, librdkafka),
        Ptr{rd_kafka_topic_partition_t},
        (Ptr{rd_kafka_topic_partition_list_t}, Ptr{Cchar}, Int32),
        rktparlist,
        topic,
        partition,
    )
end

function rd_kafka_topic_partition_list_sort(rktparlist, cmp, cmp_opaque)
    ccall(
        (:rd_kafka_topic_partition_list_sort, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_topic_partition_list_t}, Ptr{Cvoid}, Ptr{Cvoid}),
        rktparlist,
        cmp,
        cmp_opaque,
    )
end

@cenum rd_kafka_vtype_t::UInt32 begin
    RD_KAFKA_VTYPE_END = 0
    RD_KAFKA_VTYPE_TOPIC = 1
    RD_KAFKA_VTYPE_RKT = 2
    RD_KAFKA_VTYPE_PARTITION = 3
    RD_KAFKA_VTYPE_VALUE = 4
    RD_KAFKA_VTYPE_KEY = 5
    RD_KAFKA_VTYPE_OPAQUE = 6
    RD_KAFKA_VTYPE_MSGFLAGS = 7
    RD_KAFKA_VTYPE_TIMESTAMP = 8
    RD_KAFKA_VTYPE_HEADER = 9
    RD_KAFKA_VTYPE_HEADERS = 10
end

struct var"##Ctag#232"
    data::NTuple{64,UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#232"}, f::Symbol)
    f === :cstr && return Ptr{Ptr{Cchar}}(x + 0)
    f === :rkt && return Ptr{Ptr{rd_kafka_topic_t}}(x + 0)
    f === :i && return Ptr{Cint}(x + 0)
    f === :i32 && return Ptr{Int32}(x + 0)
    f === :i64 && return Ptr{Int64}(x + 0)
    f === :mem && return Ptr{var"##Ctag#233"}(x + 0)
    f === :header && return Ptr{var"##Ctag#234"}(x + 0)
    f === :headers && return Ptr{Ptr{rd_kafka_headers_t}}(x + 0)
    f === :ptr && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :_pad && return Ptr{NTuple{64,Cchar}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#232", f::Symbol)
    r = Ref{var"##Ctag#232"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#232"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#232"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct rd_kafka_vu_s
    data::NTuple{72,UInt8}
end

function Base.getproperty(x::Ptr{rd_kafka_vu_s}, f::Symbol)
    f === :vtype && return Ptr{rd_kafka_vtype_t}(x + 0)
    f === :u && return Ptr{var"##Ctag#232"}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::rd_kafka_vu_s, f::Symbol)
    r = Ref{rd_kafka_vu_s}(x)
    ptr = Base.unsafe_convert(Ptr{rd_kafka_vu_s}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{rd_kafka_vu_s}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const rd_kafka_vu_t = rd_kafka_vu_s

function rd_kafka_headers_new(initial_count)
    ccall(
        (:rd_kafka_headers_new, librdkafka),
        Ptr{rd_kafka_headers_t},
        (Csize_t,),
        initial_count,
    )
end

function rd_kafka_headers_destroy(hdrs)
    ccall((:rd_kafka_headers_destroy, librdkafka), Cvoid, (Ptr{rd_kafka_headers_t},), hdrs)
end

function rd_kafka_headers_copy(src)
    ccall(
        (:rd_kafka_headers_copy, librdkafka),
        Ptr{rd_kafka_headers_t},
        (Ptr{rd_kafka_headers_t},),
        src,
    )
end

function rd_kafka_header_add(hdrs, name, name_size, value, value_size)
    ccall(
        (:rd_kafka_header_add, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_headers_t}, Ptr{Cchar}, Cssize_t, Ptr{Cvoid}, Cssize_t),
        hdrs,
        name,
        name_size,
        value,
        value_size,
    )
end

function rd_kafka_header_remove(hdrs, name)
    ccall(
        (:rd_kafka_header_remove, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_headers_t}, Ptr{Cchar}),
        hdrs,
        name,
    )
end

function rd_kafka_header_get_last(hdrs, name, valuep, sizep)
    ccall(
        (:rd_kafka_header_get_last, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_headers_t}, Ptr{Cchar}, Ptr{Ptr{Cvoid}}, Ptr{Csize_t}),
        hdrs,
        name,
        valuep,
        sizep,
    )
end

function rd_kafka_header_get(hdrs, idx, name, valuep, sizep)
    ccall(
        (:rd_kafka_header_get, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_headers_t}, Csize_t, Ptr{Cchar}, Ptr{Ptr{Cvoid}}, Ptr{Csize_t}),
        hdrs,
        idx,
        name,
        valuep,
        sizep,
    )
end

function rd_kafka_header_get_all(hdrs, idx, namep, valuep, sizep)
    ccall(
        (:rd_kafka_header_get_all, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_headers_t}, Csize_t, Ptr{Ptr{Cchar}}, Ptr{Ptr{Cvoid}}, Ptr{Csize_t}),
        hdrs,
        idx,
        namep,
        valuep,
        sizep,
    )
end

struct rd_kafka_message_s
    err::rd_kafka_resp_err_t
    rkt::Ptr{rd_kafka_topic_t}
    partition::Int32
    payload::Ptr{Cvoid}
    len::Csize_t
    key::Ptr{Cvoid}
    key_len::Csize_t
    offset::Int64
    _private::Ptr{Cvoid}
end

const rd_kafka_message_t = rd_kafka_message_s

function rd_kafka_message_destroy(rkmessage)
    ccall(
        (:rd_kafka_message_destroy, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_message_t},),
        rkmessage,
    )
end

function rd_kafka_message_errstr(rkmessage)
    ccall(
        (:rd_kafka_message_errstr, librdkafka),
        Ptr{Cchar},
        (Ptr{rd_kafka_message_t},),
        rkmessage,
    )
end

function rd_kafka_message_timestamp(rkmessage, tstype)
    ccall(
        (:rd_kafka_message_timestamp, librdkafka),
        Int64,
        (Ptr{rd_kafka_message_t}, Ptr{rd_kafka_timestamp_type_t}),
        rkmessage,
        tstype,
    )
end

function rd_kafka_message_latency(rkmessage)
    ccall(
        (:rd_kafka_message_latency, librdkafka),
        Int64,
        (Ptr{rd_kafka_message_t},),
        rkmessage,
    )
end

function rd_kafka_message_broker_id(rkmessage)
    ccall(
        (:rd_kafka_message_broker_id, librdkafka),
        Int32,
        (Ptr{rd_kafka_message_t},),
        rkmessage,
    )
end

function rd_kafka_message_headers(rkmessage, hdrsp)
    ccall(
        (:rd_kafka_message_headers, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_message_t}, Ptr{Ptr{rd_kafka_headers_t}}),
        rkmessage,
        hdrsp,
    )
end

function rd_kafka_message_detach_headers(rkmessage, hdrsp)
    ccall(
        (:rd_kafka_message_detach_headers, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_message_t}, Ptr{Ptr{rd_kafka_headers_t}}),
        rkmessage,
        hdrsp,
    )
end

function rd_kafka_message_set_headers(rkmessage, hdrs)
    ccall(
        (:rd_kafka_message_set_headers, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_message_t}, Ptr{rd_kafka_headers_t}),
        rkmessage,
        hdrs,
    )
end

function rd_kafka_header_cnt(hdrs)
    ccall((:rd_kafka_header_cnt, librdkafka), Csize_t, (Ptr{rd_kafka_headers_t},), hdrs)
end

@cenum rd_kafka_msg_status_t::UInt32 begin
    RD_KAFKA_MSG_STATUS_NOT_PERSISTED = 0
    RD_KAFKA_MSG_STATUS_POSSIBLY_PERSISTED = 1
    RD_KAFKA_MSG_STATUS_PERSISTED = 2
end

function rd_kafka_message_status(rkmessage)
    ccall(
        (:rd_kafka_message_status, librdkafka),
        rd_kafka_msg_status_t,
        (Ptr{rd_kafka_message_t},),
        rkmessage,
    )
end

function rd_kafka_message_leader_epoch(rkmessage)
    ccall(
        (:rd_kafka_message_leader_epoch, librdkafka),
        Int32,
        (Ptr{rd_kafka_message_t},),
        rkmessage,
    )
end

function rd_kafka_Uuid_base64str(uuid)
    ccall((:rd_kafka_Uuid_base64str, librdkafka), Ptr{Cchar}, (Ptr{rd_kafka_Uuid_t},), uuid)
end

function rd_kafka_Uuid_least_significant_bits(uuid)
    ccall(
        (:rd_kafka_Uuid_least_significant_bits, librdkafka),
        Int64,
        (Ptr{rd_kafka_Uuid_t},),
        uuid,
    )
end

function rd_kafka_Uuid_most_significant_bits(uuid)
    ccall(
        (:rd_kafka_Uuid_most_significant_bits, librdkafka),
        Int64,
        (Ptr{rd_kafka_Uuid_t},),
        uuid,
    )
end

function rd_kafka_Uuid_new(most_significant_bits, least_significant_bits)
    ccall(
        (:rd_kafka_Uuid_new, librdkafka),
        Ptr{rd_kafka_Uuid_t},
        (Int64, Int64),
        most_significant_bits,
        least_significant_bits,
    )
end

function rd_kafka_Uuid_copy(uuid)
    ccall(
        (:rd_kafka_Uuid_copy, librdkafka),
        Ptr{rd_kafka_Uuid_t},
        (Ptr{rd_kafka_Uuid_t},),
        uuid,
    )
end

function rd_kafka_Uuid_destroy(uuid)
    ccall((:rd_kafka_Uuid_destroy, librdkafka), Cvoid, (Ptr{rd_kafka_Uuid_t},), uuid)
end

@cenum rd_kafka_conf_res_t::Int32 begin
    RD_KAFKA_CONF_UNKNOWN = -2
    RD_KAFKA_CONF_INVALID = -1
    RD_KAFKA_CONF_OK = 0
end

function rd_kafka_conf_new()
    ccall((:rd_kafka_conf_new, librdkafka), Ptr{rd_kafka_conf_t}, ())
end

function rd_kafka_conf_destroy(conf)
    ccall((:rd_kafka_conf_destroy, librdkafka), Cvoid, (Ptr{rd_kafka_conf_t},), conf)
end

function rd_kafka_conf_dup(conf)
    ccall(
        (:rd_kafka_conf_dup, librdkafka),
        Ptr{rd_kafka_conf_t},
        (Ptr{rd_kafka_conf_t},),
        conf,
    )
end

function rd_kafka_conf_dup_filter(conf, filter_cnt, filter)
    ccall(
        (:rd_kafka_conf_dup_filter, librdkafka),
        Ptr{rd_kafka_conf_t},
        (Ptr{rd_kafka_conf_t}, Csize_t, Ptr{Ptr{Cchar}}),
        conf,
        filter_cnt,
        filter,
    )
end

function rd_kafka_conf(rk)
    ccall((:rd_kafka_conf, librdkafka), Ptr{rd_kafka_conf_t}, (Ptr{rd_kafka_t},), rk)
end

function rd_kafka_conf_set(conf, name, value, errstr, errstr_size)
    ccall(
        (:rd_kafka_conf_set, librdkafka),
        rd_kafka_conf_res_t,
        (Ptr{rd_kafka_conf_t}, Ptr{Cchar}, Ptr{Cchar}, Ptr{Cchar}, Csize_t),
        conf,
        name,
        value,
        errstr,
        errstr_size,
    )
end

function rd_kafka_conf_set_events(conf, events)
    ccall(
        (:rd_kafka_conf_set_events, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_conf_t}, Cint),
        conf,
        events,
    )
end

function rd_kafka_conf_set_background_event_cb(conf, event_cb)
    ccall(
        (:rd_kafka_conf_set_background_event_cb, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_conf_t}, Ptr{Cvoid}),
        conf,
        event_cb,
    )
end

function rd_kafka_conf_set_dr_cb(conf, dr_cb)
    ccall(
        (:rd_kafka_conf_set_dr_cb, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_conf_t}, Ptr{Cvoid}),
        conf,
        dr_cb,
    )
end

function rd_kafka_conf_set_dr_msg_cb(conf, dr_msg_cb)
    ccall(
        (:rd_kafka_conf_set_dr_msg_cb, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_conf_t}, Ptr{Cvoid}),
        conf,
        dr_msg_cb,
    )
end

function rd_kafka_conf_set_consume_cb(conf, consume_cb)
    ccall(
        (:rd_kafka_conf_set_consume_cb, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_conf_t}, Ptr{Cvoid}),
        conf,
        consume_cb,
    )
end

function rd_kafka_conf_set_rebalance_cb(conf, rebalance_cb)
    ccall(
        (:rd_kafka_conf_set_rebalance_cb, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_conf_t}, Ptr{Cvoid}),
        conf,
        rebalance_cb,
    )
end

function rd_kafka_conf_set_offset_commit_cb(conf, offset_commit_cb)
    ccall(
        (:rd_kafka_conf_set_offset_commit_cb, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_conf_t}, Ptr{Cvoid}),
        conf,
        offset_commit_cb,
    )
end

function rd_kafka_conf_set_error_cb(conf, error_cb)
    ccall(
        (:rd_kafka_conf_set_error_cb, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_conf_t}, Ptr{Cvoid}),
        conf,
        error_cb,
    )
end

function rd_kafka_conf_set_throttle_cb(conf, throttle_cb)
    ccall(
        (:rd_kafka_conf_set_throttle_cb, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_conf_t}, Ptr{Cvoid}),
        conf,
        throttle_cb,
    )
end

function rd_kafka_conf_set_log_cb(conf, log_cb)
    ccall(
        (:rd_kafka_conf_set_log_cb, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_conf_t}, Ptr{Cvoid}),
        conf,
        log_cb,
    )
end

function rd_kafka_conf_set_stats_cb(conf, stats_cb)
    ccall(
        (:rd_kafka_conf_set_stats_cb, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_conf_t}, Ptr{Cvoid}),
        conf,
        stats_cb,
    )
end

function rd_kafka_conf_set_oauthbearer_token_refresh_cb(conf, oauthbearer_token_refresh_cb)
    ccall(
        (:rd_kafka_conf_set_oauthbearer_token_refresh_cb, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_conf_t}, Ptr{Cvoid}),
        conf,
        oauthbearer_token_refresh_cb,
    )
end

function rd_kafka_conf_enable_sasl_queue(conf, enable)
    ccall(
        (:rd_kafka_conf_enable_sasl_queue, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_conf_t}, Cint),
        conf,
        enable,
    )
end

function rd_kafka_conf_set_socket_cb(conf, socket_cb)
    ccall(
        (:rd_kafka_conf_set_socket_cb, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_conf_t}, Ptr{Cvoid}),
        conf,
        socket_cb,
    )
end

function rd_kafka_conf_set_connect_cb(conf, connect_cb)
    ccall(
        (:rd_kafka_conf_set_connect_cb, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_conf_t}, Ptr{Cvoid}),
        conf,
        connect_cb,
    )
end

function rd_kafka_conf_set_closesocket_cb(conf, closesocket_cb)
    ccall(
        (:rd_kafka_conf_set_closesocket_cb, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_conf_t}, Ptr{Cvoid}),
        conf,
        closesocket_cb,
    )
end

function rd_kafka_conf_set_open_cb(conf, open_cb)
    ccall(
        (:rd_kafka_conf_set_open_cb, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_conf_t}, Ptr{Cvoid}),
        conf,
        open_cb,
    )
end

mutable struct addrinfo end

function rd_kafka_conf_set_resolve_cb(conf, resolve_cb)
    ccall(
        (:rd_kafka_conf_set_resolve_cb, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_conf_t}, Ptr{Cvoid}),
        conf,
        resolve_cb,
    )
end

function rd_kafka_conf_set_ssl_cert_verify_cb(conf, ssl_cert_verify_cb)
    ccall(
        (:rd_kafka_conf_set_ssl_cert_verify_cb, librdkafka),
        rd_kafka_conf_res_t,
        (Ptr{rd_kafka_conf_t}, Ptr{Cvoid}),
        conf,
        ssl_cert_verify_cb,
    )
end

@cenum rd_kafka_cert_type_t::UInt32 begin
    RD_KAFKA_CERT_PUBLIC_KEY = 0
    RD_KAFKA_CERT_PRIVATE_KEY = 1
    RD_KAFKA_CERT_CA = 2
    RD_KAFKA_CERT__CNT = 3
end

@cenum rd_kafka_cert_enc_t::UInt32 begin
    RD_KAFKA_CERT_ENC_PKCS12 = 0
    RD_KAFKA_CERT_ENC_DER = 1
    RD_KAFKA_CERT_ENC_PEM = 2
    RD_KAFKA_CERT_ENC__CNT = 3
end

function rd_kafka_conf_set_ssl_cert(
    conf,
    cert_type,
    cert_enc,
    buffer,
    size,
    errstr,
    errstr_size,
)
    ccall(
        (:rd_kafka_conf_set_ssl_cert, librdkafka),
        rd_kafka_conf_res_t,
        (
            Ptr{rd_kafka_conf_t},
            rd_kafka_cert_type_t,
            rd_kafka_cert_enc_t,
            Ptr{Cvoid},
            Csize_t,
            Ptr{Cchar},
            Csize_t,
        ),
        conf,
        cert_type,
        cert_enc,
        buffer,
        size,
        errstr,
        errstr_size,
    )
end

function rd_kafka_conf_set_engine_callback_data(conf, callback_data)
    ccall(
        (:rd_kafka_conf_set_engine_callback_data, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_conf_t}, Ptr{Cvoid}),
        conf,
        callback_data,
    )
end

function rd_kafka_conf_set_opaque(conf, opaque)
    ccall(
        (:rd_kafka_conf_set_opaque, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_conf_t}, Ptr{Cvoid}),
        conf,
        opaque,
    )
end

function rd_kafka_opaque(rk)
    ccall((:rd_kafka_opaque, librdkafka), Ptr{Cvoid}, (Ptr{rd_kafka_t},), rk)
end

function rd_kafka_conf_set_default_topic_conf(conf, tconf)
    ccall(
        (:rd_kafka_conf_set_default_topic_conf, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_conf_t}, Ptr{rd_kafka_topic_conf_t}),
        conf,
        tconf,
    )
end

function rd_kafka_conf_get_default_topic_conf(conf)
    ccall(
        (:rd_kafka_conf_get_default_topic_conf, librdkafka),
        Ptr{rd_kafka_topic_conf_t},
        (Ptr{rd_kafka_conf_t},),
        conf,
    )
end

function rd_kafka_conf_get(conf, name, dest, dest_size)
    ccall(
        (:rd_kafka_conf_get, librdkafka),
        rd_kafka_conf_res_t,
        (Ptr{rd_kafka_conf_t}, Ptr{Cchar}, Ptr{Cchar}, Ptr{Csize_t}),
        conf,
        name,
        dest,
        dest_size,
    )
end

function rd_kafka_topic_conf_get(conf, name, dest, dest_size)
    ccall(
        (:rd_kafka_topic_conf_get, librdkafka),
        rd_kafka_conf_res_t,
        (Ptr{rd_kafka_topic_conf_t}, Ptr{Cchar}, Ptr{Cchar}, Ptr{Csize_t}),
        conf,
        name,
        dest,
        dest_size,
    )
end

function rd_kafka_conf_dump(conf, cntp)
    ccall(
        (:rd_kafka_conf_dump, librdkafka),
        Ptr{Ptr{Cchar}},
        (Ptr{rd_kafka_conf_t}, Ptr{Csize_t}),
        conf,
        cntp,
    )
end

function rd_kafka_topic_conf_dump(conf, cntp)
    ccall(
        (:rd_kafka_topic_conf_dump, librdkafka),
        Ptr{Ptr{Cchar}},
        (Ptr{rd_kafka_topic_conf_t}, Ptr{Csize_t}),
        conf,
        cntp,
    )
end

function rd_kafka_conf_dump_free(arr, cnt)
    ccall(
        (:rd_kafka_conf_dump_free, librdkafka),
        Cvoid,
        (Ptr{Ptr{Cchar}}, Csize_t),
        arr,
        cnt,
    )
end

function rd_kafka_conf_properties_show(fp)
    ccall((:rd_kafka_conf_properties_show, librdkafka), Cvoid, (Ptr{Libc.FILE},), fp)
end

function rd_kafka_topic_conf_new()
    ccall((:rd_kafka_topic_conf_new, librdkafka), Ptr{rd_kafka_topic_conf_t}, ())
end

function rd_kafka_topic_conf_dup(conf)
    ccall(
        (:rd_kafka_topic_conf_dup, librdkafka),
        Ptr{rd_kafka_topic_conf_t},
        (Ptr{rd_kafka_topic_conf_t},),
        conf,
    )
end

function rd_kafka_default_topic_conf_dup(rk)
    ccall(
        (:rd_kafka_default_topic_conf_dup, librdkafka),
        Ptr{rd_kafka_topic_conf_t},
        (Ptr{rd_kafka_t},),
        rk,
    )
end

function rd_kafka_topic_conf_destroy(topic_conf)
    ccall(
        (:rd_kafka_topic_conf_destroy, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_topic_conf_t},),
        topic_conf,
    )
end

function rd_kafka_topic_conf_set(conf, name, value, errstr, errstr_size)
    ccall(
        (:rd_kafka_topic_conf_set, librdkafka),
        rd_kafka_conf_res_t,
        (Ptr{rd_kafka_topic_conf_t}, Ptr{Cchar}, Ptr{Cchar}, Ptr{Cchar}, Csize_t),
        conf,
        name,
        value,
        errstr,
        errstr_size,
    )
end

function rd_kafka_topic_conf_set_opaque(conf, rkt_opaque)
    ccall(
        (:rd_kafka_topic_conf_set_opaque, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_topic_conf_t}, Ptr{Cvoid}),
        conf,
        rkt_opaque,
    )
end

function rd_kafka_topic_conf_set_partitioner_cb(topic_conf, partitioner)
    ccall(
        (:rd_kafka_topic_conf_set_partitioner_cb, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_topic_conf_t}, Ptr{Cvoid}),
        topic_conf,
        partitioner,
    )
end

function rd_kafka_topic_conf_set_msg_order_cmp(topic_conf, msg_order_cmp)
    ccall(
        (:rd_kafka_topic_conf_set_msg_order_cmp, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_topic_conf_t}, Ptr{Cvoid}),
        topic_conf,
        msg_order_cmp,
    )
end

function rd_kafka_topic_partition_available(rkt, partition)
    ccall(
        (:rd_kafka_topic_partition_available, librdkafka),
        Cint,
        (Ptr{rd_kafka_topic_t}, Int32),
        rkt,
        partition,
    )
end

function rd_kafka_msg_partitioner_random(
    rkt,
    key,
    keylen,
    partition_cnt,
    rkt_opaque,
    msg_opaque,
)
    ccall(
        (:rd_kafka_msg_partitioner_random, librdkafka),
        Int32,
        (Ptr{rd_kafka_topic_t}, Ptr{Cvoid}, Csize_t, Int32, Ptr{Cvoid}, Ptr{Cvoid}),
        rkt,
        key,
        keylen,
        partition_cnt,
        rkt_opaque,
        msg_opaque,
    )
end

function rd_kafka_msg_partitioner_consistent(
    rkt,
    key,
    keylen,
    partition_cnt,
    rkt_opaque,
    msg_opaque,
)
    ccall(
        (:rd_kafka_msg_partitioner_consistent, librdkafka),
        Int32,
        (Ptr{rd_kafka_topic_t}, Ptr{Cvoid}, Csize_t, Int32, Ptr{Cvoid}, Ptr{Cvoid}),
        rkt,
        key,
        keylen,
        partition_cnt,
        rkt_opaque,
        msg_opaque,
    )
end

function rd_kafka_msg_partitioner_consistent_random(
    rkt,
    key,
    keylen,
    partition_cnt,
    rkt_opaque,
    msg_opaque,
)
    ccall(
        (:rd_kafka_msg_partitioner_consistent_random, librdkafka),
        Int32,
        (Ptr{rd_kafka_topic_t}, Ptr{Cvoid}, Csize_t, Int32, Ptr{Cvoid}, Ptr{Cvoid}),
        rkt,
        key,
        keylen,
        partition_cnt,
        rkt_opaque,
        msg_opaque,
    )
end

function rd_kafka_msg_partitioner_murmur2(
    rkt,
    key,
    keylen,
    partition_cnt,
    rkt_opaque,
    msg_opaque,
)
    ccall(
        (:rd_kafka_msg_partitioner_murmur2, librdkafka),
        Int32,
        (Ptr{rd_kafka_topic_t}, Ptr{Cvoid}, Csize_t, Int32, Ptr{Cvoid}, Ptr{Cvoid}),
        rkt,
        key,
        keylen,
        partition_cnt,
        rkt_opaque,
        msg_opaque,
    )
end

function rd_kafka_msg_partitioner_murmur2_random(
    rkt,
    key,
    keylen,
    partition_cnt,
    rkt_opaque,
    msg_opaque,
)
    ccall(
        (:rd_kafka_msg_partitioner_murmur2_random, librdkafka),
        Int32,
        (Ptr{rd_kafka_topic_t}, Ptr{Cvoid}, Csize_t, Int32, Ptr{Cvoid}, Ptr{Cvoid}),
        rkt,
        key,
        keylen,
        partition_cnt,
        rkt_opaque,
        msg_opaque,
    )
end

function rd_kafka_msg_partitioner_fnv1a(
    rkt,
    key,
    keylen,
    partition_cnt,
    rkt_opaque,
    msg_opaque,
)
    ccall(
        (:rd_kafka_msg_partitioner_fnv1a, librdkafka),
        Int32,
        (Ptr{rd_kafka_topic_t}, Ptr{Cvoid}, Csize_t, Int32, Ptr{Cvoid}, Ptr{Cvoid}),
        rkt,
        key,
        keylen,
        partition_cnt,
        rkt_opaque,
        msg_opaque,
    )
end

function rd_kafka_msg_partitioner_fnv1a_random(
    rkt,
    key,
    keylen,
    partition_cnt,
    rkt_opaque,
    msg_opaque,
)
    ccall(
        (:rd_kafka_msg_partitioner_fnv1a_random, librdkafka),
        Int32,
        (Ptr{rd_kafka_topic_t}, Ptr{Cvoid}, Csize_t, Int32, Ptr{Cvoid}, Ptr{Cvoid}),
        rkt,
        key,
        keylen,
        partition_cnt,
        rkt_opaque,
        msg_opaque,
    )
end

function rd_kafka_new(type, conf, errstr, errstr_size)
    ccall(
        (:rd_kafka_new, librdkafka),
        Ptr{rd_kafka_t},
        (rd_kafka_type_t, Ptr{rd_kafka_conf_t}, Ptr{Cchar}, Csize_t),
        type,
        conf,
        errstr,
        errstr_size,
    )
end

function rd_kafka_destroy(rk)
    ccall((:rd_kafka_destroy, librdkafka), Cvoid, (Ptr{rd_kafka_t},), rk)
end

function rd_kafka_destroy_flags(rk, flags)
    ccall((:rd_kafka_destroy_flags, librdkafka), Cvoid, (Ptr{rd_kafka_t}, Cint), rk, flags)
end

function rd_kafka_name(rk)
    ccall((:rd_kafka_name, librdkafka), Ptr{Cchar}, (Ptr{rd_kafka_t},), rk)
end

function rd_kafka_type(rk)
    ccall((:rd_kafka_type, librdkafka), rd_kafka_type_t, (Ptr{rd_kafka_t},), rk)
end

function rd_kafka_memberid(rk)
    ccall((:rd_kafka_memberid, librdkafka), Ptr{Cchar}, (Ptr{rd_kafka_t},), rk)
end

function rd_kafka_clusterid(rk, timeout_ms)
    ccall(
        (:rd_kafka_clusterid, librdkafka),
        Ptr{Cchar},
        (Ptr{rd_kafka_t}, Cint),
        rk,
        timeout_ms,
    )
end

function rd_kafka_controllerid(rk, timeout_ms)
    ccall(
        (:rd_kafka_controllerid, librdkafka),
        Int32,
        (Ptr{rd_kafka_t}, Cint),
        rk,
        timeout_ms,
    )
end

function rd_kafka_topic_new(rk, topic, conf)
    ccall(
        (:rd_kafka_topic_new, librdkafka),
        Ptr{rd_kafka_topic_t},
        (Ptr{rd_kafka_t}, Ptr{Cchar}, Ptr{rd_kafka_topic_conf_t}),
        rk,
        topic,
        conf,
    )
end

function rd_kafka_topic_destroy(rkt)
    ccall((:rd_kafka_topic_destroy, librdkafka), Cvoid, (Ptr{rd_kafka_topic_t},), rkt)
end

function rd_kafka_topic_name(rkt)
    ccall((:rd_kafka_topic_name, librdkafka), Ptr{Cchar}, (Ptr{rd_kafka_topic_t},), rkt)
end

function rd_kafka_topic_opaque(rkt)
    ccall((:rd_kafka_topic_opaque, librdkafka), Ptr{Cvoid}, (Ptr{rd_kafka_topic_t},), rkt)
end

function rd_kafka_poll(rk, timeout_ms)
    ccall((:rd_kafka_poll, librdkafka), Cint, (Ptr{rd_kafka_t}, Cint), rk, timeout_ms)
end

function rd_kafka_yield(rk)
    ccall((:rd_kafka_yield, librdkafka), Cvoid, (Ptr{rd_kafka_t},), rk)
end

function rd_kafka_pause_partitions(rk, partitions)
    ccall(
        (:rd_kafka_pause_partitions, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_t}, Ptr{rd_kafka_topic_partition_list_t}),
        rk,
        partitions,
    )
end

function rd_kafka_resume_partitions(rk, partitions)
    ccall(
        (:rd_kafka_resume_partitions, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_t}, Ptr{rd_kafka_topic_partition_list_t}),
        rk,
        partitions,
    )
end

function rd_kafka_query_watermark_offsets(rk, topic, partition, low, high, timeout_ms)
    ccall(
        (:rd_kafka_query_watermark_offsets, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_t}, Ptr{Cchar}, Int32, Ptr{Int64}, Ptr{Int64}, Cint),
        rk,
        topic,
        partition,
        low,
        high,
        timeout_ms,
    )
end

function rd_kafka_get_watermark_offsets(rk, topic, partition, low, high)
    ccall(
        (:rd_kafka_get_watermark_offsets, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_t}, Ptr{Cchar}, Int32, Ptr{Int64}, Ptr{Int64}),
        rk,
        topic,
        partition,
        low,
        high,
    )
end

function rd_kafka_offsets_for_times(rk, offsets, timeout_ms)
    ccall(
        (:rd_kafka_offsets_for_times, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_t}, Ptr{rd_kafka_topic_partition_list_t}, Cint),
        rk,
        offsets,
        timeout_ms,
    )
end

function rd_kafka_mem_calloc(rk, num, size)
    ccall(
        (:rd_kafka_mem_calloc, librdkafka),
        Ptr{Cvoid},
        (Ptr{rd_kafka_t}, Csize_t, Csize_t),
        rk,
        num,
        size,
    )
end

function rd_kafka_mem_malloc(rk, size)
    ccall(
        (:rd_kafka_mem_malloc, librdkafka),
        Ptr{Cvoid},
        (Ptr{rd_kafka_t}, Csize_t),
        rk,
        size,
    )
end

function rd_kafka_mem_free(rk, ptr)
    ccall((:rd_kafka_mem_free, librdkafka), Cvoid, (Ptr{rd_kafka_t}, Ptr{Cvoid}), rk, ptr)
end

function rd_kafka_queue_new(rk)
    ccall((:rd_kafka_queue_new, librdkafka), Ptr{rd_kafka_queue_t}, (Ptr{rd_kafka_t},), rk)
end

function rd_kafka_queue_destroy(rkqu)
    ccall((:rd_kafka_queue_destroy, librdkafka), Cvoid, (Ptr{rd_kafka_queue_t},), rkqu)
end

function rd_kafka_queue_get_main(rk)
    ccall(
        (:rd_kafka_queue_get_main, librdkafka),
        Ptr{rd_kafka_queue_t},
        (Ptr{rd_kafka_t},),
        rk,
    )
end

function rd_kafka_queue_get_sasl(rk)
    ccall(
        (:rd_kafka_queue_get_sasl, librdkafka),
        Ptr{rd_kafka_queue_t},
        (Ptr{rd_kafka_t},),
        rk,
    )
end

function rd_kafka_sasl_background_callbacks_enable(rk)
    ccall(
        (:rd_kafka_sasl_background_callbacks_enable, librdkafka),
        Ptr{rd_kafka_error_t},
        (Ptr{rd_kafka_t},),
        rk,
    )
end

function rd_kafka_sasl_set_credentials(rk, username, password)
    ccall(
        (:rd_kafka_sasl_set_credentials, librdkafka),
        Ptr{rd_kafka_error_t},
        (Ptr{rd_kafka_t}, Ptr{Cchar}, Ptr{Cchar}),
        rk,
        username,
        password,
    )
end

function rd_kafka_queue_get_consumer(rk)
    ccall(
        (:rd_kafka_queue_get_consumer, librdkafka),
        Ptr{rd_kafka_queue_t},
        (Ptr{rd_kafka_t},),
        rk,
    )
end

function rd_kafka_queue_get_partition(rk, topic, partition)
    ccall(
        (:rd_kafka_queue_get_partition, librdkafka),
        Ptr{rd_kafka_queue_t},
        (Ptr{rd_kafka_t}, Ptr{Cchar}, Int32),
        rk,
        topic,
        partition,
    )
end

function rd_kafka_queue_get_background(rk)
    ccall(
        (:rd_kafka_queue_get_background, librdkafka),
        Ptr{rd_kafka_queue_t},
        (Ptr{rd_kafka_t},),
        rk,
    )
end

function rd_kafka_queue_forward(src, dst)
    ccall(
        (:rd_kafka_queue_forward, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_queue_t}, Ptr{rd_kafka_queue_t}),
        src,
        dst,
    )
end

function rd_kafka_set_log_queue(rk, rkqu)
    ccall(
        (:rd_kafka_set_log_queue, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_t}, Ptr{rd_kafka_queue_t}),
        rk,
        rkqu,
    )
end

function rd_kafka_queue_length(rkqu)
    ccall((:rd_kafka_queue_length, librdkafka), Csize_t, (Ptr{rd_kafka_queue_t},), rkqu)
end

function rd_kafka_queue_io_event_enable(rkqu, fd, payload, size)
    ccall(
        (:rd_kafka_queue_io_event_enable, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_queue_t}, Cint, Ptr{Cvoid}, Csize_t),
        rkqu,
        fd,
        payload,
        size,
    )
end

function rd_kafka_queue_cb_event_enable(rkqu, event_cb, qev_opaque)
    ccall(
        (:rd_kafka_queue_cb_event_enable, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_queue_t}, Ptr{Cvoid}, Ptr{Cvoid}),
        rkqu,
        event_cb,
        qev_opaque,
    )
end

function rd_kafka_queue_yield(rkqu)
    ccall((:rd_kafka_queue_yield, librdkafka), Cvoid, (Ptr{rd_kafka_queue_t},), rkqu)
end

function rd_kafka_consume_start(rkt, partition, offset)
    ccall(
        (:rd_kafka_consume_start, librdkafka),
        Cint,
        (Ptr{rd_kafka_topic_t}, Int32, Int64),
        rkt,
        partition,
        offset,
    )
end

function rd_kafka_consume_start_queue(rkt, partition, offset, rkqu)
    ccall(
        (:rd_kafka_consume_start_queue, librdkafka),
        Cint,
        (Ptr{rd_kafka_topic_t}, Int32, Int64, Ptr{rd_kafka_queue_t}),
        rkt,
        partition,
        offset,
        rkqu,
    )
end

function rd_kafka_consume_stop(rkt, partition)
    ccall(
        (:rd_kafka_consume_stop, librdkafka),
        Cint,
        (Ptr{rd_kafka_topic_t}, Int32),
        rkt,
        partition,
    )
end

function rd_kafka_seek(rkt, partition, offset, timeout_ms)
    ccall(
        (:rd_kafka_seek, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_topic_t}, Int32, Int64, Cint),
        rkt,
        partition,
        offset,
        timeout_ms,
    )
end

function rd_kafka_seek_partitions(rk, partitions, timeout_ms)
    ccall(
        (:rd_kafka_seek_partitions, librdkafka),
        Ptr{rd_kafka_error_t},
        (Ptr{rd_kafka_t}, Ptr{rd_kafka_topic_partition_list_t}, Cint),
        rk,
        partitions,
        timeout_ms,
    )
end

function rd_kafka_consume(rkt, partition, timeout_ms)
    ccall(
        (:rd_kafka_consume, librdkafka),
        Ptr{rd_kafka_message_t},
        (Ptr{rd_kafka_topic_t}, Int32, Cint),
        rkt,
        partition,
        timeout_ms,
    )
end

function rd_kafka_consume_batch(rkt, partition, timeout_ms, rkmessages, rkmessages_size)
    ccall(
        (:rd_kafka_consume_batch, librdkafka),
        Cssize_t,
        (Ptr{rd_kafka_topic_t}, Int32, Cint, Ptr{Ptr{rd_kafka_message_t}}, Csize_t),
        rkt,
        partition,
        timeout_ms,
        rkmessages,
        rkmessages_size,
    )
end

function rd_kafka_consume_callback(rkt, partition, timeout_ms, consume_cb, commit_opaque)
    ccall(
        (:rd_kafka_consume_callback, librdkafka),
        Cint,
        (Ptr{rd_kafka_topic_t}, Int32, Cint, Ptr{Cvoid}, Ptr{Cvoid}),
        rkt,
        partition,
        timeout_ms,
        consume_cb,
        commit_opaque,
    )
end

function rd_kafka_consume_queue(rkqu, timeout_ms)
    ccall(
        (:rd_kafka_consume_queue, librdkafka),
        Ptr{rd_kafka_message_t},
        (Ptr{rd_kafka_queue_t}, Cint),
        rkqu,
        timeout_ms,
    )
end

function rd_kafka_consume_batch_queue(rkqu, timeout_ms, rkmessages, rkmessages_size)
    ccall(
        (:rd_kafka_consume_batch_queue, librdkafka),
        Cssize_t,
        (Ptr{rd_kafka_queue_t}, Cint, Ptr{Ptr{rd_kafka_message_t}}, Csize_t),
        rkqu,
        timeout_ms,
        rkmessages,
        rkmessages_size,
    )
end

function rd_kafka_consume_callback_queue(rkqu, timeout_ms, consume_cb, commit_opaque)
    ccall(
        (:rd_kafka_consume_callback_queue, librdkafka),
        Cint,
        (Ptr{rd_kafka_queue_t}, Cint, Ptr{Cvoid}, Ptr{Cvoid}),
        rkqu,
        timeout_ms,
        consume_cb,
        commit_opaque,
    )
end

function rd_kafka_offset_store(rkt, partition, offset)
    ccall(
        (:rd_kafka_offset_store, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_topic_t}, Int32, Int64),
        rkt,
        partition,
        offset,
    )
end

function rd_kafka_offsets_store(rk, offsets)
    ccall(
        (:rd_kafka_offsets_store, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_t}, Ptr{rd_kafka_topic_partition_list_t}),
        rk,
        offsets,
    )
end

function rd_kafka_offset_store_message(rkmessage)
    ccall(
        (:rd_kafka_offset_store_message, librdkafka),
        Ptr{rd_kafka_error_t},
        (Ptr{rd_kafka_message_t},),
        rkmessage,
    )
end

function rd_kafka_subscribe(rk, topics)
    ccall(
        (:rd_kafka_subscribe, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_t}, Ptr{rd_kafka_topic_partition_list_t}),
        rk,
        topics,
    )
end

function rd_kafka_unsubscribe(rk)
    ccall((:rd_kafka_unsubscribe, librdkafka), rd_kafka_resp_err_t, (Ptr{rd_kafka_t},), rk)
end

function rd_kafka_subscription(rk, topics)
    ccall(
        (:rd_kafka_subscription, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_t}, Ptr{Ptr{rd_kafka_topic_partition_list_t}}),
        rk,
        topics,
    )
end

function rd_kafka_consumer_poll(rk, timeout_ms)
    ccall(
        (:rd_kafka_consumer_poll, librdkafka),
        Ptr{rd_kafka_message_t},
        (Ptr{rd_kafka_t}, Cint),
        rk,
        timeout_ms,
    )
end

function rd_kafka_consumer_close(rk)
    ccall(
        (:rd_kafka_consumer_close, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_t},),
        rk,
    )
end

function rd_kafka_consumer_close_queue(rk, rkqu)
    ccall(
        (:rd_kafka_consumer_close_queue, librdkafka),
        Ptr{rd_kafka_error_t},
        (Ptr{rd_kafka_t}, Ptr{rd_kafka_queue_t}),
        rk,
        rkqu,
    )
end

function rd_kafka_consumer_closed(rk)
    ccall((:rd_kafka_consumer_closed, librdkafka), Cint, (Ptr{rd_kafka_t},), rk)
end

function rd_kafka_incremental_assign(rk, partitions)
    ccall(
        (:rd_kafka_incremental_assign, librdkafka),
        Ptr{rd_kafka_error_t},
        (Ptr{rd_kafka_t}, Ptr{rd_kafka_topic_partition_list_t}),
        rk,
        partitions,
    )
end

function rd_kafka_incremental_unassign(rk, partitions)
    ccall(
        (:rd_kafka_incremental_unassign, librdkafka),
        Ptr{rd_kafka_error_t},
        (Ptr{rd_kafka_t}, Ptr{rd_kafka_topic_partition_list_t}),
        rk,
        partitions,
    )
end

function rd_kafka_rebalance_protocol(rk)
    ccall((:rd_kafka_rebalance_protocol, librdkafka), Ptr{Cchar}, (Ptr{rd_kafka_t},), rk)
end

function rd_kafka_assign(rk, partitions)
    ccall(
        (:rd_kafka_assign, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_t}, Ptr{rd_kafka_topic_partition_list_t}),
        rk,
        partitions,
    )
end

function rd_kafka_assignment(rk, partitions)
    ccall(
        (:rd_kafka_assignment, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_t}, Ptr{Ptr{rd_kafka_topic_partition_list_t}}),
        rk,
        partitions,
    )
end

function rd_kafka_assignment_lost(rk)
    ccall((:rd_kafka_assignment_lost, librdkafka), Cint, (Ptr{rd_kafka_t},), rk)
end

function rd_kafka_commit(rk, offsets, async)
    ccall(
        (:rd_kafka_commit, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_t}, Ptr{rd_kafka_topic_partition_list_t}, Cint),
        rk,
        offsets,
        async,
    )
end

function rd_kafka_commit_message(rk, rkmessage, async)
    ccall(
        (:rd_kafka_commit_message, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_t}, Ptr{rd_kafka_message_t}, Cint),
        rk,
        rkmessage,
        async,
    )
end

function rd_kafka_commit_queue(rk, offsets, rkqu, cb, commit_opaque)
    ccall(
        (:rd_kafka_commit_queue, librdkafka),
        rd_kafka_resp_err_t,
        (
            Ptr{rd_kafka_t},
            Ptr{rd_kafka_topic_partition_list_t},
            Ptr{rd_kafka_queue_t},
            Ptr{Cvoid},
            Ptr{Cvoid},
        ),
        rk,
        offsets,
        rkqu,
        cb,
        commit_opaque,
    )
end

function rd_kafka_committed(rk, partitions, timeout_ms)
    ccall(
        (:rd_kafka_committed, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_t}, Ptr{rd_kafka_topic_partition_list_t}, Cint),
        rk,
        partitions,
        timeout_ms,
    )
end

function rd_kafka_position(rk, partitions)
    ccall(
        (:rd_kafka_position, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_t}, Ptr{rd_kafka_topic_partition_list_t}),
        rk,
        partitions,
    )
end

function rd_kafka_consumer_group_metadata(rk)
    ccall(
        (:rd_kafka_consumer_group_metadata, librdkafka),
        Ptr{rd_kafka_consumer_group_metadata_t},
        (Ptr{rd_kafka_t},),
        rk,
    )
end

function rd_kafka_consumer_group_metadata_new(group_id)
    ccall(
        (:rd_kafka_consumer_group_metadata_new, librdkafka),
        Ptr{rd_kafka_consumer_group_metadata_t},
        (Ptr{Cchar},),
        group_id,
    )
end

function rd_kafka_consumer_group_metadata_new_with_genid(
    group_id,
    generation_id,
    member_id,
    group_instance_id,
)
    ccall(
        (:rd_kafka_consumer_group_metadata_new_with_genid, librdkafka),
        Ptr{rd_kafka_consumer_group_metadata_t},
        (Ptr{Cchar}, Int32, Ptr{Cchar}, Ptr{Cchar}),
        group_id,
        generation_id,
        member_id,
        group_instance_id,
    )
end

function rd_kafka_consumer_group_metadata_destroy(arg1)
    ccall(
        (:rd_kafka_consumer_group_metadata_destroy, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_consumer_group_metadata_t},),
        arg1,
    )
end

function rd_kafka_consumer_group_metadata_write(cgmd, bufferp, sizep)
    ccall(
        (:rd_kafka_consumer_group_metadata_write, librdkafka),
        Ptr{rd_kafka_error_t},
        (Ptr{rd_kafka_consumer_group_metadata_t}, Ptr{Ptr{Cvoid}}, Ptr{Csize_t}),
        cgmd,
        bufferp,
        sizep,
    )
end

function rd_kafka_consumer_group_metadata_read(cgmdp, buffer, size)
    ccall(
        (:rd_kafka_consumer_group_metadata_read, librdkafka),
        Ptr{rd_kafka_error_t},
        (Ptr{Ptr{rd_kafka_consumer_group_metadata_t}}, Ptr{Cvoid}, Csize_t),
        cgmdp,
        buffer,
        size,
    )
end

function rd_kafka_produce(rkt, partition, msgflags, payload, len, key, keylen, msg_opaque)
    ccall(
        (:rd_kafka_produce, librdkafka),
        Cint,
        (
            Ptr{rd_kafka_topic_t},
            Int32,
            Cint,
            Ptr{Cvoid},
            Csize_t,
            Ptr{Cvoid},
            Csize_t,
            Ptr{Cvoid},
        ),
        rkt,
        partition,
        msgflags,
        payload,
        len,
        key,
        keylen,
        msg_opaque,
    )
end

function rd_kafka_produceva(rk, vus, cnt)
    ccall(
        (:rd_kafka_produceva, librdkafka),
        Ptr{rd_kafka_error_t},
        (Ptr{rd_kafka_t}, Ptr{rd_kafka_vu_t}, Csize_t),
        rk,
        vus,
        cnt,
    )
end

function rd_kafka_produce_batch(rkt, partition, msgflags, rkmessages, message_cnt)
    ccall(
        (:rd_kafka_produce_batch, librdkafka),
        Cint,
        (Ptr{rd_kafka_topic_t}, Int32, Cint, Ptr{rd_kafka_message_t}, Cint),
        rkt,
        partition,
        msgflags,
        rkmessages,
        message_cnt,
    )
end

function rd_kafka_flush(rk, timeout_ms)
    ccall(
        (:rd_kafka_flush, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_t}, Cint),
        rk,
        timeout_ms,
    )
end

function rd_kafka_purge(rk, purge_flags)
    ccall(
        (:rd_kafka_purge, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_t}, Cint),
        rk,
        purge_flags,
    )
end

struct rd_kafka_metadata_broker
    id::Int32
    host::Ptr{Cchar}
    port::Cint
end

const rd_kafka_metadata_broker_t = rd_kafka_metadata_broker

struct rd_kafka_metadata_partition
    id::Int32
    err::rd_kafka_resp_err_t
    leader::Int32
    replica_cnt::Cint
    replicas::Ptr{Int32}
    isr_cnt::Cint
    isrs::Ptr{Int32}
end

const rd_kafka_metadata_partition_t = rd_kafka_metadata_partition

struct rd_kafka_metadata_topic
    topic::Ptr{Cchar}
    partition_cnt::Cint
    partitions::Ptr{rd_kafka_metadata_partition}
    err::rd_kafka_resp_err_t
end

const rd_kafka_metadata_topic_t = rd_kafka_metadata_topic

struct rd_kafka_metadata
    broker_cnt::Cint
    brokers::Ptr{rd_kafka_metadata_broker}
    topic_cnt::Cint
    topics::Ptr{rd_kafka_metadata_topic}
    orig_broker_id::Int32
    orig_broker_name::Ptr{Cchar}
end

const rd_kafka_metadata_t = rd_kafka_metadata

function rd_kafka_metadata(rk, all_topics, only_rkt, metadatap, timeout_ms)
    ccall(
        (:rd_kafka_metadata, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_t}, Cint, Ptr{rd_kafka_topic_t}, Ptr{Ptr{rd_kafka_metadata}}, Cint),
        rk,
        all_topics,
        only_rkt,
        metadatap,
        timeout_ms,
    )
end

function rd_kafka_metadata_destroy(metadata)
    ccall(
        (:rd_kafka_metadata_destroy, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_metadata},),
        metadata,
    )
end

mutable struct rd_kafka_Node_s end

const rd_kafka_Node_t = rd_kafka_Node_s

function rd_kafka_Node_id(node)
    ccall((:rd_kafka_Node_id, librdkafka), Cint, (Ptr{rd_kafka_Node_t},), node)
end

function rd_kafka_Node_host(node)
    ccall((:rd_kafka_Node_host, librdkafka), Ptr{Cchar}, (Ptr{rd_kafka_Node_t},), node)
end

function rd_kafka_Node_port(node)
    ccall((:rd_kafka_Node_port, librdkafka), UInt16, (Ptr{rd_kafka_Node_t},), node)
end

function rd_kafka_Node_rack(node)
    ccall((:rd_kafka_Node_rack, librdkafka), Ptr{Cchar}, (Ptr{rd_kafka_Node_t},), node)
end

struct rd_kafka_group_member_info
    member_id::Ptr{Cchar}
    client_id::Ptr{Cchar}
    client_host::Ptr{Cchar}
    member_metadata::Ptr{Cvoid}
    member_metadata_size::Cint
    member_assignment::Ptr{Cvoid}
    member_assignment_size::Cint
end

@cenum rd_kafka_consumer_group_state_t::UInt32 begin
    RD_KAFKA_CONSUMER_GROUP_STATE_UNKNOWN = 0
    RD_KAFKA_CONSUMER_GROUP_STATE_PREPARING_REBALANCE = 1
    RD_KAFKA_CONSUMER_GROUP_STATE_COMPLETING_REBALANCE = 2
    RD_KAFKA_CONSUMER_GROUP_STATE_STABLE = 3
    RD_KAFKA_CONSUMER_GROUP_STATE_DEAD = 4
    RD_KAFKA_CONSUMER_GROUP_STATE_EMPTY = 5
    RD_KAFKA_CONSUMER_GROUP_STATE__CNT = 6
end

struct rd_kafka_group_info
    broker::rd_kafka_metadata_broker
    group::Ptr{Cchar}
    err::rd_kafka_resp_err_t
    state::Ptr{Cchar}
    protocol_type::Ptr{Cchar}
    protocol::Ptr{Cchar}
    members::Ptr{rd_kafka_group_member_info}
    member_cnt::Cint
end

struct rd_kafka_group_list
    groups::Ptr{rd_kafka_group_info}
    group_cnt::Cint
end

function rd_kafka_list_groups(rk, group, grplistp, timeout_ms)
    ccall(
        (:rd_kafka_list_groups, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_t}, Ptr{Cchar}, Ptr{Ptr{rd_kafka_group_list}}, Cint),
        rk,
        group,
        grplistp,
        timeout_ms,
    )
end

function rd_kafka_consumer_group_state_name(state)
    ccall(
        (:rd_kafka_consumer_group_state_name, librdkafka),
        Ptr{Cchar},
        (rd_kafka_consumer_group_state_t,),
        state,
    )
end

function rd_kafka_consumer_group_state_code(name)
    ccall(
        (:rd_kafka_consumer_group_state_code, librdkafka),
        rd_kafka_consumer_group_state_t,
        (Ptr{Cchar},),
        name,
    )
end

function rd_kafka_group_list_destroy(grplist)
    ccall(
        (:rd_kafka_group_list_destroy, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_group_list},),
        grplist,
    )
end

function rd_kafka_brokers_add(rk, brokerlist)
    ccall(
        (:rd_kafka_brokers_add, librdkafka),
        Cint,
        (Ptr{rd_kafka_t}, Ptr{Cchar}),
        rk,
        brokerlist,
    )
end

function rd_kafka_set_logger(rk, func)
    ccall(
        (:rd_kafka_set_logger, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_t}, Ptr{Cvoid}),
        rk,
        func,
    )
end

function rd_kafka_set_log_level(rk, level)
    ccall((:rd_kafka_set_log_level, librdkafka), Cvoid, (Ptr{rd_kafka_t}, Cint), rk, level)
end

function rd_kafka_log_print(rk, level, fac, buf)
    ccall(
        (:rd_kafka_log_print, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_t}, Cint, Ptr{Cchar}, Ptr{Cchar}),
        rk,
        level,
        fac,
        buf,
    )
end

function rd_kafka_log_syslog(rk, level, fac, buf)
    ccall(
        (:rd_kafka_log_syslog, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_t}, Cint, Ptr{Cchar}, Ptr{Cchar}),
        rk,
        level,
        fac,
        buf,
    )
end

function rd_kafka_outq_len(rk)
    ccall((:rd_kafka_outq_len, librdkafka), Cint, (Ptr{rd_kafka_t},), rk)
end

function rd_kafka_dump(fp, rk)
    ccall((:rd_kafka_dump, librdkafka), Cvoid, (Ptr{Libc.FILE}, Ptr{rd_kafka_t}), fp, rk)
end

function rd_kafka_thread_cnt()
    ccall((:rd_kafka_thread_cnt, librdkafka), Cint, ())
end

@cenum rd_kafka_thread_type_t::UInt32 begin
    RD_KAFKA_THREAD_MAIN = 0
    RD_KAFKA_THREAD_BACKGROUND = 1
    RD_KAFKA_THREAD_BROKER = 2
end

function rd_kafka_wait_destroyed(timeout_ms)
    ccall((:rd_kafka_wait_destroyed, librdkafka), Cint, (Cint,), timeout_ms)
end

function rd_kafka_unittest()
    ccall((:rd_kafka_unittest, librdkafka), Cint, ())
end

function rd_kafka_poll_set_consumer(rk)
    ccall(
        (:rd_kafka_poll_set_consumer, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_t},),
        rk,
    )
end

const rd_kafka_event_type_t = Cint

function rd_kafka_event_type(rkev)
    ccall(
        (:rd_kafka_event_type, librdkafka),
        rd_kafka_event_type_t,
        (Ptr{rd_kafka_event_t},),
        rkev,
    )
end

function rd_kafka_event_name(rkev)
    ccall((:rd_kafka_event_name, librdkafka), Ptr{Cchar}, (Ptr{rd_kafka_event_t},), rkev)
end

function rd_kafka_event_destroy(rkev)
    ccall((:rd_kafka_event_destroy, librdkafka), Cvoid, (Ptr{rd_kafka_event_t},), rkev)
end

function rd_kafka_event_message_next(rkev)
    ccall(
        (:rd_kafka_event_message_next, librdkafka),
        Ptr{rd_kafka_message_t},
        (Ptr{rd_kafka_event_t},),
        rkev,
    )
end

function rd_kafka_event_message_array(rkev, rkmessages, size)
    ccall(
        (:rd_kafka_event_message_array, librdkafka),
        Csize_t,
        (Ptr{rd_kafka_event_t}, Ptr{Ptr{rd_kafka_message_t}}, Csize_t),
        rkev,
        rkmessages,
        size,
    )
end

function rd_kafka_event_message_count(rkev)
    ccall(
        (:rd_kafka_event_message_count, librdkafka),
        Csize_t,
        (Ptr{rd_kafka_event_t},),
        rkev,
    )
end

function rd_kafka_event_config_string(rkev)
    ccall(
        (:rd_kafka_event_config_string, librdkafka),
        Ptr{Cchar},
        (Ptr{rd_kafka_event_t},),
        rkev,
    )
end

function rd_kafka_event_error(rkev)
    ccall(
        (:rd_kafka_event_error, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_event_t},),
        rkev,
    )
end

function rd_kafka_event_error_string(rkev)
    ccall(
        (:rd_kafka_event_error_string, librdkafka),
        Ptr{Cchar},
        (Ptr{rd_kafka_event_t},),
        rkev,
    )
end

function rd_kafka_event_error_is_fatal(rkev)
    ccall(
        (:rd_kafka_event_error_is_fatal, librdkafka),
        Cint,
        (Ptr{rd_kafka_event_t},),
        rkev,
    )
end

function rd_kafka_event_opaque(rkev)
    ccall((:rd_kafka_event_opaque, librdkafka), Ptr{Cvoid}, (Ptr{rd_kafka_event_t},), rkev)
end

function rd_kafka_event_log(rkev, fac, str, level)
    ccall(
        (:rd_kafka_event_log, librdkafka),
        Cint,
        (Ptr{rd_kafka_event_t}, Ptr{Ptr{Cchar}}, Ptr{Ptr{Cchar}}, Ptr{Cint}),
        rkev,
        fac,
        str,
        level,
    )
end

function rd_kafka_event_debug_contexts(rkev, dst, dstsize)
    ccall(
        (:rd_kafka_event_debug_contexts, librdkafka),
        Cint,
        (Ptr{rd_kafka_event_t}, Ptr{Cchar}, Csize_t),
        rkev,
        dst,
        dstsize,
    )
end

function rd_kafka_event_stats(rkev)
    ccall((:rd_kafka_event_stats, librdkafka), Ptr{Cchar}, (Ptr{rd_kafka_event_t},), rkev)
end

function rd_kafka_event_topic_partition_list(rkev)
    ccall(
        (:rd_kafka_event_topic_partition_list, librdkafka),
        Ptr{rd_kafka_topic_partition_list_t},
        (Ptr{rd_kafka_event_t},),
        rkev,
    )
end

function rd_kafka_event_topic_partition(rkev)
    ccall(
        (:rd_kafka_event_topic_partition, librdkafka),
        Ptr{rd_kafka_topic_partition_t},
        (Ptr{rd_kafka_event_t},),
        rkev,
    )
end

const rd_kafka_CreateTopics_result_t = rd_kafka_event_t

const rd_kafka_DeleteTopics_result_t = rd_kafka_event_t

const rd_kafka_CreateAcls_result_t = rd_kafka_event_t

const rd_kafka_DescribeAcls_result_t = rd_kafka_event_t

const rd_kafka_DeleteAcls_result_t = rd_kafka_event_t

const rd_kafka_CreatePartitions_result_t = rd_kafka_event_t

const rd_kafka_AlterConfigs_result_t = rd_kafka_event_t

const rd_kafka_IncrementalAlterConfigs_result_t = rd_kafka_event_t

const rd_kafka_DescribeConfigs_result_t = rd_kafka_event_t

const rd_kafka_DeleteRecords_result_t = rd_kafka_event_t

const rd_kafka_ListConsumerGroups_result_t = rd_kafka_event_t

const rd_kafka_DescribeConsumerGroups_result_t = rd_kafka_event_t

const rd_kafka_DeleteGroups_result_t = rd_kafka_event_t

const rd_kafka_DeleteConsumerGroupOffsets_result_t = rd_kafka_event_t

const rd_kafka_AlterConsumerGroupOffsets_result_t = rd_kafka_event_t

const rd_kafka_ListConsumerGroupOffsets_result_t = rd_kafka_event_t

const rd_kafka_DescribeTopics_result_t = rd_kafka_event_t

const rd_kafka_DescribeCluster_result_t = rd_kafka_event_t

const rd_kafka_DescribeUserScramCredentials_result_t = rd_kafka_event_t

const rd_kafka_AlterUserScramCredentials_result_t = rd_kafka_event_t

const rd_kafka_ListOffsets_result_t = rd_kafka_event_t

function rd_kafka_event_CreateTopics_result(rkev)
    ccall(
        (:rd_kafka_event_CreateTopics_result, librdkafka),
        Ptr{rd_kafka_CreateTopics_result_t},
        (Ptr{rd_kafka_event_t},),
        rkev,
    )
end

function rd_kafka_event_DeleteTopics_result(rkev)
    ccall(
        (:rd_kafka_event_DeleteTopics_result, librdkafka),
        Ptr{rd_kafka_DeleteTopics_result_t},
        (Ptr{rd_kafka_event_t},),
        rkev,
    )
end

function rd_kafka_event_CreatePartitions_result(rkev)
    ccall(
        (:rd_kafka_event_CreatePartitions_result, librdkafka),
        Ptr{rd_kafka_CreatePartitions_result_t},
        (Ptr{rd_kafka_event_t},),
        rkev,
    )
end

function rd_kafka_event_AlterConfigs_result(rkev)
    ccall(
        (:rd_kafka_event_AlterConfigs_result, librdkafka),
        Ptr{rd_kafka_AlterConfigs_result_t},
        (Ptr{rd_kafka_event_t},),
        rkev,
    )
end

function rd_kafka_event_IncrementalAlterConfigs_result(rkev)
    ccall(
        (:rd_kafka_event_IncrementalAlterConfigs_result, librdkafka),
        Ptr{rd_kafka_IncrementalAlterConfigs_result_t},
        (Ptr{rd_kafka_event_t},),
        rkev,
    )
end

function rd_kafka_event_DescribeConfigs_result(rkev)
    ccall(
        (:rd_kafka_event_DescribeConfigs_result, librdkafka),
        Ptr{rd_kafka_DescribeConfigs_result_t},
        (Ptr{rd_kafka_event_t},),
        rkev,
    )
end

function rd_kafka_event_DeleteRecords_result(rkev)
    ccall(
        (:rd_kafka_event_DeleteRecords_result, librdkafka),
        Ptr{rd_kafka_DeleteRecords_result_t},
        (Ptr{rd_kafka_event_t},),
        rkev,
    )
end

function rd_kafka_event_ListConsumerGroups_result(rkev)
    ccall(
        (:rd_kafka_event_ListConsumerGroups_result, librdkafka),
        Ptr{rd_kafka_ListConsumerGroups_result_t},
        (Ptr{rd_kafka_event_t},),
        rkev,
    )
end

function rd_kafka_event_DescribeConsumerGroups_result(rkev)
    ccall(
        (:rd_kafka_event_DescribeConsumerGroups_result, librdkafka),
        Ptr{rd_kafka_DescribeConsumerGroups_result_t},
        (Ptr{rd_kafka_event_t},),
        rkev,
    )
end

function rd_kafka_event_DescribeTopics_result(rkev)
    ccall(
        (:rd_kafka_event_DescribeTopics_result, librdkafka),
        Ptr{rd_kafka_DescribeTopics_result_t},
        (Ptr{rd_kafka_event_t},),
        rkev,
    )
end

function rd_kafka_event_DescribeCluster_result(rkev)
    ccall(
        (:rd_kafka_event_DescribeCluster_result, librdkafka),
        Ptr{rd_kafka_DescribeCluster_result_t},
        (Ptr{rd_kafka_event_t},),
        rkev,
    )
end

function rd_kafka_event_DeleteGroups_result(rkev)
    ccall(
        (:rd_kafka_event_DeleteGroups_result, librdkafka),
        Ptr{rd_kafka_DeleteGroups_result_t},
        (Ptr{rd_kafka_event_t},),
        rkev,
    )
end

function rd_kafka_event_DeleteConsumerGroupOffsets_result(rkev)
    ccall(
        (:rd_kafka_event_DeleteConsumerGroupOffsets_result, librdkafka),
        Ptr{rd_kafka_DeleteConsumerGroupOffsets_result_t},
        (Ptr{rd_kafka_event_t},),
        rkev,
    )
end

function rd_kafka_event_CreateAcls_result(rkev)
    ccall(
        (:rd_kafka_event_CreateAcls_result, librdkafka),
        Ptr{rd_kafka_CreateAcls_result_t},
        (Ptr{rd_kafka_event_t},),
        rkev,
    )
end

function rd_kafka_event_DescribeAcls_result(rkev)
    ccall(
        (:rd_kafka_event_DescribeAcls_result, librdkafka),
        Ptr{rd_kafka_DescribeAcls_result_t},
        (Ptr{rd_kafka_event_t},),
        rkev,
    )
end

function rd_kafka_event_DeleteAcls_result(rkev)
    ccall(
        (:rd_kafka_event_DeleteAcls_result, librdkafka),
        Ptr{rd_kafka_DeleteAcls_result_t},
        (Ptr{rd_kafka_event_t},),
        rkev,
    )
end

function rd_kafka_event_ListConsumerGroupOffsets_result(rkev)
    ccall(
        (:rd_kafka_event_ListConsumerGroupOffsets_result, librdkafka),
        Ptr{rd_kafka_ListConsumerGroupOffsets_result_t},
        (Ptr{rd_kafka_event_t},),
        rkev,
    )
end

function rd_kafka_event_AlterConsumerGroupOffsets_result(rkev)
    ccall(
        (:rd_kafka_event_AlterConsumerGroupOffsets_result, librdkafka),
        Ptr{rd_kafka_AlterConsumerGroupOffsets_result_t},
        (Ptr{rd_kafka_event_t},),
        rkev,
    )
end

function rd_kafka_event_ListOffsets_result(rkev)
    ccall(
        (:rd_kafka_event_ListOffsets_result, librdkafka),
        Ptr{rd_kafka_ListOffsets_result_t},
        (Ptr{rd_kafka_event_t},),
        rkev,
    )
end

function rd_kafka_event_DescribeUserScramCredentials_result(rkev)
    ccall(
        (:rd_kafka_event_DescribeUserScramCredentials_result, librdkafka),
        Ptr{rd_kafka_DescribeUserScramCredentials_result_t},
        (Ptr{rd_kafka_event_t},),
        rkev,
    )
end

function rd_kafka_event_AlterUserScramCredentials_result(rkev)
    ccall(
        (:rd_kafka_event_AlterUserScramCredentials_result, librdkafka),
        Ptr{rd_kafka_AlterUserScramCredentials_result_t},
        (Ptr{rd_kafka_event_t},),
        rkev,
    )
end

function rd_kafka_queue_poll(rkqu, timeout_ms)
    ccall(
        (:rd_kafka_queue_poll, librdkafka),
        Ptr{rd_kafka_event_t},
        (Ptr{rd_kafka_queue_t}, Cint),
        rkqu,
        timeout_ms,
    )
end

function rd_kafka_queue_poll_callback(rkqu, timeout_ms)
    ccall(
        (:rd_kafka_queue_poll_callback, librdkafka),
        Cint,
        (Ptr{rd_kafka_queue_t}, Cint),
        rkqu,
        timeout_ms,
    )
end

# typedef rd_kafka_resp_err_t ( rd_kafka_plugin_f_conf_init_t ) ( rd_kafka_conf_t * conf , void * * plug_opaquep , char * errstr , size_t errstr_size )
const rd_kafka_plugin_f_conf_init_t = Cvoid

# typedef rd_kafka_conf_res_t ( rd_kafka_interceptor_f_on_conf_set_t ) ( rd_kafka_conf_t * conf , const char * name , const char * val , char * errstr , size_t errstr_size , void * ic_opaque )
const rd_kafka_interceptor_f_on_conf_set_t = Cvoid

# typedef rd_kafka_resp_err_t ( rd_kafka_interceptor_f_on_conf_dup_t ) ( rd_kafka_conf_t * new_conf , const rd_kafka_conf_t * old_conf , size_t filter_cnt , const char * * filter , void * ic_opaque )
const rd_kafka_interceptor_f_on_conf_dup_t = Cvoid

# typedef rd_kafka_resp_err_t ( rd_kafka_interceptor_f_on_conf_destroy_t ) ( void * ic_opaque )
const rd_kafka_interceptor_f_on_conf_destroy_t = Cvoid

# typedef rd_kafka_resp_err_t ( rd_kafka_interceptor_f_on_new_t ) ( rd_kafka_t * rk , const rd_kafka_conf_t * conf , void * ic_opaque , char * errstr , size_t errstr_size )
const rd_kafka_interceptor_f_on_new_t = Cvoid

# typedef rd_kafka_resp_err_t ( rd_kafka_interceptor_f_on_destroy_t ) ( rd_kafka_t * rk , void * ic_opaque )
const rd_kafka_interceptor_f_on_destroy_t = Cvoid

# typedef rd_kafka_resp_err_t ( rd_kafka_interceptor_f_on_send_t ) ( rd_kafka_t * rk , rd_kafka_message_t * rkmessage , void * ic_opaque )
const rd_kafka_interceptor_f_on_send_t = Cvoid

# typedef rd_kafka_resp_err_t ( rd_kafka_interceptor_f_on_acknowledgement_t ) ( rd_kafka_t * rk , rd_kafka_message_t * rkmessage , void * ic_opaque )
const rd_kafka_interceptor_f_on_acknowledgement_t = Cvoid

# typedef rd_kafka_resp_err_t ( rd_kafka_interceptor_f_on_consume_t ) ( rd_kafka_t * rk , rd_kafka_message_t * rkmessage , void * ic_opaque )
const rd_kafka_interceptor_f_on_consume_t = Cvoid

# typedef rd_kafka_resp_err_t ( rd_kafka_interceptor_f_on_commit_t ) ( rd_kafka_t * rk , const rd_kafka_topic_partition_list_t * offsets , rd_kafka_resp_err_t err , void * ic_opaque )
const rd_kafka_interceptor_f_on_commit_t = Cvoid

# typedef rd_kafka_resp_err_t ( rd_kafka_interceptor_f_on_request_sent_t ) ( rd_kafka_t * rk , int sockfd , const char * brokername , int32_t brokerid , int16_t ApiKey , int16_t ApiVersion , int32_t CorrId , size_t size , void * ic_opaque )
const rd_kafka_interceptor_f_on_request_sent_t = Cvoid

# typedef rd_kafka_resp_err_t ( rd_kafka_interceptor_f_on_response_received_t ) ( rd_kafka_t * rk , int sockfd , const char * brokername , int32_t brokerid , int16_t ApiKey , int16_t ApiVersion , int32_t CorrId , size_t size , int64_t rtt , rd_kafka_resp_err_t err , void * ic_opaque )
const rd_kafka_interceptor_f_on_response_received_t = Cvoid

# typedef rd_kafka_resp_err_t ( rd_kafka_interceptor_f_on_thread_start_t ) ( rd_kafka_t * rk , rd_kafka_thread_type_t thread_type , const char * thread_name , void * ic_opaque )
const rd_kafka_interceptor_f_on_thread_start_t = Cvoid

# typedef rd_kafka_resp_err_t ( rd_kafka_interceptor_f_on_thread_exit_t ) ( rd_kafka_t * rk , rd_kafka_thread_type_t thread_type , const char * thread_name , void * ic_opaque )
const rd_kafka_interceptor_f_on_thread_exit_t = Cvoid

# typedef rd_kafka_resp_err_t ( rd_kafka_interceptor_f_on_broker_state_change_t ) ( rd_kafka_t * rk , int32_t broker_id , const char * secproto , const char * name , int port , const char * state , void * ic_opaque )
const rd_kafka_interceptor_f_on_broker_state_change_t = Cvoid

function rd_kafka_conf_interceptor_add_on_conf_set(conf, ic_name, on_conf_set, ic_opaque)
    ccall(
        (:rd_kafka_conf_interceptor_add_on_conf_set, librdkafka),
        rd_kafka_resp_err_t,
        (
            Ptr{rd_kafka_conf_t},
            Ptr{Cchar},
            Ptr{rd_kafka_interceptor_f_on_conf_set_t},
            Ptr{Cvoid},
        ),
        conf,
        ic_name,
        on_conf_set,
        ic_opaque,
    )
end

function rd_kafka_conf_interceptor_add_on_conf_dup(conf, ic_name, on_conf_dup, ic_opaque)
    ccall(
        (:rd_kafka_conf_interceptor_add_on_conf_dup, librdkafka),
        rd_kafka_resp_err_t,
        (
            Ptr{rd_kafka_conf_t},
            Ptr{Cchar},
            Ptr{rd_kafka_interceptor_f_on_conf_dup_t},
            Ptr{Cvoid},
        ),
        conf,
        ic_name,
        on_conf_dup,
        ic_opaque,
    )
end

function rd_kafka_conf_interceptor_add_on_conf_destroy(
    conf,
    ic_name,
    on_conf_destroy,
    ic_opaque,
)
    ccall(
        (:rd_kafka_conf_interceptor_add_on_conf_destroy, librdkafka),
        rd_kafka_resp_err_t,
        (
            Ptr{rd_kafka_conf_t},
            Ptr{Cchar},
            Ptr{rd_kafka_interceptor_f_on_conf_destroy_t},
            Ptr{Cvoid},
        ),
        conf,
        ic_name,
        on_conf_destroy,
        ic_opaque,
    )
end

function rd_kafka_conf_interceptor_add_on_new(conf, ic_name, on_new, ic_opaque)
    ccall(
        (:rd_kafka_conf_interceptor_add_on_new, librdkafka),
        rd_kafka_resp_err_t,
        (
            Ptr{rd_kafka_conf_t},
            Ptr{Cchar},
            Ptr{rd_kafka_interceptor_f_on_new_t},
            Ptr{Cvoid},
        ),
        conf,
        ic_name,
        on_new,
        ic_opaque,
    )
end

function rd_kafka_interceptor_add_on_destroy(rk, ic_name, on_destroy, ic_opaque)
    ccall(
        (:rd_kafka_interceptor_add_on_destroy, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_t}, Ptr{Cchar}, Ptr{rd_kafka_interceptor_f_on_destroy_t}, Ptr{Cvoid}),
        rk,
        ic_name,
        on_destroy,
        ic_opaque,
    )
end

function rd_kafka_interceptor_add_on_send(rk, ic_name, on_send, ic_opaque)
    ccall(
        (:rd_kafka_interceptor_add_on_send, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_t}, Ptr{Cchar}, Ptr{rd_kafka_interceptor_f_on_send_t}, Ptr{Cvoid}),
        rk,
        ic_name,
        on_send,
        ic_opaque,
    )
end

function rd_kafka_interceptor_add_on_acknowledgement(
    rk,
    ic_name,
    on_acknowledgement,
    ic_opaque,
)
    ccall(
        (:rd_kafka_interceptor_add_on_acknowledgement, librdkafka),
        rd_kafka_resp_err_t,
        (
            Ptr{rd_kafka_t},
            Ptr{Cchar},
            Ptr{rd_kafka_interceptor_f_on_acknowledgement_t},
            Ptr{Cvoid},
        ),
        rk,
        ic_name,
        on_acknowledgement,
        ic_opaque,
    )
end

function rd_kafka_interceptor_add_on_consume(rk, ic_name, on_consume, ic_opaque)
    ccall(
        (:rd_kafka_interceptor_add_on_consume, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_t}, Ptr{Cchar}, Ptr{rd_kafka_interceptor_f_on_consume_t}, Ptr{Cvoid}),
        rk,
        ic_name,
        on_consume,
        ic_opaque,
    )
end

function rd_kafka_interceptor_add_on_commit(rk, ic_name, on_commit, ic_opaque)
    ccall(
        (:rd_kafka_interceptor_add_on_commit, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_t}, Ptr{Cchar}, Ptr{rd_kafka_interceptor_f_on_commit_t}, Ptr{Cvoid}),
        rk,
        ic_name,
        on_commit,
        ic_opaque,
    )
end

function rd_kafka_interceptor_add_on_request_sent(rk, ic_name, on_request_sent, ic_opaque)
    ccall(
        (:rd_kafka_interceptor_add_on_request_sent, librdkafka),
        rd_kafka_resp_err_t,
        (
            Ptr{rd_kafka_t},
            Ptr{Cchar},
            Ptr{rd_kafka_interceptor_f_on_request_sent_t},
            Ptr{Cvoid},
        ),
        rk,
        ic_name,
        on_request_sent,
        ic_opaque,
    )
end

function rd_kafka_interceptor_add_on_response_received(
    rk,
    ic_name,
    on_response_received,
    ic_opaque,
)
    ccall(
        (:rd_kafka_interceptor_add_on_response_received, librdkafka),
        rd_kafka_resp_err_t,
        (
            Ptr{rd_kafka_t},
            Ptr{Cchar},
            Ptr{rd_kafka_interceptor_f_on_response_received_t},
            Ptr{Cvoid},
        ),
        rk,
        ic_name,
        on_response_received,
        ic_opaque,
    )
end

function rd_kafka_interceptor_add_on_thread_start(rk, ic_name, on_thread_start, ic_opaque)
    ccall(
        (:rd_kafka_interceptor_add_on_thread_start, librdkafka),
        rd_kafka_resp_err_t,
        (
            Ptr{rd_kafka_t},
            Ptr{Cchar},
            Ptr{rd_kafka_interceptor_f_on_thread_start_t},
            Ptr{Cvoid},
        ),
        rk,
        ic_name,
        on_thread_start,
        ic_opaque,
    )
end

function rd_kafka_interceptor_add_on_thread_exit(rk, ic_name, on_thread_exit, ic_opaque)
    ccall(
        (:rd_kafka_interceptor_add_on_thread_exit, librdkafka),
        rd_kafka_resp_err_t,
        (
            Ptr{rd_kafka_t},
            Ptr{Cchar},
            Ptr{rd_kafka_interceptor_f_on_thread_exit_t},
            Ptr{Cvoid},
        ),
        rk,
        ic_name,
        on_thread_exit,
        ic_opaque,
    )
end

function rd_kafka_interceptor_add_on_broker_state_change(
    rk,
    ic_name,
    on_broker_state_change,
    ic_opaque,
)
    ccall(
        (:rd_kafka_interceptor_add_on_broker_state_change, librdkafka),
        rd_kafka_resp_err_t,
        (
            Ptr{rd_kafka_t},
            Ptr{Cchar},
            Ptr{rd_kafka_interceptor_f_on_broker_state_change_t},
            Ptr{Cvoid},
        ),
        rk,
        ic_name,
        on_broker_state_change,
        ic_opaque,
    )
end

function rd_kafka_topic_result_error(topicres)
    ccall(
        (:rd_kafka_topic_result_error, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_topic_result_t},),
        topicres,
    )
end

function rd_kafka_topic_result_error_string(topicres)
    ccall(
        (:rd_kafka_topic_result_error_string, librdkafka),
        Ptr{Cchar},
        (Ptr{rd_kafka_topic_result_t},),
        topicres,
    )
end

function rd_kafka_topic_result_name(topicres)
    ccall(
        (:rd_kafka_topic_result_name, librdkafka),
        Ptr{Cchar},
        (Ptr{rd_kafka_topic_result_t},),
        topicres,
    )
end

function rd_kafka_group_result_error(groupres)
    ccall(
        (:rd_kafka_group_result_error, librdkafka),
        Ptr{rd_kafka_error_t},
        (Ptr{rd_kafka_group_result_t},),
        groupres,
    )
end

function rd_kafka_group_result_name(groupres)
    ccall(
        (:rd_kafka_group_result_name, librdkafka),
        Ptr{Cchar},
        (Ptr{rd_kafka_group_result_t},),
        groupres,
    )
end

function rd_kafka_group_result_partitions(groupres)
    ccall(
        (:rd_kafka_group_result_partitions, librdkafka),
        Ptr{rd_kafka_topic_partition_list_t},
        (Ptr{rd_kafka_group_result_t},),
        groupres,
    )
end

@cenum rd_kafka_admin_op_t::UInt32 begin
    RD_KAFKA_ADMIN_OP_ANY = 0
    RD_KAFKA_ADMIN_OP_CREATETOPICS = 1
    RD_KAFKA_ADMIN_OP_DELETETOPICS = 2
    RD_KAFKA_ADMIN_OP_CREATEPARTITIONS = 3
    RD_KAFKA_ADMIN_OP_ALTERCONFIGS = 4
    RD_KAFKA_ADMIN_OP_DESCRIBECONFIGS = 5
    RD_KAFKA_ADMIN_OP_DELETERECORDS = 6
    RD_KAFKA_ADMIN_OP_DELETEGROUPS = 7
    RD_KAFKA_ADMIN_OP_DELETECONSUMERGROUPOFFSETS = 8
    RD_KAFKA_ADMIN_OP_CREATEACLS = 9
    RD_KAFKA_ADMIN_OP_DESCRIBEACLS = 10
    RD_KAFKA_ADMIN_OP_DELETEACLS = 11
    RD_KAFKA_ADMIN_OP_LISTCONSUMERGROUPS = 12
    RD_KAFKA_ADMIN_OP_DESCRIBECONSUMERGROUPS = 13
    RD_KAFKA_ADMIN_OP_LISTCONSUMERGROUPOFFSETS = 14
    RD_KAFKA_ADMIN_OP_ALTERCONSUMERGROUPOFFSETS = 15
    RD_KAFKA_ADMIN_OP_INCREMENTALALTERCONFIGS = 16
    RD_KAFKA_ADMIN_OP_DESCRIBEUSERSCRAMCREDENTIALS = 17
    RD_KAFKA_ADMIN_OP_ALTERUSERSCRAMCREDENTIALS = 18
    RD_KAFKA_ADMIN_OP_DESCRIBETOPICS = 19
    RD_KAFKA_ADMIN_OP_DESCRIBECLUSTER = 20
    RD_KAFKA_ADMIN_OP_LISTOFFSETS = 21
    RD_KAFKA_ADMIN_OP__CNT = 22
end

mutable struct rd_kafka_AdminOptions_s end

const rd_kafka_AdminOptions_t = rd_kafka_AdminOptions_s

@cenum rd_kafka_IsolationLevel_t::UInt32 begin
    RD_KAFKA_ISOLATION_LEVEL_READ_UNCOMMITTED = 0
    RD_KAFKA_ISOLATION_LEVEL_READ_COMMITTED = 1
end

function rd_kafka_AdminOptions_new(rk, for_api)
    ccall(
        (:rd_kafka_AdminOptions_new, librdkafka),
        Ptr{rd_kafka_AdminOptions_t},
        (Ptr{rd_kafka_t}, rd_kafka_admin_op_t),
        rk,
        for_api,
    )
end

function rd_kafka_AdminOptions_destroy(options)
    ccall(
        (:rd_kafka_AdminOptions_destroy, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_AdminOptions_t},),
        options,
    )
end

function rd_kafka_AdminOptions_set_request_timeout(options, timeout_ms, errstr, errstr_size)
    ccall(
        (:rd_kafka_AdminOptions_set_request_timeout, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_AdminOptions_t}, Cint, Ptr{Cchar}, Csize_t),
        options,
        timeout_ms,
        errstr,
        errstr_size,
    )
end

function rd_kafka_AdminOptions_set_operation_timeout(
    options,
    timeout_ms,
    errstr,
    errstr_size,
)
    ccall(
        (:rd_kafka_AdminOptions_set_operation_timeout, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_AdminOptions_t}, Cint, Ptr{Cchar}, Csize_t),
        options,
        timeout_ms,
        errstr,
        errstr_size,
    )
end

function rd_kafka_AdminOptions_set_validate_only(
    options,
    true_or_false,
    errstr,
    errstr_size,
)
    ccall(
        (:rd_kafka_AdminOptions_set_validate_only, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_AdminOptions_t}, Cint, Ptr{Cchar}, Csize_t),
        options,
        true_or_false,
        errstr,
        errstr_size,
    )
end

function rd_kafka_AdminOptions_set_broker(options, broker_id, errstr, errstr_size)
    ccall(
        (:rd_kafka_AdminOptions_set_broker, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_AdminOptions_t}, Int32, Ptr{Cchar}, Csize_t),
        options,
        broker_id,
        errstr,
        errstr_size,
    )
end

function rd_kafka_AdminOptions_set_require_stable_offsets(options, true_or_false)
    ccall(
        (:rd_kafka_AdminOptions_set_require_stable_offsets, librdkafka),
        Ptr{rd_kafka_error_t},
        (Ptr{rd_kafka_AdminOptions_t}, Cint),
        options,
        true_or_false,
    )
end

function rd_kafka_AdminOptions_set_include_authorized_operations(options, true_or_false)
    ccall(
        (:rd_kafka_AdminOptions_set_include_authorized_operations, librdkafka),
        Ptr{rd_kafka_error_t},
        (Ptr{rd_kafka_AdminOptions_t}, Cint),
        options,
        true_or_false,
    )
end

function rd_kafka_AdminOptions_set_match_consumer_group_states(
    options,
    consumer_group_states,
    consumer_group_states_cnt,
)
    ccall(
        (:rd_kafka_AdminOptions_set_match_consumer_group_states, librdkafka),
        Ptr{rd_kafka_error_t},
        (Ptr{rd_kafka_AdminOptions_t}, Ptr{rd_kafka_consumer_group_state_t}, Csize_t),
        options,
        consumer_group_states,
        consumer_group_states_cnt,
    )
end

function rd_kafka_AdminOptions_set_isolation_level(options, value)
    ccall(
        (:rd_kafka_AdminOptions_set_isolation_level, librdkafka),
        Ptr{rd_kafka_error_t},
        (Ptr{rd_kafka_AdminOptions_t}, rd_kafka_IsolationLevel_t),
        options,
        value,
    )
end

function rd_kafka_AdminOptions_set_opaque(options, ev_opaque)
    ccall(
        (:rd_kafka_AdminOptions_set_opaque, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_AdminOptions_t}, Ptr{Cvoid}),
        options,
        ev_opaque,
    )
end

@cenum rd_kafka_AclOperation_t::UInt32 begin
    RD_KAFKA_ACL_OPERATION_UNKNOWN = 0
    RD_KAFKA_ACL_OPERATION_ANY = 1
    RD_KAFKA_ACL_OPERATION_ALL = 2
    RD_KAFKA_ACL_OPERATION_READ = 3
    RD_KAFKA_ACL_OPERATION_WRITE = 4
    RD_KAFKA_ACL_OPERATION_CREATE = 5
    RD_KAFKA_ACL_OPERATION_DELETE = 6
    RD_KAFKA_ACL_OPERATION_ALTER = 7
    RD_KAFKA_ACL_OPERATION_DESCRIBE = 8
    RD_KAFKA_ACL_OPERATION_CLUSTER_ACTION = 9
    RD_KAFKA_ACL_OPERATION_DESCRIBE_CONFIGS = 10
    RD_KAFKA_ACL_OPERATION_ALTER_CONFIGS = 11
    RD_KAFKA_ACL_OPERATION_IDEMPOTENT_WRITE = 12
    RD_KAFKA_ACL_OPERATION__CNT = 13
end

mutable struct rd_kafka_NewTopic_s end

const rd_kafka_NewTopic_t = rd_kafka_NewTopic_s

function rd_kafka_NewTopic_new(
    topic,
    num_partitions,
    replication_factor,
    errstr,
    errstr_size,
)
    ccall(
        (:rd_kafka_NewTopic_new, librdkafka),
        Ptr{rd_kafka_NewTopic_t},
        (Ptr{Cchar}, Cint, Cint, Ptr{Cchar}, Csize_t),
        topic,
        num_partitions,
        replication_factor,
        errstr,
        errstr_size,
    )
end

function rd_kafka_NewTopic_destroy(new_topic)
    ccall(
        (:rd_kafka_NewTopic_destroy, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_NewTopic_t},),
        new_topic,
    )
end

function rd_kafka_NewTopic_destroy_array(new_topics, new_topic_cnt)
    ccall(
        (:rd_kafka_NewTopic_destroy_array, librdkafka),
        Cvoid,
        (Ptr{Ptr{rd_kafka_NewTopic_t}}, Csize_t),
        new_topics,
        new_topic_cnt,
    )
end

function rd_kafka_NewTopic_set_replica_assignment(
    new_topic,
    partition,
    broker_ids,
    broker_id_cnt,
    errstr,
    errstr_size,
)
    ccall(
        (:rd_kafka_NewTopic_set_replica_assignment, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_NewTopic_t}, Int32, Ptr{Int32}, Csize_t, Ptr{Cchar}, Csize_t),
        new_topic,
        partition,
        broker_ids,
        broker_id_cnt,
        errstr,
        errstr_size,
    )
end

function rd_kafka_NewTopic_set_config(new_topic, name, value)
    ccall(
        (:rd_kafka_NewTopic_set_config, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_NewTopic_t}, Ptr{Cchar}, Ptr{Cchar}),
        new_topic,
        name,
        value,
    )
end

function rd_kafka_CreateTopics(rk, new_topics, new_topic_cnt, options, rkqu)
    ccall(
        (:rd_kafka_CreateTopics, librdkafka),
        Cvoid,
        (
            Ptr{rd_kafka_t},
            Ptr{Ptr{rd_kafka_NewTopic_t}},
            Csize_t,
            Ptr{rd_kafka_AdminOptions_t},
            Ptr{rd_kafka_queue_t},
        ),
        rk,
        new_topics,
        new_topic_cnt,
        options,
        rkqu,
    )
end

function rd_kafka_CreateTopics_result_topics(result, cntp)
    ccall(
        (:rd_kafka_CreateTopics_result_topics, librdkafka),
        Ptr{Ptr{rd_kafka_topic_result_t}},
        (Ptr{rd_kafka_CreateTopics_result_t}, Ptr{Csize_t}),
        result,
        cntp,
    )
end

mutable struct rd_kafka_DeleteTopic_s end

const rd_kafka_DeleteTopic_t = rd_kafka_DeleteTopic_s

function rd_kafka_DeleteTopic_new(topic)
    ccall(
        (:rd_kafka_DeleteTopic_new, librdkafka),
        Ptr{rd_kafka_DeleteTopic_t},
        (Ptr{Cchar},),
        topic,
    )
end

function rd_kafka_DeleteTopic_destroy(del_topic)
    ccall(
        (:rd_kafka_DeleteTopic_destroy, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_DeleteTopic_t},),
        del_topic,
    )
end

function rd_kafka_DeleteTopic_destroy_array(del_topics, del_topic_cnt)
    ccall(
        (:rd_kafka_DeleteTopic_destroy_array, librdkafka),
        Cvoid,
        (Ptr{Ptr{rd_kafka_DeleteTopic_t}}, Csize_t),
        del_topics,
        del_topic_cnt,
    )
end

function rd_kafka_DeleteTopics(rk, del_topics, del_topic_cnt, options, rkqu)
    ccall(
        (:rd_kafka_DeleteTopics, librdkafka),
        Cvoid,
        (
            Ptr{rd_kafka_t},
            Ptr{Ptr{rd_kafka_DeleteTopic_t}},
            Csize_t,
            Ptr{rd_kafka_AdminOptions_t},
            Ptr{rd_kafka_queue_t},
        ),
        rk,
        del_topics,
        del_topic_cnt,
        options,
        rkqu,
    )
end

function rd_kafka_DeleteTopics_result_topics(result, cntp)
    ccall(
        (:rd_kafka_DeleteTopics_result_topics, librdkafka),
        Ptr{Ptr{rd_kafka_topic_result_t}},
        (Ptr{rd_kafka_DeleteTopics_result_t}, Ptr{Csize_t}),
        result,
        cntp,
    )
end

mutable struct rd_kafka_NewPartitions_s end

const rd_kafka_NewPartitions_t = rd_kafka_NewPartitions_s

function rd_kafka_NewPartitions_new(topic, new_total_cnt, errstr, errstr_size)
    ccall(
        (:rd_kafka_NewPartitions_new, librdkafka),
        Ptr{rd_kafka_NewPartitions_t},
        (Ptr{Cchar}, Csize_t, Ptr{Cchar}, Csize_t),
        topic,
        new_total_cnt,
        errstr,
        errstr_size,
    )
end

function rd_kafka_NewPartitions_destroy(new_parts)
    ccall(
        (:rd_kafka_NewPartitions_destroy, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_NewPartitions_t},),
        new_parts,
    )
end

function rd_kafka_NewPartitions_destroy_array(new_parts, new_parts_cnt)
    ccall(
        (:rd_kafka_NewPartitions_destroy_array, librdkafka),
        Cvoid,
        (Ptr{Ptr{rd_kafka_NewPartitions_t}}, Csize_t),
        new_parts,
        new_parts_cnt,
    )
end

function rd_kafka_NewPartitions_set_replica_assignment(
    new_parts,
    new_partition_idx,
    broker_ids,
    broker_id_cnt,
    errstr,
    errstr_size,
)
    ccall(
        (:rd_kafka_NewPartitions_set_replica_assignment, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_NewPartitions_t}, Int32, Ptr{Int32}, Csize_t, Ptr{Cchar}, Csize_t),
        new_parts,
        new_partition_idx,
        broker_ids,
        broker_id_cnt,
        errstr,
        errstr_size,
    )
end

function rd_kafka_CreatePartitions(rk, new_parts, new_parts_cnt, options, rkqu)
    ccall(
        (:rd_kafka_CreatePartitions, librdkafka),
        Cvoid,
        (
            Ptr{rd_kafka_t},
            Ptr{Ptr{rd_kafka_NewPartitions_t}},
            Csize_t,
            Ptr{rd_kafka_AdminOptions_t},
            Ptr{rd_kafka_queue_t},
        ),
        rk,
        new_parts,
        new_parts_cnt,
        options,
        rkqu,
    )
end

function rd_kafka_CreatePartitions_result_topics(result, cntp)
    ccall(
        (:rd_kafka_CreatePartitions_result_topics, librdkafka),
        Ptr{Ptr{rd_kafka_topic_result_t}},
        (Ptr{rd_kafka_CreatePartitions_result_t}, Ptr{Csize_t}),
        result,
        cntp,
    )
end

@cenum rd_kafka_ConfigSource_t::UInt32 begin
    RD_KAFKA_CONFIG_SOURCE_UNKNOWN_CONFIG = 0
    RD_KAFKA_CONFIG_SOURCE_DYNAMIC_TOPIC_CONFIG = 1
    RD_KAFKA_CONFIG_SOURCE_DYNAMIC_BROKER_CONFIG = 2
    RD_KAFKA_CONFIG_SOURCE_DYNAMIC_DEFAULT_BROKER_CONFIG = 3
    RD_KAFKA_CONFIG_SOURCE_STATIC_BROKER_CONFIG = 4
    RD_KAFKA_CONFIG_SOURCE_DEFAULT_CONFIG = 5
    RD_KAFKA_CONFIG_SOURCE__CNT = 6
end

function rd_kafka_ConfigSource_name(confsource)
    ccall(
        (:rd_kafka_ConfigSource_name, librdkafka),
        Ptr{Cchar},
        (rd_kafka_ConfigSource_t,),
        confsource,
    )
end

mutable struct rd_kafka_ConfigEntry_s end

const rd_kafka_ConfigEntry_t = rd_kafka_ConfigEntry_s

function rd_kafka_ConfigEntry_name(entry)
    ccall(
        (:rd_kafka_ConfigEntry_name, librdkafka),
        Ptr{Cchar},
        (Ptr{rd_kafka_ConfigEntry_t},),
        entry,
    )
end

function rd_kafka_ConfigEntry_value(entry)
    ccall(
        (:rd_kafka_ConfigEntry_value, librdkafka),
        Ptr{Cchar},
        (Ptr{rd_kafka_ConfigEntry_t},),
        entry,
    )
end

function rd_kafka_ConfigEntry_source(entry)
    ccall(
        (:rd_kafka_ConfigEntry_source, librdkafka),
        rd_kafka_ConfigSource_t,
        (Ptr{rd_kafka_ConfigEntry_t},),
        entry,
    )
end

function rd_kafka_ConfigEntry_is_read_only(entry)
    ccall(
        (:rd_kafka_ConfigEntry_is_read_only, librdkafka),
        Cint,
        (Ptr{rd_kafka_ConfigEntry_t},),
        entry,
    )
end

function rd_kafka_ConfigEntry_is_default(entry)
    ccall(
        (:rd_kafka_ConfigEntry_is_default, librdkafka),
        Cint,
        (Ptr{rd_kafka_ConfigEntry_t},),
        entry,
    )
end

function rd_kafka_ConfigEntry_is_sensitive(entry)
    ccall(
        (:rd_kafka_ConfigEntry_is_sensitive, librdkafka),
        Cint,
        (Ptr{rd_kafka_ConfigEntry_t},),
        entry,
    )
end

function rd_kafka_ConfigEntry_is_synonym(entry)
    ccall(
        (:rd_kafka_ConfigEntry_is_synonym, librdkafka),
        Cint,
        (Ptr{rd_kafka_ConfigEntry_t},),
        entry,
    )
end

function rd_kafka_ConfigEntry_synonyms(entry, cntp)
    ccall(
        (:rd_kafka_ConfigEntry_synonyms, librdkafka),
        Ptr{Ptr{rd_kafka_ConfigEntry_t}},
        (Ptr{rd_kafka_ConfigEntry_t}, Ptr{Csize_t}),
        entry,
        cntp,
    )
end

@cenum rd_kafka_ResourceType_t::UInt32 begin
    RD_KAFKA_RESOURCE_UNKNOWN = 0
    RD_KAFKA_RESOURCE_ANY = 1
    RD_KAFKA_RESOURCE_TOPIC = 2
    RD_KAFKA_RESOURCE_GROUP = 3
    RD_KAFKA_RESOURCE_BROKER = 4
    RD_KAFKA_RESOURCE__CNT = 5
end

@cenum rd_kafka_ResourcePatternType_t::UInt32 begin
    RD_KAFKA_RESOURCE_PATTERN_UNKNOWN = 0
    RD_KAFKA_RESOURCE_PATTERN_ANY = 1
    RD_KAFKA_RESOURCE_PATTERN_MATCH = 2
    RD_KAFKA_RESOURCE_PATTERN_LITERAL = 3
    RD_KAFKA_RESOURCE_PATTERN_PREFIXED = 4
    RD_KAFKA_RESOURCE_PATTERN_TYPE__CNT = 5
end

@cenum rd_kafka_AlterConfigOpType_t::UInt32 begin
    RD_KAFKA_ALTER_CONFIG_OP_TYPE_SET = 0
    RD_KAFKA_ALTER_CONFIG_OP_TYPE_DELETE = 1
    RD_KAFKA_ALTER_CONFIG_OP_TYPE_APPEND = 2
    RD_KAFKA_ALTER_CONFIG_OP_TYPE_SUBTRACT = 3
    RD_KAFKA_ALTER_CONFIG_OP_TYPE__CNT = 4
end

function rd_kafka_ResourcePatternType_name(resource_pattern_type)
    ccall(
        (:rd_kafka_ResourcePatternType_name, librdkafka),
        Ptr{Cchar},
        (rd_kafka_ResourcePatternType_t,),
        resource_pattern_type,
    )
end

function rd_kafka_ResourceType_name(restype)
    ccall(
        (:rd_kafka_ResourceType_name, librdkafka),
        Ptr{Cchar},
        (rd_kafka_ResourceType_t,),
        restype,
    )
end

mutable struct rd_kafka_ConfigResource_s end

const rd_kafka_ConfigResource_t = rd_kafka_ConfigResource_s

function rd_kafka_ConfigResource_new(restype, resname)
    ccall(
        (:rd_kafka_ConfigResource_new, librdkafka),
        Ptr{rd_kafka_ConfigResource_t},
        (rd_kafka_ResourceType_t, Ptr{Cchar}),
        restype,
        resname,
    )
end

function rd_kafka_ConfigResource_destroy(config)
    ccall(
        (:rd_kafka_ConfigResource_destroy, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_ConfigResource_t},),
        config,
    )
end

function rd_kafka_ConfigResource_destroy_array(config, config_cnt)
    ccall(
        (:rd_kafka_ConfigResource_destroy_array, librdkafka),
        Cvoid,
        (Ptr{Ptr{rd_kafka_ConfigResource_t}}, Csize_t),
        config,
        config_cnt,
    )
end

function rd_kafka_ConfigResource_set_config(config, name, value)
    ccall(
        (:rd_kafka_ConfigResource_set_config, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_ConfigResource_t}, Ptr{Cchar}, Ptr{Cchar}),
        config,
        name,
        value,
    )
end

function rd_kafka_ConfigResource_add_incremental_config(config, name, op_type, value)
    ccall(
        (:rd_kafka_ConfigResource_add_incremental_config, librdkafka),
        Ptr{rd_kafka_error_t},
        (
            Ptr{rd_kafka_ConfigResource_t},
            Ptr{Cchar},
            rd_kafka_AlterConfigOpType_t,
            Ptr{Cchar},
        ),
        config,
        name,
        op_type,
        value,
    )
end

function rd_kafka_ConfigResource_configs(config, cntp)
    ccall(
        (:rd_kafka_ConfigResource_configs, librdkafka),
        Ptr{Ptr{rd_kafka_ConfigEntry_t}},
        (Ptr{rd_kafka_ConfigResource_t}, Ptr{Csize_t}),
        config,
        cntp,
    )
end

function rd_kafka_ConfigResource_type(config)
    ccall(
        (:rd_kafka_ConfigResource_type, librdkafka),
        rd_kafka_ResourceType_t,
        (Ptr{rd_kafka_ConfigResource_t},),
        config,
    )
end

function rd_kafka_ConfigResource_name(config)
    ccall(
        (:rd_kafka_ConfigResource_name, librdkafka),
        Ptr{Cchar},
        (Ptr{rd_kafka_ConfigResource_t},),
        config,
    )
end

function rd_kafka_ConfigResource_error(config)
    ccall(
        (:rd_kafka_ConfigResource_error, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_ConfigResource_t},),
        config,
    )
end

function rd_kafka_ConfigResource_error_string(config)
    ccall(
        (:rd_kafka_ConfigResource_error_string, librdkafka),
        Ptr{Cchar},
        (Ptr{rd_kafka_ConfigResource_t},),
        config,
    )
end

function rd_kafka_AlterConfigs(rk, configs, config_cnt, options, rkqu)
    ccall(
        (:rd_kafka_AlterConfigs, librdkafka),
        Cvoid,
        (
            Ptr{rd_kafka_t},
            Ptr{Ptr{rd_kafka_ConfigResource_t}},
            Csize_t,
            Ptr{rd_kafka_AdminOptions_t},
            Ptr{rd_kafka_queue_t},
        ),
        rk,
        configs,
        config_cnt,
        options,
        rkqu,
    )
end

function rd_kafka_AlterConfigs_result_resources(result, cntp)
    ccall(
        (:rd_kafka_AlterConfigs_result_resources, librdkafka),
        Ptr{Ptr{rd_kafka_ConfigResource_t}},
        (Ptr{rd_kafka_AlterConfigs_result_t}, Ptr{Csize_t}),
        result,
        cntp,
    )
end

function rd_kafka_IncrementalAlterConfigs(rk, configs, config_cnt, options, rkqu)
    ccall(
        (:rd_kafka_IncrementalAlterConfigs, librdkafka),
        Cvoid,
        (
            Ptr{rd_kafka_t},
            Ptr{Ptr{rd_kafka_ConfigResource_t}},
            Csize_t,
            Ptr{rd_kafka_AdminOptions_t},
            Ptr{rd_kafka_queue_t},
        ),
        rk,
        configs,
        config_cnt,
        options,
        rkqu,
    )
end

function rd_kafka_IncrementalAlterConfigs_result_resources(result, cntp)
    ccall(
        (:rd_kafka_IncrementalAlterConfigs_result_resources, librdkafka),
        Ptr{Ptr{rd_kafka_ConfigResource_t}},
        (Ptr{rd_kafka_IncrementalAlterConfigs_result_t}, Ptr{Csize_t}),
        result,
        cntp,
    )
end

function rd_kafka_DescribeConfigs(rk, configs, config_cnt, options, rkqu)
    ccall(
        (:rd_kafka_DescribeConfigs, librdkafka),
        Cvoid,
        (
            Ptr{rd_kafka_t},
            Ptr{Ptr{rd_kafka_ConfigResource_t}},
            Csize_t,
            Ptr{rd_kafka_AdminOptions_t},
            Ptr{rd_kafka_queue_t},
        ),
        rk,
        configs,
        config_cnt,
        options,
        rkqu,
    )
end

function rd_kafka_DescribeConfigs_result_resources(result, cntp)
    ccall(
        (:rd_kafka_DescribeConfigs_result_resources, librdkafka),
        Ptr{Ptr{rd_kafka_ConfigResource_t}},
        (Ptr{rd_kafka_DescribeConfigs_result_t}, Ptr{Csize_t}),
        result,
        cntp,
    )
end

mutable struct rd_kafka_DeleteRecords_s end

const rd_kafka_DeleteRecords_t = rd_kafka_DeleteRecords_s

function rd_kafka_DeleteRecords_new(before_offsets)
    ccall(
        (:rd_kafka_DeleteRecords_new, librdkafka),
        Ptr{rd_kafka_DeleteRecords_t},
        (Ptr{rd_kafka_topic_partition_list_t},),
        before_offsets,
    )
end

function rd_kafka_DeleteRecords_destroy(del_records)
    ccall(
        (:rd_kafka_DeleteRecords_destroy, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_DeleteRecords_t},),
        del_records,
    )
end

function rd_kafka_DeleteRecords_destroy_array(del_records, del_record_cnt)
    ccall(
        (:rd_kafka_DeleteRecords_destroy_array, librdkafka),
        Cvoid,
        (Ptr{Ptr{rd_kafka_DeleteRecords_t}}, Csize_t),
        del_records,
        del_record_cnt,
    )
end

function rd_kafka_DeleteRecords(rk, del_records, del_record_cnt, options, rkqu)
    ccall(
        (:rd_kafka_DeleteRecords, librdkafka),
        Cvoid,
        (
            Ptr{rd_kafka_t},
            Ptr{Ptr{rd_kafka_DeleteRecords_t}},
            Csize_t,
            Ptr{rd_kafka_AdminOptions_t},
            Ptr{rd_kafka_queue_t},
        ),
        rk,
        del_records,
        del_record_cnt,
        options,
        rkqu,
    )
end

function rd_kafka_DeleteRecords_result_offsets(result)
    ccall(
        (:rd_kafka_DeleteRecords_result_offsets, librdkafka),
        Ptr{rd_kafka_topic_partition_list_t},
        (Ptr{rd_kafka_DeleteRecords_result_t},),
        result,
    )
end

mutable struct rd_kafka_TopicCollection_s end

const rd_kafka_TopicCollection_t = rd_kafka_TopicCollection_s

mutable struct rd_kafka_TopicPartitionInfo_s end

const rd_kafka_TopicPartitionInfo_t = rd_kafka_TopicPartitionInfo_s

mutable struct rd_kafka_TopicDescription_s end

const rd_kafka_TopicDescription_t = rd_kafka_TopicDescription_s

function rd_kafka_TopicCollection_of_topic_names(topics, topics_cnt)
    ccall(
        (:rd_kafka_TopicCollection_of_topic_names, librdkafka),
        Ptr{rd_kafka_TopicCollection_t},
        (Ptr{Ptr{Cchar}}, Csize_t),
        topics,
        topics_cnt,
    )
end

function rd_kafka_TopicCollection_destroy(topics)
    ccall(
        (:rd_kafka_TopicCollection_destroy, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_TopicCollection_t},),
        topics,
    )
end

function rd_kafka_DescribeTopics(rk, topics, options, rkqu)
    ccall(
        (:rd_kafka_DescribeTopics, librdkafka),
        Cvoid,
        (
            Ptr{rd_kafka_t},
            Ptr{rd_kafka_TopicCollection_t},
            Ptr{rd_kafka_AdminOptions_t},
            Ptr{rd_kafka_queue_t},
        ),
        rk,
        topics,
        options,
        rkqu,
    )
end

function rd_kafka_DescribeTopics_result_topics(result, cntp)
    ccall(
        (:rd_kafka_DescribeTopics_result_topics, librdkafka),
        Ptr{Ptr{rd_kafka_TopicDescription_t}},
        (Ptr{rd_kafka_DescribeTopics_result_t}, Ptr{Csize_t}),
        result,
        cntp,
    )
end

function rd_kafka_TopicDescription_partitions(topicdesc, cntp)
    ccall(
        (:rd_kafka_TopicDescription_partitions, librdkafka),
        Ptr{Ptr{rd_kafka_TopicPartitionInfo_t}},
        (Ptr{rd_kafka_TopicDescription_t}, Ptr{Csize_t}),
        topicdesc,
        cntp,
    )
end

function rd_kafka_TopicPartitionInfo_partition(partition)
    ccall(
        (:rd_kafka_TopicPartitionInfo_partition, librdkafka),
        Cint,
        (Ptr{rd_kafka_TopicPartitionInfo_t},),
        partition,
    )
end

function rd_kafka_TopicPartitionInfo_leader(partition)
    ccall(
        (:rd_kafka_TopicPartitionInfo_leader, librdkafka),
        Ptr{rd_kafka_Node_t},
        (Ptr{rd_kafka_TopicPartitionInfo_t},),
        partition,
    )
end

function rd_kafka_TopicPartitionInfo_isr(partition, cntp)
    ccall(
        (:rd_kafka_TopicPartitionInfo_isr, librdkafka),
        Ptr{Ptr{rd_kafka_Node_t}},
        (Ptr{rd_kafka_TopicPartitionInfo_t}, Ptr{Csize_t}),
        partition,
        cntp,
    )
end

function rd_kafka_TopicPartitionInfo_replicas(partition, cntp)
    ccall(
        (:rd_kafka_TopicPartitionInfo_replicas, librdkafka),
        Ptr{Ptr{rd_kafka_Node_t}},
        (Ptr{rd_kafka_TopicPartitionInfo_t}, Ptr{Csize_t}),
        partition,
        cntp,
    )
end

function rd_kafka_TopicDescription_authorized_operations(topicdesc, cntp)
    ccall(
        (:rd_kafka_TopicDescription_authorized_operations, librdkafka),
        Ptr{rd_kafka_AclOperation_t},
        (Ptr{rd_kafka_TopicDescription_t}, Ptr{Csize_t}),
        topicdesc,
        cntp,
    )
end

function rd_kafka_TopicDescription_name(topicdesc)
    ccall(
        (:rd_kafka_TopicDescription_name, librdkafka),
        Ptr{Cchar},
        (Ptr{rd_kafka_TopicDescription_t},),
        topicdesc,
    )
end

function rd_kafka_TopicDescription_topic_id(topicdesc)
    ccall(
        (:rd_kafka_TopicDescription_topic_id, librdkafka),
        Ptr{rd_kafka_Uuid_t},
        (Ptr{rd_kafka_TopicDescription_t},),
        topicdesc,
    )
end

function rd_kafka_TopicDescription_is_internal(topicdesc)
    ccall(
        (:rd_kafka_TopicDescription_is_internal, librdkafka),
        Cint,
        (Ptr{rd_kafka_TopicDescription_t},),
        topicdesc,
    )
end

function rd_kafka_TopicDescription_error(topicdesc)
    ccall(
        (:rd_kafka_TopicDescription_error, librdkafka),
        Ptr{rd_kafka_error_t},
        (Ptr{rd_kafka_TopicDescription_t},),
        topicdesc,
    )
end

function rd_kafka_DescribeCluster(rk, options, rkqu)
    ccall(
        (:rd_kafka_DescribeCluster, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_t}, Ptr{rd_kafka_AdminOptions_t}, Ptr{rd_kafka_queue_t}),
        rk,
        options,
        rkqu,
    )
end

function rd_kafka_DescribeCluster_result_nodes(result, cntp)
    ccall(
        (:rd_kafka_DescribeCluster_result_nodes, librdkafka),
        Ptr{Ptr{rd_kafka_Node_t}},
        (Ptr{rd_kafka_DescribeCluster_result_t}, Ptr{Csize_t}),
        result,
        cntp,
    )
end

function rd_kafka_DescribeCluster_result_authorized_operations(result, cntp)
    ccall(
        (:rd_kafka_DescribeCluster_result_authorized_operations, librdkafka),
        Ptr{rd_kafka_AclOperation_t},
        (Ptr{rd_kafka_DescribeCluster_result_t}, Ptr{Csize_t}),
        result,
        cntp,
    )
end

function rd_kafka_DescribeCluster_result_controller(result)
    ccall(
        (:rd_kafka_DescribeCluster_result_controller, librdkafka),
        Ptr{rd_kafka_Node_t},
        (Ptr{rd_kafka_DescribeCluster_result_t},),
        result,
    )
end

function rd_kafka_DescribeCluster_result_cluster_id(result)
    ccall(
        (:rd_kafka_DescribeCluster_result_cluster_id, librdkafka),
        Ptr{Cchar},
        (Ptr{rd_kafka_DescribeCluster_result_t},),
        result,
    )
end

mutable struct rd_kafka_ConsumerGroupListing_s end

const rd_kafka_ConsumerGroupListing_t = rd_kafka_ConsumerGroupListing_s

mutable struct rd_kafka_ListConsumerGroupsResult_s end

const rd_kafka_ListConsumerGroupsResult_t = rd_kafka_ListConsumerGroupsResult_s

function rd_kafka_ListConsumerGroups(rk, options, rkqu)
    ccall(
        (:rd_kafka_ListConsumerGroups, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_t}, Ptr{rd_kafka_AdminOptions_t}, Ptr{rd_kafka_queue_t}),
        rk,
        options,
        rkqu,
    )
end

function rd_kafka_ConsumerGroupListing_group_id(grplist)
    ccall(
        (:rd_kafka_ConsumerGroupListing_group_id, librdkafka),
        Ptr{Cchar},
        (Ptr{rd_kafka_ConsumerGroupListing_t},),
        grplist,
    )
end

function rd_kafka_ConsumerGroupListing_is_simple_consumer_group(grplist)
    ccall(
        (:rd_kafka_ConsumerGroupListing_is_simple_consumer_group, librdkafka),
        Cint,
        (Ptr{rd_kafka_ConsumerGroupListing_t},),
        grplist,
    )
end

function rd_kafka_ConsumerGroupListing_state(grplist)
    ccall(
        (:rd_kafka_ConsumerGroupListing_state, librdkafka),
        rd_kafka_consumer_group_state_t,
        (Ptr{rd_kafka_ConsumerGroupListing_t},),
        grplist,
    )
end

function rd_kafka_ListConsumerGroups_result_valid(result, cntp)
    ccall(
        (:rd_kafka_ListConsumerGroups_result_valid, librdkafka),
        Ptr{Ptr{rd_kafka_ConsumerGroupListing_t}},
        (Ptr{rd_kafka_ListConsumerGroups_result_t}, Ptr{Csize_t}),
        result,
        cntp,
    )
end

function rd_kafka_ListConsumerGroups_result_errors(result, cntp)
    ccall(
        (:rd_kafka_ListConsumerGroups_result_errors, librdkafka),
        Ptr{Ptr{rd_kafka_error_t}},
        (Ptr{rd_kafka_ListConsumerGroups_result_t}, Ptr{Csize_t}),
        result,
        cntp,
    )
end

mutable struct rd_kafka_ConsumerGroupDescription_s end

const rd_kafka_ConsumerGroupDescription_t = rd_kafka_ConsumerGroupDescription_s

mutable struct rd_kafka_MemberDescription_s end

const rd_kafka_MemberDescription_t = rd_kafka_MemberDescription_s

mutable struct rd_kafka_MemberAssignment_s end

const rd_kafka_MemberAssignment_t = rd_kafka_MemberAssignment_s

function rd_kafka_DescribeConsumerGroups(rk, groups, groups_cnt, options, rkqu)
    ccall(
        (:rd_kafka_DescribeConsumerGroups, librdkafka),
        Cvoid,
        (
            Ptr{rd_kafka_t},
            Ptr{Ptr{Cchar}},
            Csize_t,
            Ptr{rd_kafka_AdminOptions_t},
            Ptr{rd_kafka_queue_t},
        ),
        rk,
        groups,
        groups_cnt,
        options,
        rkqu,
    )
end

function rd_kafka_DescribeConsumerGroups_result_groups(result, cntp)
    ccall(
        (:rd_kafka_DescribeConsumerGroups_result_groups, librdkafka),
        Ptr{Ptr{rd_kafka_ConsumerGroupDescription_t}},
        (Ptr{rd_kafka_DescribeConsumerGroups_result_t}, Ptr{Csize_t}),
        result,
        cntp,
    )
end

function rd_kafka_ConsumerGroupDescription_group_id(grpdesc)
    ccall(
        (:rd_kafka_ConsumerGroupDescription_group_id, librdkafka),
        Ptr{Cchar},
        (Ptr{rd_kafka_ConsumerGroupDescription_t},),
        grpdesc,
    )
end

function rd_kafka_ConsumerGroupDescription_error(grpdesc)
    ccall(
        (:rd_kafka_ConsumerGroupDescription_error, librdkafka),
        Ptr{rd_kafka_error_t},
        (Ptr{rd_kafka_ConsumerGroupDescription_t},),
        grpdesc,
    )
end

function rd_kafka_ConsumerGroupDescription_is_simple_consumer_group(grpdesc)
    ccall(
        (:rd_kafka_ConsumerGroupDescription_is_simple_consumer_group, librdkafka),
        Cint,
        (Ptr{rd_kafka_ConsumerGroupDescription_t},),
        grpdesc,
    )
end

function rd_kafka_ConsumerGroupDescription_partition_assignor(grpdesc)
    ccall(
        (:rd_kafka_ConsumerGroupDescription_partition_assignor, librdkafka),
        Ptr{Cchar},
        (Ptr{rd_kafka_ConsumerGroupDescription_t},),
        grpdesc,
    )
end

function rd_kafka_ConsumerGroupDescription_authorized_operations(grpdesc, cntp)
    ccall(
        (:rd_kafka_ConsumerGroupDescription_authorized_operations, librdkafka),
        Ptr{rd_kafka_AclOperation_t},
        (Ptr{rd_kafka_ConsumerGroupDescription_t}, Ptr{Csize_t}),
        grpdesc,
        cntp,
    )
end

function rd_kafka_ConsumerGroupDescription_state(grpdesc)
    ccall(
        (:rd_kafka_ConsumerGroupDescription_state, librdkafka),
        rd_kafka_consumer_group_state_t,
        (Ptr{rd_kafka_ConsumerGroupDescription_t},),
        grpdesc,
    )
end

function rd_kafka_ConsumerGroupDescription_coordinator(grpdesc)
    ccall(
        (:rd_kafka_ConsumerGroupDescription_coordinator, librdkafka),
        Ptr{rd_kafka_Node_t},
        (Ptr{rd_kafka_ConsumerGroupDescription_t},),
        grpdesc,
    )
end

function rd_kafka_ConsumerGroupDescription_member_count(grpdesc)
    ccall(
        (:rd_kafka_ConsumerGroupDescription_member_count, librdkafka),
        Csize_t,
        (Ptr{rd_kafka_ConsumerGroupDescription_t},),
        grpdesc,
    )
end

function rd_kafka_ConsumerGroupDescription_member(grpdesc, idx)
    ccall(
        (:rd_kafka_ConsumerGroupDescription_member, librdkafka),
        Ptr{rd_kafka_MemberDescription_t},
        (Ptr{rd_kafka_ConsumerGroupDescription_t}, Csize_t),
        grpdesc,
        idx,
    )
end

function rd_kafka_MemberDescription_client_id(member)
    ccall(
        (:rd_kafka_MemberDescription_client_id, librdkafka),
        Ptr{Cchar},
        (Ptr{rd_kafka_MemberDescription_t},),
        member,
    )
end

function rd_kafka_MemberDescription_group_instance_id(member)
    ccall(
        (:rd_kafka_MemberDescription_group_instance_id, librdkafka),
        Ptr{Cchar},
        (Ptr{rd_kafka_MemberDescription_t},),
        member,
    )
end

function rd_kafka_MemberDescription_consumer_id(member)
    ccall(
        (:rd_kafka_MemberDescription_consumer_id, librdkafka),
        Ptr{Cchar},
        (Ptr{rd_kafka_MemberDescription_t},),
        member,
    )
end

function rd_kafka_MemberDescription_host(member)
    ccall(
        (:rd_kafka_MemberDescription_host, librdkafka),
        Ptr{Cchar},
        (Ptr{rd_kafka_MemberDescription_t},),
        member,
    )
end

function rd_kafka_MemberDescription_assignment(member)
    ccall(
        (:rd_kafka_MemberDescription_assignment, librdkafka),
        Ptr{rd_kafka_MemberAssignment_t},
        (Ptr{rd_kafka_MemberDescription_t},),
        member,
    )
end

function rd_kafka_MemberAssignment_partitions(assignment)
    ccall(
        (:rd_kafka_MemberAssignment_partitions, librdkafka),
        Ptr{rd_kafka_topic_partition_list_t},
        (Ptr{rd_kafka_MemberAssignment_t},),
        assignment,
    )
end

mutable struct rd_kafka_DeleteGroup_s end

const rd_kafka_DeleteGroup_t = rd_kafka_DeleteGroup_s

function rd_kafka_DeleteGroup_new(group)
    ccall(
        (:rd_kafka_DeleteGroup_new, librdkafka),
        Ptr{rd_kafka_DeleteGroup_t},
        (Ptr{Cchar},),
        group,
    )
end

function rd_kafka_DeleteGroup_destroy(del_group)
    ccall(
        (:rd_kafka_DeleteGroup_destroy, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_DeleteGroup_t},),
        del_group,
    )
end

function rd_kafka_DeleteGroup_destroy_array(del_groups, del_group_cnt)
    ccall(
        (:rd_kafka_DeleteGroup_destroy_array, librdkafka),
        Cvoid,
        (Ptr{Ptr{rd_kafka_DeleteGroup_t}}, Csize_t),
        del_groups,
        del_group_cnt,
    )
end

function rd_kafka_DeleteGroups(rk, del_groups, del_group_cnt, options, rkqu)
    ccall(
        (:rd_kafka_DeleteGroups, librdkafka),
        Cvoid,
        (
            Ptr{rd_kafka_t},
            Ptr{Ptr{rd_kafka_DeleteGroup_t}},
            Csize_t,
            Ptr{rd_kafka_AdminOptions_t},
            Ptr{rd_kafka_queue_t},
        ),
        rk,
        del_groups,
        del_group_cnt,
        options,
        rkqu,
    )
end

function rd_kafka_DeleteGroups_result_groups(result, cntp)
    ccall(
        (:rd_kafka_DeleteGroups_result_groups, librdkafka),
        Ptr{Ptr{rd_kafka_group_result_t}},
        (Ptr{rd_kafka_DeleteGroups_result_t}, Ptr{Csize_t}),
        result,
        cntp,
    )
end

mutable struct rd_kafka_ListConsumerGroupOffsets_s end

const rd_kafka_ListConsumerGroupOffsets_t = rd_kafka_ListConsumerGroupOffsets_s

function rd_kafka_ListConsumerGroupOffsets_new(group_id, partitions)
    ccall(
        (:rd_kafka_ListConsumerGroupOffsets_new, librdkafka),
        Ptr{rd_kafka_ListConsumerGroupOffsets_t},
        (Ptr{Cchar}, Ptr{rd_kafka_topic_partition_list_t}),
        group_id,
        partitions,
    )
end

function rd_kafka_ListConsumerGroupOffsets_destroy(list_grpoffsets)
    ccall(
        (:rd_kafka_ListConsumerGroupOffsets_destroy, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_ListConsumerGroupOffsets_t},),
        list_grpoffsets,
    )
end

function rd_kafka_ListConsumerGroupOffsets_destroy_array(
    list_grpoffsets,
    list_grpoffset_cnt,
)
    ccall(
        (:rd_kafka_ListConsumerGroupOffsets_destroy_array, librdkafka),
        Cvoid,
        (Ptr{Ptr{rd_kafka_ListConsumerGroupOffsets_t}}, Csize_t),
        list_grpoffsets,
        list_grpoffset_cnt,
    )
end

function rd_kafka_ListConsumerGroupOffsets(
    rk,
    list_grpoffsets,
    list_grpoffsets_cnt,
    options,
    rkqu,
)
    ccall(
        (:rd_kafka_ListConsumerGroupOffsets, librdkafka),
        Cvoid,
        (
            Ptr{rd_kafka_t},
            Ptr{Ptr{rd_kafka_ListConsumerGroupOffsets_t}},
            Csize_t,
            Ptr{rd_kafka_AdminOptions_t},
            Ptr{rd_kafka_queue_t},
        ),
        rk,
        list_grpoffsets,
        list_grpoffsets_cnt,
        options,
        rkqu,
    )
end

function rd_kafka_ListConsumerGroupOffsets_result_groups(result, cntp)
    ccall(
        (:rd_kafka_ListConsumerGroupOffsets_result_groups, librdkafka),
        Ptr{Ptr{rd_kafka_group_result_t}},
        (Ptr{rd_kafka_ListConsumerGroupOffsets_result_t}, Ptr{Csize_t}),
        result,
        cntp,
    )
end

mutable struct rd_kafka_AlterConsumerGroupOffsets_s end

const rd_kafka_AlterConsumerGroupOffsets_t = rd_kafka_AlterConsumerGroupOffsets_s

function rd_kafka_AlterConsumerGroupOffsets_new(group_id, partitions)
    ccall(
        (:rd_kafka_AlterConsumerGroupOffsets_new, librdkafka),
        Ptr{rd_kafka_AlterConsumerGroupOffsets_t},
        (Ptr{Cchar}, Ptr{rd_kafka_topic_partition_list_t}),
        group_id,
        partitions,
    )
end

function rd_kafka_AlterConsumerGroupOffsets_destroy(alter_grpoffsets)
    ccall(
        (:rd_kafka_AlterConsumerGroupOffsets_destroy, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_AlterConsumerGroupOffsets_t},),
        alter_grpoffsets,
    )
end

function rd_kafka_AlterConsumerGroupOffsets_destroy_array(
    alter_grpoffsets,
    alter_grpoffset_cnt,
)
    ccall(
        (:rd_kafka_AlterConsumerGroupOffsets_destroy_array, librdkafka),
        Cvoid,
        (Ptr{Ptr{rd_kafka_AlterConsumerGroupOffsets_t}}, Csize_t),
        alter_grpoffsets,
        alter_grpoffset_cnt,
    )
end

function rd_kafka_AlterConsumerGroupOffsets(
    rk,
    alter_grpoffsets,
    alter_grpoffsets_cnt,
    options,
    rkqu,
)
    ccall(
        (:rd_kafka_AlterConsumerGroupOffsets, librdkafka),
        Cvoid,
        (
            Ptr{rd_kafka_t},
            Ptr{Ptr{rd_kafka_AlterConsumerGroupOffsets_t}},
            Csize_t,
            Ptr{rd_kafka_AdminOptions_t},
            Ptr{rd_kafka_queue_t},
        ),
        rk,
        alter_grpoffsets,
        alter_grpoffsets_cnt,
        options,
        rkqu,
    )
end

function rd_kafka_AlterConsumerGroupOffsets_result_groups(result, cntp)
    ccall(
        (:rd_kafka_AlterConsumerGroupOffsets_result_groups, librdkafka),
        Ptr{Ptr{rd_kafka_group_result_t}},
        (Ptr{rd_kafka_AlterConsumerGroupOffsets_result_t}, Ptr{Csize_t}),
        result,
        cntp,
    )
end

mutable struct rd_kafka_DeleteConsumerGroupOffsets_s end

const rd_kafka_DeleteConsumerGroupOffsets_t = rd_kafka_DeleteConsumerGroupOffsets_s

function rd_kafka_DeleteConsumerGroupOffsets_new(group, partitions)
    ccall(
        (:rd_kafka_DeleteConsumerGroupOffsets_new, librdkafka),
        Ptr{rd_kafka_DeleteConsumerGroupOffsets_t},
        (Ptr{Cchar}, Ptr{rd_kafka_topic_partition_list_t}),
        group,
        partitions,
    )
end

function rd_kafka_DeleteConsumerGroupOffsets_destroy(del_grpoffsets)
    ccall(
        (:rd_kafka_DeleteConsumerGroupOffsets_destroy, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_DeleteConsumerGroupOffsets_t},),
        del_grpoffsets,
    )
end

function rd_kafka_DeleteConsumerGroupOffsets_destroy_array(
    del_grpoffsets,
    del_grpoffset_cnt,
)
    ccall(
        (:rd_kafka_DeleteConsumerGroupOffsets_destroy_array, librdkafka),
        Cvoid,
        (Ptr{Ptr{rd_kafka_DeleteConsumerGroupOffsets_t}}, Csize_t),
        del_grpoffsets,
        del_grpoffset_cnt,
    )
end

function rd_kafka_DeleteConsumerGroupOffsets(
    rk,
    del_grpoffsets,
    del_grpoffsets_cnt,
    options,
    rkqu,
)
    ccall(
        (:rd_kafka_DeleteConsumerGroupOffsets, librdkafka),
        Cvoid,
        (
            Ptr{rd_kafka_t},
            Ptr{Ptr{rd_kafka_DeleteConsumerGroupOffsets_t}},
            Csize_t,
            Ptr{rd_kafka_AdminOptions_t},
            Ptr{rd_kafka_queue_t},
        ),
        rk,
        del_grpoffsets,
        del_grpoffsets_cnt,
        options,
        rkqu,
    )
end

function rd_kafka_DeleteConsumerGroupOffsets_result_groups(result, cntp)
    ccall(
        (:rd_kafka_DeleteConsumerGroupOffsets_result_groups, librdkafka),
        Ptr{Ptr{rd_kafka_group_result_t}},
        (Ptr{rd_kafka_DeleteConsumerGroupOffsets_result_t}, Ptr{Csize_t}),
        result,
        cntp,
    )
end

@cenum rd_kafka_OffsetSpec_t::Int32 begin
    RD_KAFKA_OFFSET_SPEC_MAX_TIMESTAMP = -3
    RD_KAFKA_OFFSET_SPEC_EARLIEST = -2
    RD_KAFKA_OFFSET_SPEC_LATEST = -1
end

mutable struct rd_kafka_ListOffsetsResultInfo_s end

const rd_kafka_ListOffsetsResultInfo_t = rd_kafka_ListOffsetsResultInfo_s

function rd_kafka_ListOffsetsResultInfo_topic_partition(result_info)
    ccall(
        (:rd_kafka_ListOffsetsResultInfo_topic_partition, librdkafka),
        Ptr{rd_kafka_topic_partition_t},
        (Ptr{rd_kafka_ListOffsetsResultInfo_t},),
        result_info,
    )
end

function rd_kafka_ListOffsetsResultInfo_timestamp(result_info)
    ccall(
        (:rd_kafka_ListOffsetsResultInfo_timestamp, librdkafka),
        Int64,
        (Ptr{rd_kafka_ListOffsetsResultInfo_t},),
        result_info,
    )
end

function rd_kafka_ListOffsets_result_infos(result, cntp)
    ccall(
        (:rd_kafka_ListOffsets_result_infos, librdkafka),
        Ptr{Ptr{rd_kafka_ListOffsetsResultInfo_t}},
        (Ptr{rd_kafka_ListOffsets_result_t}, Ptr{Csize_t}),
        result,
        cntp,
    )
end

function rd_kafka_ListOffsets(rk, topic_partitions, options, rkqu)
    ccall(
        (:rd_kafka_ListOffsets, librdkafka),
        Cvoid,
        (
            Ptr{rd_kafka_t},
            Ptr{rd_kafka_topic_partition_list_t},
            Ptr{rd_kafka_AdminOptions_t},
            Ptr{rd_kafka_queue_t},
        ),
        rk,
        topic_partitions,
        options,
        rkqu,
    )
end

@cenum rd_kafka_ScramMechanism_t::UInt32 begin
    RD_KAFKA_SCRAM_MECHANISM_UNKNOWN = 0
    RD_KAFKA_SCRAM_MECHANISM_SHA_256 = 1
    RD_KAFKA_SCRAM_MECHANISM_SHA_512 = 2
    RD_KAFKA_SCRAM_MECHANISM__CNT = 3
end

mutable struct rd_kafka_ScramCredentialInfo_s end

const rd_kafka_ScramCredentialInfo_t = rd_kafka_ScramCredentialInfo_s

function rd_kafka_ScramCredentialInfo_mechanism(scram_credential_info)
    ccall(
        (:rd_kafka_ScramCredentialInfo_mechanism, librdkafka),
        rd_kafka_ScramMechanism_t,
        (Ptr{rd_kafka_ScramCredentialInfo_t},),
        scram_credential_info,
    )
end

function rd_kafka_ScramCredentialInfo_iterations(scram_credential_info)
    ccall(
        (:rd_kafka_ScramCredentialInfo_iterations, librdkafka),
        Int32,
        (Ptr{rd_kafka_ScramCredentialInfo_t},),
        scram_credential_info,
    )
end

mutable struct rd_kafka_UserScramCredentialsDescription_s end

const rd_kafka_UserScramCredentialsDescription_t =
    rd_kafka_UserScramCredentialsDescription_s

function rd_kafka_UserScramCredentialsDescription_user(description)
    ccall(
        (:rd_kafka_UserScramCredentialsDescription_user, librdkafka),
        Ptr{Cchar},
        (Ptr{rd_kafka_UserScramCredentialsDescription_t},),
        description,
    )
end

function rd_kafka_UserScramCredentialsDescription_error(description)
    ccall(
        (:rd_kafka_UserScramCredentialsDescription_error, librdkafka),
        Ptr{rd_kafka_error_t},
        (Ptr{rd_kafka_UserScramCredentialsDescription_t},),
        description,
    )
end

function rd_kafka_UserScramCredentialsDescription_scramcredentialinfo_count(description)
    ccall(
        (:rd_kafka_UserScramCredentialsDescription_scramcredentialinfo_count, librdkafka),
        Csize_t,
        (Ptr{rd_kafka_UserScramCredentialsDescription_t},),
        description,
    )
end

function rd_kafka_UserScramCredentialsDescription_scramcredentialinfo(description, idx)
    ccall(
        (:rd_kafka_UserScramCredentialsDescription_scramcredentialinfo, librdkafka),
        Ptr{rd_kafka_ScramCredentialInfo_t},
        (Ptr{rd_kafka_UserScramCredentialsDescription_t}, Csize_t),
        description,
        idx,
    )
end

function rd_kafka_DescribeUserScramCredentials_result_descriptions(result, cntp)
    ccall(
        (:rd_kafka_DescribeUserScramCredentials_result_descriptions, librdkafka),
        Ptr{Ptr{rd_kafka_UserScramCredentialsDescription_t}},
        (Ptr{rd_kafka_DescribeUserScramCredentials_result_t}, Ptr{Csize_t}),
        result,
        cntp,
    )
end

function rd_kafka_DescribeUserScramCredentials(rk, users, user_cnt, options, rkqu)
    ccall(
        (:rd_kafka_DescribeUserScramCredentials, librdkafka),
        Cvoid,
        (
            Ptr{rd_kafka_t},
            Ptr{Ptr{Cchar}},
            Csize_t,
            Ptr{rd_kafka_AdminOptions_t},
            Ptr{rd_kafka_queue_t},
        ),
        rk,
        users,
        user_cnt,
        options,
        rkqu,
    )
end

mutable struct rd_kafka_UserScramCredentialAlteration_s end

const rd_kafka_UserScramCredentialAlteration_t = rd_kafka_UserScramCredentialAlteration_s

function rd_kafka_UserScramCredentialUpsertion_new(
    username,
    mechanism,
    iterations,
    password,
    password_size,
    salt,
    salt_size,
)
    ccall(
        (:rd_kafka_UserScramCredentialUpsertion_new, librdkafka),
        Ptr{rd_kafka_UserScramCredentialAlteration_t},
        (
            Ptr{Cchar},
            rd_kafka_ScramMechanism_t,
            Int32,
            Ptr{Cuchar},
            Csize_t,
            Ptr{Cuchar},
            Csize_t,
        ),
        username,
        mechanism,
        iterations,
        password,
        password_size,
        salt,
        salt_size,
    )
end

function rd_kafka_UserScramCredentialDeletion_new(username, mechanism)
    ccall(
        (:rd_kafka_UserScramCredentialDeletion_new, librdkafka),
        Ptr{rd_kafka_UserScramCredentialAlteration_t},
        (Ptr{Cchar}, rd_kafka_ScramMechanism_t),
        username,
        mechanism,
    )
end

function rd_kafka_UserScramCredentialAlteration_destroy(alteration)
    ccall(
        (:rd_kafka_UserScramCredentialAlteration_destroy, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_UserScramCredentialAlteration_t},),
        alteration,
    )
end

function rd_kafka_UserScramCredentialAlteration_destroy_array(alterations, alteration_cnt)
    ccall(
        (:rd_kafka_UserScramCredentialAlteration_destroy_array, librdkafka),
        Cvoid,
        (Ptr{Ptr{rd_kafka_UserScramCredentialAlteration_t}}, Csize_t),
        alterations,
        alteration_cnt,
    )
end

mutable struct rd_kafka_AlterUserScramCredentials_result_response_s end

const rd_kafka_AlterUserScramCredentials_result_response_t =
    rd_kafka_AlterUserScramCredentials_result_response_s

function rd_kafka_AlterUserScramCredentials_result_response_user(response)
    ccall(
        (:rd_kafka_AlterUserScramCredentials_result_response_user, librdkafka),
        Ptr{Cchar},
        (Ptr{rd_kafka_AlterUserScramCredentials_result_response_t},),
        response,
    )
end

function rd_kafka_AlterUserScramCredentials_result_response_error(response)
    ccall(
        (:rd_kafka_AlterUserScramCredentials_result_response_error, librdkafka),
        Ptr{rd_kafka_error_t},
        (Ptr{rd_kafka_AlterUserScramCredentials_result_response_t},),
        response,
    )
end

function rd_kafka_AlterUserScramCredentials_result_responses(result, cntp)
    ccall(
        (:rd_kafka_AlterUserScramCredentials_result_responses, librdkafka),
        Ptr{Ptr{rd_kafka_AlterUserScramCredentials_result_response_t}},
        (Ptr{rd_kafka_AlterUserScramCredentials_result_t}, Ptr{Csize_t}),
        result,
        cntp,
    )
end

function rd_kafka_AlterUserScramCredentials(rk, alterations, alteration_cnt, options, rkqu)
    ccall(
        (:rd_kafka_AlterUserScramCredentials, librdkafka),
        Cvoid,
        (
            Ptr{rd_kafka_t},
            Ptr{Ptr{rd_kafka_UserScramCredentialAlteration_t}},
            Csize_t,
            Ptr{rd_kafka_AdminOptions_t},
            Ptr{rd_kafka_queue_t},
        ),
        rk,
        alterations,
        alteration_cnt,
        options,
        rkqu,
    )
end

mutable struct rd_kafka_AclBinding_s end

const rd_kafka_AclBinding_t = rd_kafka_AclBinding_s

const rd_kafka_AclBindingFilter_t = rd_kafka_AclBinding_t

function rd_kafka_acl_result_error(aclres)
    ccall(
        (:rd_kafka_acl_result_error, librdkafka),
        Ptr{rd_kafka_error_t},
        (Ptr{rd_kafka_acl_result_t},),
        aclres,
    )
end

function rd_kafka_AclOperation_name(acl_operation)
    ccall(
        (:rd_kafka_AclOperation_name, librdkafka),
        Ptr{Cchar},
        (rd_kafka_AclOperation_t,),
        acl_operation,
    )
end

@cenum rd_kafka_AclPermissionType_t::UInt32 begin
    RD_KAFKA_ACL_PERMISSION_TYPE_UNKNOWN = 0
    RD_KAFKA_ACL_PERMISSION_TYPE_ANY = 1
    RD_KAFKA_ACL_PERMISSION_TYPE_DENY = 2
    RD_KAFKA_ACL_PERMISSION_TYPE_ALLOW = 3
    RD_KAFKA_ACL_PERMISSION_TYPE__CNT = 4
end

function rd_kafka_AclPermissionType_name(acl_permission_type)
    ccall(
        (:rd_kafka_AclPermissionType_name, librdkafka),
        Ptr{Cchar},
        (rd_kafka_AclPermissionType_t,),
        acl_permission_type,
    )
end

function rd_kafka_AclBinding_new(
    restype,
    name,
    resource_pattern_type,
    principal,
    host,
    operation,
    permission_type,
    errstr,
    errstr_size,
)
    ccall(
        (:rd_kafka_AclBinding_new, librdkafka),
        Ptr{rd_kafka_AclBinding_t},
        (
            rd_kafka_ResourceType_t,
            Ptr{Cchar},
            rd_kafka_ResourcePatternType_t,
            Ptr{Cchar},
            Ptr{Cchar},
            rd_kafka_AclOperation_t,
            rd_kafka_AclPermissionType_t,
            Ptr{Cchar},
            Csize_t,
        ),
        restype,
        name,
        resource_pattern_type,
        principal,
        host,
        operation,
        permission_type,
        errstr,
        errstr_size,
    )
end

function rd_kafka_AclBindingFilter_new(
    restype,
    name,
    resource_pattern_type,
    principal,
    host,
    operation,
    permission_type,
    errstr,
    errstr_size,
)
    ccall(
        (:rd_kafka_AclBindingFilter_new, librdkafka),
        Ptr{rd_kafka_AclBindingFilter_t},
        (
            rd_kafka_ResourceType_t,
            Ptr{Cchar},
            rd_kafka_ResourcePatternType_t,
            Ptr{Cchar},
            Ptr{Cchar},
            rd_kafka_AclOperation_t,
            rd_kafka_AclPermissionType_t,
            Ptr{Cchar},
            Csize_t,
        ),
        restype,
        name,
        resource_pattern_type,
        principal,
        host,
        operation,
        permission_type,
        errstr,
        errstr_size,
    )
end

function rd_kafka_AclBinding_restype(acl)
    ccall(
        (:rd_kafka_AclBinding_restype, librdkafka),
        rd_kafka_ResourceType_t,
        (Ptr{rd_kafka_AclBinding_t},),
        acl,
    )
end

function rd_kafka_AclBinding_name(acl)
    ccall(
        (:rd_kafka_AclBinding_name, librdkafka),
        Ptr{Cchar},
        (Ptr{rd_kafka_AclBinding_t},),
        acl,
    )
end

function rd_kafka_AclBinding_principal(acl)
    ccall(
        (:rd_kafka_AclBinding_principal, librdkafka),
        Ptr{Cchar},
        (Ptr{rd_kafka_AclBinding_t},),
        acl,
    )
end

function rd_kafka_AclBinding_host(acl)
    ccall(
        (:rd_kafka_AclBinding_host, librdkafka),
        Ptr{Cchar},
        (Ptr{rd_kafka_AclBinding_t},),
        acl,
    )
end

function rd_kafka_AclBinding_operation(acl)
    ccall(
        (:rd_kafka_AclBinding_operation, librdkafka),
        rd_kafka_AclOperation_t,
        (Ptr{rd_kafka_AclBinding_t},),
        acl,
    )
end

function rd_kafka_AclBinding_permission_type(acl)
    ccall(
        (:rd_kafka_AclBinding_permission_type, librdkafka),
        rd_kafka_AclPermissionType_t,
        (Ptr{rd_kafka_AclBinding_t},),
        acl,
    )
end

function rd_kafka_AclBinding_resource_pattern_type(acl)
    ccall(
        (:rd_kafka_AclBinding_resource_pattern_type, librdkafka),
        rd_kafka_ResourcePatternType_t,
        (Ptr{rd_kafka_AclBinding_t},),
        acl,
    )
end

function rd_kafka_AclBinding_error(acl)
    ccall(
        (:rd_kafka_AclBinding_error, librdkafka),
        Ptr{rd_kafka_error_t},
        (Ptr{rd_kafka_AclBinding_t},),
        acl,
    )
end

function rd_kafka_AclBinding_destroy(acl_binding)
    ccall(
        (:rd_kafka_AclBinding_destroy, librdkafka),
        Cvoid,
        (Ptr{rd_kafka_AclBinding_t},),
        acl_binding,
    )
end

function rd_kafka_AclBinding_destroy_array(acl_bindings, acl_bindings_cnt)
    ccall(
        (:rd_kafka_AclBinding_destroy_array, librdkafka),
        Cvoid,
        (Ptr{Ptr{rd_kafka_AclBinding_t}}, Csize_t),
        acl_bindings,
        acl_bindings_cnt,
    )
end

function rd_kafka_CreateAcls_result_acls(result, cntp)
    ccall(
        (:rd_kafka_CreateAcls_result_acls, librdkafka),
        Ptr{Ptr{rd_kafka_acl_result_t}},
        (Ptr{rd_kafka_CreateAcls_result_t}, Ptr{Csize_t}),
        result,
        cntp,
    )
end

function rd_kafka_CreateAcls(rk, new_acls, new_acls_cnt, options, rkqu)
    ccall(
        (:rd_kafka_CreateAcls, librdkafka),
        Cvoid,
        (
            Ptr{rd_kafka_t},
            Ptr{Ptr{rd_kafka_AclBinding_t}},
            Csize_t,
            Ptr{rd_kafka_AdminOptions_t},
            Ptr{rd_kafka_queue_t},
        ),
        rk,
        new_acls,
        new_acls_cnt,
        options,
        rkqu,
    )
end

function rd_kafka_DescribeAcls_result_acls(result, cntp)
    ccall(
        (:rd_kafka_DescribeAcls_result_acls, librdkafka),
        Ptr{Ptr{rd_kafka_AclBinding_t}},
        (Ptr{rd_kafka_DescribeAcls_result_t}, Ptr{Csize_t}),
        result,
        cntp,
    )
end

function rd_kafka_DescribeAcls(rk, acl_filter, options, rkqu)
    ccall(
        (:rd_kafka_DescribeAcls, librdkafka),
        Cvoid,
        (
            Ptr{rd_kafka_t},
            Ptr{rd_kafka_AclBindingFilter_t},
            Ptr{rd_kafka_AdminOptions_t},
            Ptr{rd_kafka_queue_t},
        ),
        rk,
        acl_filter,
        options,
        rkqu,
    )
end

mutable struct rd_kafka_DeleteAcls_result_response_s end

const rd_kafka_DeleteAcls_result_response_t = rd_kafka_DeleteAcls_result_response_s

function rd_kafka_DeleteAcls_result_responses(result, cntp)
    ccall(
        (:rd_kafka_DeleteAcls_result_responses, librdkafka),
        Ptr{Ptr{rd_kafka_DeleteAcls_result_response_t}},
        (Ptr{rd_kafka_DeleteAcls_result_t}, Ptr{Csize_t}),
        result,
        cntp,
    )
end

function rd_kafka_DeleteAcls_result_response_error(result_response)
    ccall(
        (:rd_kafka_DeleteAcls_result_response_error, librdkafka),
        Ptr{rd_kafka_error_t},
        (Ptr{rd_kafka_DeleteAcls_result_response_t},),
        result_response,
    )
end

function rd_kafka_DeleteAcls_result_response_matching_acls(
    result_response,
    matching_acls_cntp,
)
    ccall(
        (:rd_kafka_DeleteAcls_result_response_matching_acls, librdkafka),
        Ptr{Ptr{rd_kafka_AclBinding_t}},
        (Ptr{rd_kafka_DeleteAcls_result_response_t}, Ptr{Csize_t}),
        result_response,
        matching_acls_cntp,
    )
end

function rd_kafka_DeleteAcls(rk, del_acls, del_acls_cnt, options, rkqu)
    ccall(
        (:rd_kafka_DeleteAcls, librdkafka),
        Cvoid,
        (
            Ptr{rd_kafka_t},
            Ptr{Ptr{rd_kafka_AclBindingFilter_t}},
            Csize_t,
            Ptr{rd_kafka_AdminOptions_t},
            Ptr{rd_kafka_queue_t},
        ),
        rk,
        del_acls,
        del_acls_cnt,
        options,
        rkqu,
    )
end

function rd_kafka_oauthbearer_set_token(
    rk,
    token_value,
    md_lifetime_ms,
    md_principal_name,
    extensions,
    extension_size,
    errstr,
    errstr_size,
)
    ccall(
        (:rd_kafka_oauthbearer_set_token, librdkafka),
        rd_kafka_resp_err_t,
        (
            Ptr{rd_kafka_t},
            Ptr{Cchar},
            Int64,
            Ptr{Cchar},
            Ptr{Ptr{Cchar}},
            Csize_t,
            Ptr{Cchar},
            Csize_t,
        ),
        rk,
        token_value,
        md_lifetime_ms,
        md_principal_name,
        extensions,
        extension_size,
        errstr,
        errstr_size,
    )
end

function rd_kafka_oauthbearer_set_token_failure(rk, errstr)
    ccall(
        (:rd_kafka_oauthbearer_set_token_failure, librdkafka),
        rd_kafka_resp_err_t,
        (Ptr{rd_kafka_t}, Ptr{Cchar}),
        rk,
        errstr,
    )
end

function rd_kafka_init_transactions(rk, timeout_ms)
    ccall(
        (:rd_kafka_init_transactions, librdkafka),
        Ptr{rd_kafka_error_t},
        (Ptr{rd_kafka_t}, Cint),
        rk,
        timeout_ms,
    )
end

function rd_kafka_begin_transaction(rk)
    ccall(
        (:rd_kafka_begin_transaction, librdkafka),
        Ptr{rd_kafka_error_t},
        (Ptr{rd_kafka_t},),
        rk,
    )
end

function rd_kafka_send_offsets_to_transaction(rk, offsets, cgmetadata, timeout_ms)
    ccall(
        (:rd_kafka_send_offsets_to_transaction, librdkafka),
        Ptr{rd_kafka_error_t},
        (
            Ptr{rd_kafka_t},
            Ptr{rd_kafka_topic_partition_list_t},
            Ptr{rd_kafka_consumer_group_metadata_t},
            Cint,
        ),
        rk,
        offsets,
        cgmetadata,
        timeout_ms,
    )
end

function rd_kafka_commit_transaction(rk, timeout_ms)
    ccall(
        (:rd_kafka_commit_transaction, librdkafka),
        Ptr{rd_kafka_error_t},
        (Ptr{rd_kafka_t}, Cint),
        rk,
        timeout_ms,
    )
end

function rd_kafka_abort_transaction(rk, timeout_ms)
    ccall(
        (:rd_kafka_abort_transaction, librdkafka),
        Ptr{rd_kafka_error_t},
        (Ptr{rd_kafka_t}, Cint),
        rk,
        timeout_ms,
    )
end

mutable struct rd_kafka_mock_cluster_s end

const rd_kafka_mock_cluster_t = rd_kafka_mock_cluster_s

function rd_kafka_mock_cluster_destroy(mcluster)
    ccall(
        (:rd_kafka_mock_cluster_destroy, librdkafka),
        Cint,
        (Ptr{rd_kafka_mock_cluster_t},),
        mcluster,
    )
end

function rd_kafka_mock_cluster_bootstraps(mcluster)
    ccall(
        (:rd_kafka_mock_cluster_bootstraps, librdkafka),
        Ptr{Cint},
        (Ptr{rd_kafka_mock_cluster_t},),
        mcluster,
    )
end

function rd_kafka_mock_clear_request_errors(mcluster, ApiKey)
    ccall(
        (:rd_kafka_mock_clear_request_errors, librdkafka),
        Cint,
        (Ptr{rd_kafka_mock_cluster_t}, Cint),
        mcluster,
        ApiKey,
    )
end

function rd_kafka_mock_push_request_errors_array(mcluster, ApiKey, cnt, errors)
    ccall(
        (:rd_kafka_mock_push_request_errors_array, librdkafka),
        Cint,
        (Ptr{rd_kafka_mock_cluster_t}, Cint, Cint, Ptr{Cint}),
        mcluster,
        ApiKey,
        cnt,
        errors,
    )
end

function rd_kafka_mock_topic_set_error(mcluster, topic, err)
    ccall(
        (:rd_kafka_mock_topic_set_error, librdkafka),
        Cint,
        (Ptr{rd_kafka_mock_cluster_t}, Ptr{Cchar}, Cint),
        mcluster,
        topic,
        err,
    )
end

function rd_kafka_mock_start_request_tracking(mcluster)
    ccall(
        (:rd_kafka_mock_start_request_tracking, librdkafka),
        Cint,
        (Ptr{rd_kafka_mock_cluster_t},),
        mcluster,
    )
end

function rd_kafka_mock_stop_request_tracking(mcluster)
    ccall(
        (:rd_kafka_mock_stop_request_tracking, librdkafka),
        Cint,
        (Ptr{rd_kafka_mock_cluster_t},),
        mcluster,
    )
end

mutable struct rd_kafka_mock_request_s end

const rd_kafka_mock_request_t = rd_kafka_mock_request_s

function rd_kafka_mock_request_destroy(mreq)
    ccall(
        (:rd_kafka_mock_request_destroy, librdkafka),
        Cint,
        (Ptr{rd_kafka_mock_request_t},),
        mreq,
    )
end

function rd_kafka_mock_clear_requests(mcluster)
    ccall(
        (:rd_kafka_mock_clear_requests, librdkafka),
        Cint,
        (Ptr{rd_kafka_mock_cluster_t},),
        mcluster,
    )
end

struct var"##Ctag#233"
    ptr::Ptr{Cvoid}
    size::Csize_t
end
function Base.getproperty(x::Ptr{var"##Ctag#233"}, f::Symbol)
    f === :ptr && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :size && return Ptr{Csize_t}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#233", f::Symbol)
    r = Ref{var"##Ctag#233"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#233"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#233"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct var"##Ctag#234"
    name::Ptr{Cchar}
    val::Ptr{Cvoid}
    size::Cssize_t
end
function Base.getproperty(x::Ptr{var"##Ctag#234"}, f::Symbol)
    f === :name && return Ptr{Ptr{Cchar}}(x + 0)
    f === :val && return Ptr{Ptr{Cvoid}}(x + 8)
    f === :size && return Ptr{Cssize_t}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#234", f::Symbol)
    r = Ref{var"##Ctag#234"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#234"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#234"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


# Skipping MacroDefinition: RD_UNUSED __attribute__ ( ( unused ) )

# Skipping MacroDefinition: RD_INLINE inline

# Skipping MacroDefinition: RD_DEPRECATED __attribute__ ( ( deprecated ) )

const LIBRDKAFKA_TYPECHECKS = 1

const RD_KAFKA_VERSION = 0x020300ff

const RD_KAFKA_RESP_ERR_NOT_LEADER_OR_FOLLOWER = RD_KAFKA_RESP_ERR_NOT_LEADER_FOR_PARTITION

const RD_KAFKA_RESP_ERR_GROUP_LOAD_IN_PROGRESS =
    RD_KAFKA_RESP_ERR_COORDINATOR_LOAD_IN_PROGRESS

const RD_KAFKA_RESP_ERR_GROUP_COORDINATOR_NOT_AVAILABLE =
    RD_KAFKA_RESP_ERR_COORDINATOR_NOT_AVAILABLE

const RD_KAFKA_RESP_ERR_NOT_COORDINATOR_FOR_GROUP = RD_KAFKA_RESP_ERR_NOT_COORDINATOR

const RD_KAFKA_V_END = RD_KAFKA_VTYPE_END

const RD_KAFKA_DESTROY_F_NO_CONSUMER_CLOSE = 0x08

const RD_KAFKA_OFFSET_BEGINNING = -2

const RD_KAFKA_OFFSET_END = -1

const RD_KAFKA_OFFSET_STORED = -1000

const RD_KAFKA_OFFSET_INVALID = -1001

const RD_KAFKA_OFFSET_TAIL_BASE = -2000

const RD_KAFKA_MSG_F_FREE = 0x01

const RD_KAFKA_MSG_F_COPY = 0x02

const RD_KAFKA_MSG_F_BLOCK = 0x04

const RD_KAFKA_MSG_F_PARTITION = 0x08

const RD_KAFKA_PURGE_F_QUEUE = 0x01

const RD_KAFKA_PURGE_F_INFLIGHT = 0x02

const RD_KAFKA_PURGE_F_NON_BLOCKING = 0x04

const RD_KAFKA_EVENT_NONE = 0x00

const RD_KAFKA_EVENT_DR = 0x01

const RD_KAFKA_EVENT_FETCH = 0x02

const RD_KAFKA_EVENT_LOG = 0x04

const RD_KAFKA_EVENT_ERROR = 0x08

const RD_KAFKA_EVENT_REBALANCE = 0x10

const RD_KAFKA_EVENT_OFFSET_COMMIT = 0x20

const RD_KAFKA_EVENT_STATS = 0x40

const RD_KAFKA_EVENT_CREATETOPICS_RESULT = 100

const RD_KAFKA_EVENT_DELETETOPICS_RESULT = 101

const RD_KAFKA_EVENT_CREATEPARTITIONS_RESULT = 102

const RD_KAFKA_EVENT_ALTERCONFIGS_RESULT = 103

const RD_KAFKA_EVENT_DESCRIBECONFIGS_RESULT = 104

const RD_KAFKA_EVENT_DELETERECORDS_RESULT = 105

const RD_KAFKA_EVENT_DELETEGROUPS_RESULT = 106

const RD_KAFKA_EVENT_DELETECONSUMERGROUPOFFSETS_RESULT = 107

const RD_KAFKA_EVENT_OAUTHBEARER_TOKEN_REFRESH = 0x0100

const RD_KAFKA_EVENT_BACKGROUND = 0x0200

const RD_KAFKA_EVENT_CREATEACLS_RESULT = 0x0400

const RD_KAFKA_EVENT_DESCRIBEACLS_RESULT = 0x0800

const RD_KAFKA_EVENT_DELETEACLS_RESULT = 0x1000

const RD_KAFKA_EVENT_LISTCONSUMERGROUPS_RESULT = 0x2000

const RD_KAFKA_EVENT_DESCRIBECONSUMERGROUPS_RESULT = 0x4000

const RD_KAFKA_EVENT_LISTCONSUMERGROUPOFFSETS_RESULT = 0x8000

const RD_KAFKA_EVENT_ALTERCONSUMERGROUPOFFSETS_RESULT = 0x00010000

const RD_KAFKA_EVENT_INCREMENTALALTERCONFIGS_RESULT = 0x00020000

const RD_KAFKA_EVENT_DESCRIBEUSERSCRAMCREDENTIALS_RESULT = 0x00040000

const RD_KAFKA_EVENT_ALTERUSERSCRAMCREDENTIALS_RESULT = 0x00080000

const RD_KAFKA_EVENT_DESCRIBETOPICS_RESULT = 0x00100000

const RD_KAFKA_EVENT_DESCRIBECLUSTER_RESULT = 0x00200000

const RD_KAFKA_EVENT_LISTOFFSETS_RESULT = 0x00400000

# exports
const PREFIXES = ["rd_kafka", "RD_KAFKA"]
for name in names(@__MODULE__; all = true), prefix in PREFIXES
    if startswith(string(name), prefix)
        @eval export $name
    end
end

end # module
