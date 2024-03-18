struct UnsafeString <: AbstractString
    ptr::Ptr{UInt8}
    len::Int64 # in bytes
end

function UnsafeString(ptr::Ptr)
    @assert ptr != C_NULL
    len = @ccall strlen(ptr::Cstring)::Csize_t
    UnsafeString(ptr, len)
end

Base.pointer(str::UnsafeString) = str.ptr
function Base.pointer(str::UnsafeString, i::Integer)
    str.ptr + (i - 1)
end

function Base.unsafe_copyto!(str::UnsafeString, string::Union{UnsafeString,String})
    @assert str.len >= sizeof(string)
    unsafe_copyto!(pointer(str), pointer(string), sizeof(string))
end

function Base.String(str::UnsafeString)
    unsafe_string(pointer(str), str.len)
end

# string interface - this is largely copied from Base

Base.sizeof(s::UnsafeString) = s.len

Base.ncodeunits(s::UnsafeString) = sizeof(s)
Base.codeunit(::UnsafeString) = UInt8

@inline function Base.codeunit(s::UnsafeString, i::Integer)
    @boundscheck checkbounds(s, i)
    GC.@preserve s unsafe_load(pointer(s, i))
end

## comparison ##

function Base.cmp(a::UnsafeString, b::UnsafeString)
    al, bl = sizeof(a), sizeof(b)
    c = ccall(:memcmp, Int32, (Ptr{UInt8}, Ptr{UInt8}, UInt), a, b, min(al, bl))
    return c < 0 ? -1 : c > 0 ? +1 : cmp(al, bl)
end

function Base.:(==)(a::UnsafeString, b::UnsafeString)
    al = sizeof(a)
    al == sizeof(b) && 0 == ccall(:memcmp, Int32, (Ptr{UInt8}, Ptr{UInt8}, UInt), a, b, al)
end

## thisind, nextind ##

Base.thisind(s::UnsafeString, i::Int) = Base._thisind_str(s, i)

Base.nextind(s::UnsafeString, i::Int) = Base._nextind_str(s, i)

## checking UTF-8 & ACSII validity ##

byte_string_classify(s::UnsafeString) =
    ccall(:u8_isvalid, Int32, (Ptr{UInt8}, Int), s, sizeof(s))
# 0: neither valid ASCII nor UTF-8
# 1: valid ASCII
# 2: valid UTF-8

## required core functionality ##

Base.@propagate_inbounds function Base.iterate(s::UnsafeString, i::Int = firstindex(s))
    i > ncodeunits(s) && return nothing
    b = codeunit(s, i)
    u = UInt32(b) << 24
    Base.between(b, 0x80, 0xf7) || return reinterpret(Char, u), i + 1
    return next_continued(s, i, u)
end

function next_continued(s::UnsafeString, i::Int, u::UInt32)
    u < 0xc0000000 && (i += 1; @goto ret)
    n = ncodeunits(s)
    # first continuation byte
    (i += 1) > n && @goto ret
    @inbounds b = codeunit(s, i)
    b & 0xc0 == 0x80 || @goto ret
    u |= UInt32(b) << 16
    # second continuation byte
    ((i += 1) > n) | (u < 0xe0000000) && @goto ret
    @inbounds b = codeunit(s, i)
    b & 0xc0 == 0x80 || @goto ret
    u |= UInt32(b) << 8
    # third continuation byte
    ((i += 1) > n) | (u < 0xf0000000) && @goto ret
    @inbounds b = codeunit(s, i)
    b & 0xc0 == 0x80 || @goto ret
    u |= UInt32(b)
    i += 1
    @label ret
    return reinterpret(Char, u), i
end

Base.@propagate_inbounds function Base.getindex(s::UnsafeString, i::Int)
    b = codeunit(s, i)
    u = UInt32(b) << 24
    Base.between(b, 0x80, 0xf7) || return reinterpret(Char, u)
    return getindex_continued(s, i, u)
end

function getindex_continued(s::UnsafeString, i::Int, u::UInt32)
    if u < 0xc0000000
        # called from `getindex` which checks bounds
        @inbounds isvalid(s, i) && @goto ret
        Base.string_index_err(s, i)
    end
    n = ncodeunits(s)

    (i += 1) > n && @goto ret
    @inbounds b = codeunit(s, i) # cont byte 1
    b & 0xc0 == 0x80 || @goto ret
    u |= UInt32(b) << 16

    ((i += 1) > n) | (u < 0xe0000000) && @goto ret
    @inbounds b = codeunit(s, i) # cont byte 2
    b & 0xc0 == 0x80 || @goto ret
    u |= UInt32(b) << 8

    ((i += 1) > n) | (u < 0xf0000000) && @goto ret
    @inbounds b = codeunit(s, i) # cont byte 3
    b & 0xc0 == 0x80 || @goto ret
    u |= UInt32(b)
    @label ret
    return reinterpret(Char, u)
end

Base.getindex(s::UnsafeString, r::UnitRange{<:Integer}) = s[Int(first(r)):Int(last(r))]

function Base.getindex(s::UnsafeString, r::UnitRange{Int})
    isempty(r) && return ""
    i, j = first(r), last(r)
    @boundscheck begin
        checkbounds(s, r)
        @inbounds isvalid(s, i) || Base.string_index_err(s, i)
        @inbounds isvalid(s, j) || Base.string_index_err(s, j)
    end
    j = nextind(s, j) - 1
    # n = j - i + 1
    # ss = _string_n(n)
    # p = pointer(ss)
    # for k = 1:n
    #     unsafe_store!(p, codeunit(s, i + k - 1), k)
    # end
    # return ss
    UnsafeString(s.ptr + (i - 1), j - i + 1)
end

function Base.length(s::UnsafeString, i::Int, j::Int)
    @boundscheck begin
        0 < i ≤ ncodeunits(s) + 1 || throw(BoundsError(s, i))
        0 ≤ j < ncodeunits(s) + 1 || throw(BoundsError(s, j))
    end
    j < i && return 0
    @inbounds i, k = thisind(s, i), i
    c = j - i + (i == k)
    _length(s, i, j, c)
end

Base.length(s::UnsafeString) = _length(s, 1, ncodeunits(s), ncodeunits(s))

@inline function _length(s::UnsafeString, i::Int, n::Int, c::Int)
    i < n || return c
    @inbounds b = codeunit(s, i)
    @inbounds while true
        while true
            (i += 1) ≤ n || return c
            0xc0 ≤ b ≤ 0xf7 && break
            b = codeunit(s, i)
        end
        l = b
        b = codeunit(s, i) # cont byte 1
        c -= (x = b & 0xc0 == 0x80)
        x & (l ≥ 0xe0) || continue

        (i += 1) ≤ n || return c
        b = codeunit(s, i) # cont byte 2
        c -= (x = b & 0xc0 == 0x80)
        x & (l ≥ 0xf0) || continue

        (i += 1) ≤ n || return c
        b = codeunit(s, i) # cont byte 3
        c -= (b & 0xc0 == 0x80)
    end
end

## overload methods for efficiency ##

Base.isvalid(s::UnsafeString, i::Int) = checkbounds(Bool, s, i) && thisind(s, i) == i
