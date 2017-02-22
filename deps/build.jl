# some checks:
# assert we use condas python
ENV["PYTHON"] = ""
Pkg.build("PyCall") # rebuild to enforce the above
using PyCall, Conda

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

if is_apple() && Pkg.installed("QuartzImageIO") != nothing
    warn("""Please remove QuartzImageIO (Pkg.rm("QuartzImageIO")), or you might run into flipped images""")
end


# install Pymanopt
try
    @pyimport pip
catch e
    try
        Conda.add("pip")
        @pyimport pip
    catch e
        # TODO give better instructions... Hopefully no one ever gets here!
        warning("Please install pip")
    end
end
try
    using PyCall, Conda
    Conda.add_channel("conda-forge")
    Conda.add("numpy")
    Conda.add("autograd")
    @pyimport pip
    pip.main(["install", "--upgrade", "pip"])
    pip.main(["install", "pymanopt"])
catch e
    println("Automatically installing pymanopt failed. Please install the pymanopt and autograd package manually for your python")
    println("This is the error from the automatic install: $e")
end
