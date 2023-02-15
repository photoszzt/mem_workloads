#!/bin/bash
#

wget https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh
bash Mambaforge-Linux-x86_64.sh -b
rm Mambaforge-Linux-x86_64.sh
source $HOME/mambaforge/bin/activate && mamba init
