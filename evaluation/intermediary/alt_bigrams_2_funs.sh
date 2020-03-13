#!/bin/bash

alt_bigrams_aux()
{
    s2=$(mktemp -u)
    ( mkfifo $s2 > /dev/null ) ;
    tee $s2 |
        tail +2 |
        paste $s2 - |
        sort |
        uniq
    rm $s2
}

alt_bigram_aux_reduce()
{
    IN1=$1
    IN2=$2
    OUT=$3

    sort -m $IN1 $IN2 |
        uniq > $OUT
}

export -f alt_bigrams_aux
export -f alt_bigram_aux_reduce