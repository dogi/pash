#!/bin/bash
# tag: count_morphs
# set -e

IN=${IN:-$PASH_TOP/evaluation/benchmarks/poets/input/pg/}
OUT=${OUT:-$PASH_TOP/evaluation/benchmarks/poets/output/7_1/}
ENTRIES=${ENTRIES:-1000}
mkdir -p "$OUT"

for input in $(ls ${IN} | head -n ${ENTRIES})
do
    cat $IN/$input | sed 's/ly$/-ly/g' | sed 's/ .*//g' | sort | uniq -c > ${OUT}/${input}.out
done

echo 'done';
rm ${OUT}
