#!/bin/bash

source $HOME/miniconda3/bin/activate
conda create -y -n dgl python=3.9
conda install -y -n dgl pytorch torchvision torchaudio cpuonly -c pytorch
conda install -y -n dgl -c dglteam dgl
conda install -y -n dgl -c conda-forge ogb
$HOME/miniconda3/envs/dgl/bin/python3 -m pip install --upgrade py-libnuma

# [ -d $HOME/jemalloc-5.3.0 ] || { wget https://github.com/jemalloc/jemalloc/releases/download/5.3.0/jemalloc-5.3.0.tar.bz2 -O $HOME/jemalloc-5.3.0.tar.bz2 && cd $HOME && tar -xvf $HOME/jemalloc-5.3.0.tar.bz2 ; }
# cd $HOME/jemalloc-5.3.0
# ./configure --enable-prof --enable-stats
# make -j$(nproc)
# sudo make install
