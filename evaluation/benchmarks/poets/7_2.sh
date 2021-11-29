#!/bin/bash
# set -e
# tag: count_consonant_sequences

IN=${IN:-$PASH_TOP/evaluation/benchmarks/poets/input/pg/}
#ls ${IN} | sed "s;^;$IN;"| xargs cat | tr '[a-z]' '[A-Z]' | tr -sc 'BCDFGHJKLMNPQRSTVWXYZ' '[\012*]' | sort | uniq -c
OUT=${OUT:-$PASH_TOP/evaluation/benchmarks/poets/output/7_2}
mkdir -p ${OUT}
ENTRIES=${ENTRIES:-1000}
mkdir -p "$OUT"
for input in $(ls ${IN} | head -n ${ENTRIES} | sed "s;^;$IN;")
do
    cat "$input" | tr '[a-z]' '[A-Z]' | tr -sc 'BCDFGHJKLMNPQRSTVWXYZ' '[\012*]' | sort | uniq -c > "${OUT}/$(basename ${input})"
done

for output in $(ls ${OUT} | sed "s;^;$OUT/;")
do
    cat $output
done

echo 'done';
rm -rf ${OUT}
