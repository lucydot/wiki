# Command line tools C headers and C/Fortran libraries
export LIBRARY_PATH=$LIBRARY_PATH:/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib

# intel C/Fortran/MKL compiler variables
source /opt/intel/oneapi/setvars.sh

# MPI paths
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/usr/local/openmpi-4.1.0/lib
export PATH=./:/usr/local/openmpi-4.1.0/bin:$PATH
export OMP_NUM_THREADS=1

# useful aliasess
alias cpu='echo time $(uptime) && echo $(sysctl -n hw.ncpu) cores on $(hostname)'
alias ipn="ipython notebook"
alias sublime='open -a /Applications/Sublime\ Text.app/'
alias macdown='open -a /Applications/MacDown.app/'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/lucy/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/lucy/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/lucy/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/lucy/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

