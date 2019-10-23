#!/bin/bash

n=4
for((i=1;i<=$n;i++))
do
echo -ne '#'
for((j=1;j<=$n;j++))
do
echo -ne "#"
echo ''
done
done

echo  ''
