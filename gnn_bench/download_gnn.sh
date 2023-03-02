#!/bin/bash

[ -d ./benchmarking-gnns ] || git clone https://github.com/graphdeeplearning/benchmarking-gnns.git
cd benchmarking-gnns/data
bash script_download_all_datasets.sh
