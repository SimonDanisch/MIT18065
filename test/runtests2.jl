# Any script you run should include `using MIT18065` at the top
# this will ensure, that all functionality is available.
using MIT18065

# include the file with the function
include("testfunction.jl")

# have the size as a variable
n = 3 # try different values of n
# create a matrix
A = rand(n, n)

# run function included from test.jl
testfunction(A)
