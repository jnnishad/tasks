#!/bin/bash

for i in $*
do
cat $i | sort -u  > $1_filtered.txt
done
