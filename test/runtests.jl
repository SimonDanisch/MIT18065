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

notebook(detached = true, dir = joinpath(dirname(@__FILE__), "..", "docs"))
