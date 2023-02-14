#!/bin/bash

EXP_DATA=$1
BASE=$(basename $EXP_DATA)
FILENAME="${BASE%.*}"

python3 -m ann_solo.ann_solo -c ./configs/hek293.ini \
    ./data/MSV000091183/library/massive_human_hcd_unique_targetdecoy.splib \
    $EXP_DATA ${FILENAME}.mztab &
pid=$!
pidstat -r -p $pid 1 >> ${FILENAME}_mem_stat.log
