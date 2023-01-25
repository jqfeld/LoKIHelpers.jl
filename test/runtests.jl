using LoKIHelpers
using Test, SafeTestsets

@testset "LoKIHelpers.jl" begin
    # Write your tests here.
    @safetestset "Parsing rate lookup table" begin include("test_lookup_rate.jl") end
end
