using VectorStretch
using Test

@testset "VectorStretch.jl" begin
    # Write your tests here.
  col = [1, 10, 50, 30, 10]

  @test interpolate(col, 1.5) == 5.5
  @test col[1.5] == 5.5

  @test interpolate(col, 1) == 1
  @test interpolate(col, 5) == 10
  @test interpolate(col, 3) == 50

  @test interpolate(col, 0) == 1
  @test interpolate(col, 50) == 10

  @test interpolate(col, 2.5) == 30.0

  stretched = vector_expand(col, 10)
  @test last(stretched) == last(col)
  @test first(stretched) == first(col)
  @test length(stretched) == 10

  stretched_again = vector_expand(col, 11)
  @test last(stretched_again) == last(col)
  @test first(stretched_again) == first(col)
  @test length(stretched_again) == 11
  @test stretched_again[6] == 50.0

  comp_1 = [2, 4, 6, 8, 10]
  comp_2 = [10, 12, 14, 16]

  println(similarity(comp_1, comp_2))
end
