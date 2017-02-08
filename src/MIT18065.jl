module MIT18065

using Plots, MAT, Images, Colors, Interpolations
using WAV
using Polynomials
using PyCall
using Interpolations
using Convex
using JSON
using IterativeSolvers


import FileIO
import FileIO: @format_str, File, filename

# reexport plotting
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
# to just use simple plotting commands
@recipe function f{C <: Complex}(c::Vector{C})
    real.(c), imag.(c)
end

# register mat format with FileIO
load(f::File{format"MAT"}) = matread(filename(f))

"""
Get the demo path
"""
demopath(files...) = normpath(joinpath(dirname(@__FILE__), "..", "demos", files...))
export demopath

function __init__()
    # make sure Plotly is selected as plotting backend
    plotly()
    # register mat format with FileIO
    # TODO move into FileIO registry
    FileIO.add_format(format"MAT", "MATLAB", ".mat", [:MIT18065])
    eval(Main, :(using FileIO))
end

end # module
