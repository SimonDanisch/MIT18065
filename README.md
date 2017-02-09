# MIT18065



## Installation.
* Summary:  we will download Julia, start it in a terminal, download a ton of software, and then open up a Jupyter Notebook


## Install vanilla Julia
1. install Julia 0.5 (command line version) as described in http://julialang.org/downloads/
  * Pick one entry from the table (.exe for windows, .dmg for mac, binaries for linux) and download
  * Install the program
2. start up Julia (your first Julia will be in a command/terminal window)
  * (There should be an icon or a launch button with the three colored julia logo <image src=https://avatars0.githubusercontent.com/u/743164?v=3&s=30>)
3. Type `1+1` just for fun.  You know what we're hoping to see.

## Install class packages for MIT 18.065

2. If you're on linux, you need to install these packages first `sudo apt-get install cmake xorg-dev libglu1-mesa-dev hdf5-tools`
2. Type Pkg.init()
  * Ignore pink ugly info or warning messages. They are not serious. 
  * We found that on a mac it ran right away, but on windows it took a couple of minutes. Good time to get that coffee or Diet Coke.
2. run Pkg.clone("https://github.com/SimonDanisch/MIT18065.git")
  * This took about 30 minutes on windows, and about 7 on my mac
  * For windows users, good time to get dinner. (Your time may vary.)
2. run Pkg.test("MIT18065")

it will open a web browser where you can select getting started.ipynb which will lead you to this:
[notebook](https://github.com/SimonDanisch/MIT18065/blob/master/docs/getting%20started.ipynb)


1. execute every step in the notebook (shift + enter  one by one, or cell + Run All)
