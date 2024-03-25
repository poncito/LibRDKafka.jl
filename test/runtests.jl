using Test

using LibRDKafka: UnsafeVector

@testset "UnsafeVector" begin
    v = collect(1:10)
    GC.@preserve v begin
        ptr = pointer(v)
        uv = UnsafeVector(ptr, 10)

        @test length(uv) == 10
        @test pointer(uv) == ptr

        # Test element access
        for i in 1:10
            @test uv[i] == i
        end

        # Test element access
        for i in 1:10
            uv[i] = 2 * i
            @test uv[i] == 2 * i

        end

        # Bounds checking
        @test_throws BoundsError uv[0]
        @test_throws BoundsError uv[11]
    end
end
