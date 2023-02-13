#!/bin/bash

peak_files=$(curl -l ftp://massive.ucsd.edu/MSV000091183/peak/)
libs=$(curl -l ftp://massive.ucsd.edu/MSV000091183/library/)

source ./group_limit.sh

pids=()
j=0

bgxgrp="process_group_1"
mkdir -p ./MSV000091183/peak
mkdir -p ./MSV000091183/library

for i in ${peak_files[@]}; do
    bgxlimit 4 wget ftp://massive.ucsd.edu/MSV000091183/peak/$i -O MSV000091183/peak/$i
done

for i in ${libs[@]}; do
    bgxlimit 4 wget ftp://massive.ucsd.edu/MSV000091183/library/$i -O MSV000091183/library/$i
done

bgxupdate
while [[ ${bgxcount} -ne 0 ]] ; do
    oldcount=${bgxcount}
    while [[ ${oldcount} -eq ${bgxcount} ]] ; do
        sleep 1
        bgxupdate
    done
done

