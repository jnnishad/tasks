#!/bin/bash


#for i in `fold -w1 colorstring`
#do	
#echo -n $i
#done

#if [[ "$1" -eq [a-i] ]]
#if [[ "$1" -le {a..i} ]]
#then 
#echo in range
#else
#echo not in range
#fi
#fold -w1 colorstring|grep [Aa0-Zz9]
for i in `fold -w1 colorstring|grep [a-z]`
do
for j in {a..i} {A..I} 
do 

if [[ "$i" = "$j" ]]
then 
echo -en '\033[0;32m' $i '\033[0m'
break
elif [[ "$i" != "$j" ]]
then
for k in {j..p} {J..P}
do

if [[ "$i" = "$k" ]]
then
echo -en '\033[0;33m' $i '\033[0m'
break
fi
done
elif [[ "$i" != "$k" ]]
then
for l in {q..z} {Q..Z}
do

if [[ "$i" = "$l" ]]
then
echo -en '\033[0;35m' $l '\033[0m'
break
fi
done
else break

fi
done




done


