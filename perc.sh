#!/bin/bash

pid=$1
tag[0]="\\"
tag[1]="-"
tag[2]="|"
tag[3]="_"
tag[4]="/"
while true
do
len=${#tag}
do
echo -ne "$tag[$i]"\b
done
echo -ne "working ${tag[0]}"
while true # [[ `kill -0 $pid` ]]
do
for i in "${tag[@]}"
do
for ((j=1;j<=10;j++))
do
 echo -ne "`tput setaf 2`\b.$i`tput sgr0`"
        sleep  0.2
done
for ((j=10;j>=1;j--))
do
 echo -ne "`tput setaf 2`\b`tput sgr0`"

        sleep  0.2
done
done
done
while true # [[ `kill -0 $pid` ]]
do
for i in "${tag[@]}"
do
	echo -ne "`tput setaf 2`\b.$i`tput sgr0`"

	sleep  0.2
done 
done
echo ''
done


pattern='#'

for((i=1;i<=100;i++))
do

echo -e "$i%"
done
