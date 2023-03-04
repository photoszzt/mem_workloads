#!/bin/bash

source $HOME/mambaforge/bin/activate
mamba create -y -n dgl python=3.9
mamba install -y -n dgl pytorch torchvision torchaudio cpuonly -c pytorch
mamba install -y -n dgl -c dglteam dgl
mamba install -y -n dgl ogb
mamba install -y -n dgl -c conda-forge jemalloc
$HOME/mambaforge/envs/dgl/bin/python3 -m pip install --upgrade py-libnuma

{ [ -d jemalloc ] && cd jemalloc && git checkout tags/5.3.0; } || { git clone https://github.com/jemalloc/jemalloc.git && cd jemalloc && git checkout tags/5.3.0; }
cd jemalloc
./configure --enable-prof --enable-stats
make -j$(nproc)
sudo make install
