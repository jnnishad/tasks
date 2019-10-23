#!/bin/bash
lists=(`grep [[:digit:]] dbid`)
count=0 
name=(`shuf users`)
#for i in jai shubham sagar nikhil rohan
#do
# length of array list
len=${#lists[@]}
for((i=0,j=0;i<=$len;i++))
do
#echo $k

echo ${name[$j]}, ${lists[$i]}
count=`expr $count + 1 `
if [ $count -eq 3 ]
then 
count=0
j=`expr $j + 1`
fi
done
#done

