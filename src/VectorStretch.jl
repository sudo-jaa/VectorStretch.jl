module VectorStretch
  export interpolate, similarity, vector_expand

  "Checks for a 0-index access or last-index access to a vector and returns early from a caller function"
  macro interpolate_return(t, i) 
      return esc(quote
          if ($t <= 0)
            return first($i)
          end
          if (length($i) < $t)
            return last($i)
          end
    end)
  end

  "Get the floor and ceil value of a floating point number"
  limits(t::AbstractFloat)::Tuple{Int32, Int32} = (floor(t), ceil(t))

  "Interpolate between discrete indices on a vector. Equivalent to regular index access"
  function interpolate(i::Vector{<:Number}, t::Integer)
    @interpolate_return(t, i)
    return i[t]
  end

  "Interpolate between discrete indicies on a vector."
  function interpolate(i::Vector{<:Number}, t::AbstractFloat)
    @interpolate_return(t, i)
    min, max = limits(t)
    α, β = (i[min], i[max])
    Δ = t - min
    return interpolate((α, β), Δ)
  end

  "Interpolate between discrete indicies on a vector using an easing function."
  interpolate(i::Vector{<:Number}, t::AbstractFloat, easing::Function) = interpolate(i, easing(t))

  "Interpolate between two values of a tuple."
  interpolate(range::Tuple{Number, Number}, t::AbstractFloat) = range[1] * (1 - t) + range[2] * t

  "Interpolate between two values of a tuple using an easing function."
  interpolate(range::Tuple{Number, Number}, t::AbstractFloat, easing::Function) = interpolate(range, easing(t))

  "Interpolate between two numbers."
  interpolate(a::Number, b::Number, t::AbstractFloat) = interpolate((a, b), t)

  "Interpolate between two numbers using an easing function."
  interpolate(a::Number, b::Number, t::AbstractFloat, easing::Function) = interpolate((a, b), easing(t))

  "Add method to getindex that allows you to access an array at arbitrary float indices"
  Base.getindex(collection::Vector{<:Number}, key::AbstractFloat) = interpolate(collection, key)

  "Expands a vector to a specific length, staying proportional in magnitude to the original vector."
  function vector_expand(i::Vector{<:Number}, n::Int)::Vector{AbstractFloat}
    len = length(i)
    if (len == n)
      return i
    end
    if (i == 0)
      return []
    end

    return [interpolate(i, x) for x in LinRange(1, len, n)]
  end

  "Determine the cosine similarity of two vectors of arbitrary (and different) lengths"
  function similarity(a::Vector{<:Number}, b::Vector{<:Number})
    len_a, len_b = (length(a), length(b))
    if (len_a == len_b)
      return cosinesim(a, b)
    end
    
    if (len_a > len_b)
      return cosinesim(a, vector_expand(b, len_a))
    else
      return cosinesim(b, vector_expand(a, len_b))
    end
  end

  "Determine the cosine similarity of two vectors"
  function cosinesim(a::Vector{<:Number}, b::Vector{<:Number})
    dot = 0
    mA = 0
    mB = 0
    for i in 1:length(a)
      dot += a[i] * b[i]
      mA += a[i] * a[i]
      mB += b[i] * b[i]
    end
    mA = sqrt(mA)
    mB = sqrt(mB)
    return (dot) / ((mA) * mB)
  end
end # module
