struct UnsafeVector{T} <: DenseVector{T}
    ptr::Ptr{T}
    len::Int
end

UnsafeVector(ptr::Ptr, len::Integer) = UnsafeVector(ptr, convert(Int, len))

Base.pointer(v::UnsafeVector) = v.ptr

Base.size(v::UnsafeVector) = (v.len,)

Base.@propagate_inbounds function Base.getindex(v::UnsafeVector{T}, i) where {T}
    @boundscheck checkbounds(v, i)
    unsafe_load(pointer(v), i)
end

Base.@propagate_inbounds function Base.setindex!(v::UnsafeVector{T}, x, i) where {T}
    @boundscheck checkbounds(v, i)
    unsafe_store!(pointer(v), x, i)
end
