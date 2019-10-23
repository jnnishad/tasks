#!/bin/bash
echo -n "Enter elemets : "
read n

sum=0
sub=0
for((i=1;i<=$n;i++))
do

echo -n "Enter $i num :"
read num
sub=$num
#sum=$((sum + num))
if [ $i -gt 1 ] 
then
echo $sub true value
sub=$((sub - num))
fi
done
#echo $sum
echo sub is $sub
