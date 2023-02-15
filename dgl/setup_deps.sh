#!/bin/bash

mamba create -n dgl python=3.9
mamba install -y -n dgl pytorch torchvision torchaudio cpuonly -c pytorch
mamba install -y -n dgl -c dglteam dgl
