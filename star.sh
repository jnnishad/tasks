#!/bin/bash


#for((i=1;i<=5;i++))
#do 
#echo  "*\c"
#i=$((i+1))
#done




for i in 5 4 3 2 1
do
j=0
while [ $j -lt $i ]
do
echo -ne "*"
j=$(($j+1))
done
echo ""
done


for i in $(seq 1 $1)
do
j=0;
while [ $j -lt $i ]
do
echo  -ne "*"
j=$((j+1))
done
#echo  -ne "*"
echo ""
done
