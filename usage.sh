#!/bin/bash
LOOP=1
while LOOP=1
do
CPU_THRESOLD=90
CPU_USAGE=$(echo -e " `top -b -n3 -d 0.5  -p 1|fgrep Cpu|tail -1| awk -F 'id,' -v prefix="$prefix" '{ split ($1, vs, ","); v=vs[length(vs)]; sub("%", "", v); printf "%s%.1f%%\n", prefix, 100 - v }'` -----  `date` ")
if [[ `echo $CPU_USAGE | cut -d '.' -f1` -lt $CPU_THRESOLD ]]
then
echo -e " Thresold is $CPU_THRESOLD Usage is $CPU_USAGE "
fi
done

