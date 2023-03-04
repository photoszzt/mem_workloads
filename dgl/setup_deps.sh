#!/bin/bash

source $HOME/mambaforge/bin/activate
mamba create -y -n dgl python=3.9
mamba install -y -n dgl pytorch torchvision torchaudio cpuonly -c pytorch
mamba install -y -n dgl -c dglteam dgl
mamba install -y -n dgl ogb
mamba install -y -n dgl -c conda-forge jemalloc
$HOME/mambaforge/envs/dgl/bin/python3 -m pip install --upgrade py-libnuma

[ -d $HOME/jemalloc-5.3.0 ] || { wget https://github.com/jemalloc/jemalloc/releases/download/5.3.0/jemalloc-5.3.0.tar.bz2 -O $HOME/jemalloc-5.3.0.tar.bz2 && cd $HOME && tar -xvf $HOME/jemalloc-5.3.0.tar.bz2 ; }
cd $HOME/jemalloc-5.3.0
./configure --enable-prof --enable-stats
make -j$(nproc)
sudo make install
