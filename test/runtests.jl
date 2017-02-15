using IJulia

# some checks:

function ssuccess(command)
    try
        success(command)
    catch
        return false
    end
end
function dpkgquery(package)
    try
        contains(readstring(`dpkg-query -W -f='${Status}' $package`), "ok")
    catch
        return false
    end
end

if is_linux()
    needsrebuild = false
    if !ssuccess(`cmake --version`)
        info("Please execute sudo apt-get install cmake in your terminal")
        needsrebuild = true
    end
    if !dpkgquery("xorg-dev")
        info("Please execute `sudo apt-get install xorg-dev` in your terminal")
        needsrebuild = true
    end
    if !dpkgquery("libglu1-mesa-dev")
        info("Please execute `sudo apt-get install libglu1-mesa-dev` in your terminal")
        needsrebuild = true
    end
    if needsrebuild
        info("Please run Pkg.build(\"MIT18065\") again after installing the above packages")
    end
end

if is_apple() && isinstalled("QuartzImageIO") != nothing
    warning("""Please remove QuartzImageIO (Pkg.rm("QuartzImageIO")), or you might run into flipped images""")
end

function is_ci()
    get(ENV, "TRAVIS", "") == "true" ||
    get(ENV, "APPVEYOR", "") == "true" ||
    get(ENV, "CI", "") == "true"
end

# only start a notebook if not testing on CI
if !is_ci()
    notebook(detached = true, dir = joinpath(dirname(@__FILE__), "..", "docs"))
end
