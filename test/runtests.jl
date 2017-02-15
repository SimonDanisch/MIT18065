using IJulia

function is_ci()
    get(ENV, "TRAVIS", "") == "true" ||
    get(ENV, "APPVEYOR", "") == "true" ||
    get(ENV, "CI", "") == "true"
end

# only start a notebook if not testing on CI
if !is_ci()
    notebook(detached = true, dir = joinpath(dirname(@__FILE__), "..", "docs"))
end
