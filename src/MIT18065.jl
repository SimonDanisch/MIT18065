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
