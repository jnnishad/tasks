#!/bin/bash

echo "Enter any values:"

read n

sum=0

for((i=1;i<=$n;i++))

do

echo "Enter $i Numbers"
read num

sum=$((sum + num))

done

echo "Sum of all values:$sum"
~

