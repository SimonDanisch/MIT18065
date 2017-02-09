using IJulia

# some checks:

if is_linux()
    needsrebuild = false
    if !success(`cmake --version`)
        info("Please execute sudo apt-get install cmake in your terminal")
        needsrebuild = true
    end
    if !contains(readstring(`dpkg-query -W -f='${Status}' xorg-dev`), "ok")
        info("Please execute `sudo apt-get install xorg-dev` in your terminal")
        needsrebuild = true
    end
    if !contains(readstring(`dpkg-query -W -f='${Status}' libglu1-mesa-dev`), "ok")
        info("Please execute `sudo apt-get install libglu1-mesa-dev` in your terminal")
        needsrebuild = true
    end
    if needsrebuild
        info("Please run Pkg.build(\"MIT18065\")")
    end
end

notebook(detached = true, dir = joinpath(dirname(@__FILE__), "..", "docs"))
