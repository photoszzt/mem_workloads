#!/bin/bash

python3 -m ann_solo.ann_solo -c ./configs/iprg2012.ini \
    ./data/MSV000091183/library/human_yeast_targetdecoy.splib \
    ./data/MSV000091183/peak/iPRG2012.mgf iPRG2012.mztab &
pid=$!
pidstat -r -p $pid 1 >> iprg2012_mem_stat.log
