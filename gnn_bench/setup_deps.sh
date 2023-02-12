#!/bin/bash

mamba create -n benchmark_gnn python=3.7.4
mamba activate benchmark_gnn
mamba install pandas
mamba env update -f ./benchmarking-gnns
