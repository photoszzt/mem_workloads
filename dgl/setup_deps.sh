#!/bin/bash

source $HOME/mambaforge/bin/activate
mamba create -y -n dgl python=3.9
mamba install -y -n dgl pytorch torchvision torchaudio cpuonly -c pytorch
mamba install -y -n dgl -c dglteam dgl
mamba install -y -n dgl ogb
$HOME/mambaforge/envs/dgl/bin/python3 -m pip install --upgrade py-libnuma
