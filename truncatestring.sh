#!/bin/bash


string=`cat colorstring|fold -w1 |grep -i [a-z]` 
#echo $string
for i in $string
do
if [[ "$i" != [^A-Fa-f] ]]
then
echo -e "\e[92m  $i \e[0m"
elif [[ "$i" != [^G-Kg-k] ]]
then
echo -ne "\e[91m  $i \e[0m"
#elif [[ "$i" =~ [^L-Pl-p] ]]
#then
#echo -ne "\e[95m  $i \e[0m"

else
echo $i
fi
done
