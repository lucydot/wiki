Ooh a sparking new OS. Here are the steps I used to setup on Big Sur, adapted from [Aron's blog]( https://thelostelectron.wordpress.com/2020/02/09/macos-catalina-for-computational-materials-science-in-2020/) for Catalina.

### Associated files

- `Makefile.include` for vasp is [here]().
- minimal `.zshrc` is [here]().

### My $HOME

In it's cleanest state my computer looks something like this:

`~/bin/` (symlinks to binary exectuables), `~/Dropbox/` (for documents I don't need version controlled), `~/Repos/` (my Git repos for research projects and websites), `~/Code` (Downloaded code and Git repos for code bases I'm working on), `~/Code/Scripts` (a Git repo with various scripts that don't count as code in their own right), `~/Zotero` (zotero data), `~/miniconda3`, `~/.ssh` (ssh config files and keys), `~/.zshrc`(zsh profile settings), `~/Data` (raw DFT data, scp'd from the rdf)

### Tidy up and Backup

1. Backup with TimeMachine 
2. Clean up Desktop and Downloads
3. Transfer notes from the Firefox TabNotes extension to their long term home
4. Move .ssh, .bash_profile, ~/Zotero, and any other settings or data files that are not backed up to a Dropbox folder
5. Push all local Git Repos to their remote repositories
6. Make sure Dropbox and Firefox are sync'd 
7. Turn off two-factor authentication (e.g. on Archer Safe)

Note:
- I don't need to worry about syncing pycharm project separately as each corresponds to GitHub repo.

### Delete the drive and clean install

1. Shut down computer, do Command+R whilst plugged into internet. 
2. Go to disk utility and delete the drive.
3. Install Big Sur

### Install new programmes, tools, data, code...

#### Setup up terminal and zsh

Open Terminal and type `make` to install the command line tools module (basic UNIX commands and a gcc compiler).

The command lines tools are installed in a non-standard location so you need to i) add the C/Fortran library paths to the relevant environment variable in `.zshrc`: 

```
export LIBRARY_PATH=$LIBRARY_PATH:/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib
```

and ii) link the C headers:

```
sudo mkdir /usr/local/include
sudo ln -s /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/* /usr/local/include/
```

I tried `export CPATH==...` as an alternative to the above but this didn't work - more `PATH`s are probably need to be set using this method.

Hold up! Whats this `.zschsrzhcc` (or whatever it is) file about? There's a nice set of blogposts about it [here](https://scriptingosx.com/2019/06/moving-to-zsh/) - it's a startup script similar to `.bashrc`. We're not forced to use zsh instead of bash on Big Sur or Catalina, but it looks like the wind might be blowing that way. 

#### Get Compilers

Install open source compilers: gcc and gfortran [here](http://hpc.sourceforge.net) (on the website it says that Xcode is also needed - but we don't need to do this as the same tools were installed in the previous step).

Check install with: `gcc --version`, `fortran --version`

Install Intel MKL and C++ compilers via intel oneAPI Base Toolkit [here](https://software.intel.com/content/www/us/en/develop/tools/oneapi/base-toolkit.html) and Intel Fortran with the HPC add-on toolkit [here](https://software.intel.com/content/www/us/en/develop/tools/oneapi/hpc-toolkit.html).

Source the environment variables in your `.zshrc`, as outlined in the documentation [here](https://software.intel.com/content/www/us/en/develop/documentation/get-started-with-intel-oneapi-base-hpc-macos/top/before-you-begin.html):
```
source /opt/intel/oneapi/setvars.sh
```

Check install with `ifort --version`, `icc --version`, `icc --version`

#### MPI for parallelism

Downloaded the latest source code of [openmpi](https://www.open-mpi.org).

Configure for compilation with the intel compilers:

```
./configure -prefix=/usr/local/openmpi-4.1.0 CC=icc CXX=icpc FC=ifort F77=ifort FCFLAGS='-O1' CFLAGS='-O1' CXXFLAGS='-O1' 
```

Note that I have *not* used the flag `--disable-dlopen`. Now edit the `libtool` file lines 11837 to 11841:

```
# Additional compiler flags for building library objects.
pic_flag=" -fno-common -fPIC"

# How to pass a linker flag through the compiler.
wl="-Wl,"
```
Without this edit there is a problem with mpifort (see [here](https://ntq1982.github.io/files/20200621.html), [here](https://community.intel.com/t5/Intel-Fortran-Compiler/Undefined-symbols-for-architecture-x86-64-quot-ompi-buffer/m-p/1233733/highlight/true#M153022) and [here](https://github.com/open-mpi/ompi/issues/7615) for details).

Finally,

```
sudo make
sudo make install
```

`make` takes a suriprising amount of time...go and make a lasagne or something...

Add the paths to your `.zshrc`:
```
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/usr/local/openmpi-x.x.x/lib/
export PATH=./:/usr/local/openmpi-x.x.x/bin:$PATH
export OMP_NUM_THREADS=1
```

Check install with `mpif90 --version`

Note: 
- Don't do what I did and think you'll be ok installing both gnu and intel versions of openmpi alongside each other - they do not play nicely.
- `make` needs to come before `make install`
- if you mess up then `make uninstall` and delete the openmpi folder from `/usr/local/`

#### Install VASP

```
cp ./arch/makefile.include.linux_intel ./makefile.include
```

Three steps before make:
1) Modify to point to the correct compilers (icc, icpc, and mpifort)
2) Remove DscaLAPACK from the pre-compiler options
3) Set `SCALAPACK =  `
4) in `./src/lib/getshmem.c` add `#define SHM_NORESERVE 010000` to the end of the include statements.

Then:
```
make
```

Check with `mpirun -np 4 vasp_std`

#### Install Conda 

Download [Miniconda](https://docs.conda.io/en/latest/miniconda.html) - the default options will add code to your `.zshrc` so that a base Conda environment is activated each time you are in the terminal (if you don't do this you'll default to the intel python installed as part of oneAPI toolkit).

Consider using [conda auto activate](https://github.com/sotte/conda_auto_activate) if, like me, you keep forgetting to switch environments when moving between projects.

#### Install phonopy

``` 
conda create -n phonopy -c conda-forge python=3
conda activate phonopy
conda install -c conda-forge phonopy
```

Test with

```phonopy```

#### Install git

Git can be installed via Conda (I install it on my base Conda environment as it is general purpose):

```conda install -c anaconda git```

#### Install `.dmg`'s

Zotero (replace the ~/Zotero folder with the one you have saved), pycharm, simplenote, iTerm, MacDown, Zoom, Sublime, Omnigraffle, Firefox (with sci-hub and tabnotes extensions), Dropbox, Office365, Vesta, LaTeXit, MacTeX (includes LaTeXit and TexShop)

