#!/bin/bash



read -p "Enter ur number :  "  num
i=2
#for((j=2;j<=$num;j++))
#do
#add=`expr $num % $j` 
#if [ $add -eq 0 ]
#then
#echo number is prime
#else 
#echo  number is not prime
#fi
#done
#


while [ $i -lt $num ]
do
if [ `expr $num % $i` -eq 0 ]
then
echo num is not prime 
exit
fi
i=`expr $i + 1`

done
echo num is prime
