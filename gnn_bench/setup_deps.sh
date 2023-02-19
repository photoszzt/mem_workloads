#!/bin/bash

mamba create -n benchmark_gnn python=3.7
mamba install -n benchmark_gnn pandas
[ -d "./benchmarking-gnns" ] || git clone https://github.com/graphdeeplearning/benchmarking-gnns.git
mamba env update --name=benchmark_gnn --file=./environment_cpu.yml
