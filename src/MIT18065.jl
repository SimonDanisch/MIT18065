module MIT18065

using Images, Colors, Interpolations
using Polynomials
using PyCall
using Interpolations
using Convex
using JSON
using IterativeSolvers


using FileIO: @format_str, File, filename, add_format, stream

# reexport plotting
import RecipesBase
using Plots: plot, scatter, plot!, scatter!, heatmap, heatmap!, @recipe, plotlyjs
export plot, scatter, plot!, scatter!, heatmap, heatmap!

# reexport Colors
export RGBA, RGB

# reexport Interpolations
export interpolate, BSpline, Linear, OnGrid


function tsvd(A, k = min(min(size(A)...), 6))
    m, n = size(A)
    minmn = min(m, n)

    if k == minmn               # All values               : QR algorithm (density if necessary)
        return svd(full(A))
    elseif k > 0
        if k > sqrt(minmn) + 1  # More than sqrt(n) values : QR algorithm (density if necessary)
            U, s, V = svd(full(A))
            return U[:,1:k], s[1:k], V[:,1:k]
        else                    # less than sqrt(n) values : Lanczos algorithm
            out = svds(A, nsv = k)
            return out[1][:U], out[1][:S], VERSION < v"0.6.0-dev.2026" ? out[1][:V]' : out[1][:V]
        end
    else
        return Array{eltype(A)}(m, 0), Array{eltype(A)}(0), Array{eltype(A)}(n, 0)
    end
end

export tsvd

# define some plotting recipes to make it easier for the students
# to just use simple plotting commands. Function name doesn't matter
@recipe function f{C <: Complex}(c::Vector{C})
    real.(c), imag.(c)
end

function spy(A::Matrix;
        xaxis = 1:size(A, 2), yaxis = 1:size(A, 1),
        kw_args...
    )
    heatmap(flipdim(A, 1), xaxis = xaxis, yaxis = yaxis; kw_args...)
end

export spy

# register mat format with FileIO
load(f::File{format"MAT"}) = matread(filename(f))

# for now, we use serialize
load(f::File{format"JULIA"}) = open(f) do io
    deserialize(stream(io))
end

save(f::File{format"JULIA"}, x) = open(f, "w") do io
    serialize(stream(io), x)
end


"""
Get the demo path
"""
demopath(files...) = normpath(joinpath(dirname(@__FILE__), "..", "demos", files...))
export demopath

function __init__()
    # make sure Plotly is selected as plotting backend
    plotlyjs()
    # register mat format with FileIO
    # TODO move into FileIO registry
    add_format(format"MAT", "MATLAB", ".mat", [:MIT18065])
    add_format(format"JULIA", (), ".jls", [:MIT18065])
    eval(Main, :(using FileIO))
end

end # module
