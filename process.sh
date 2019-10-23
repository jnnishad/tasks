#!/bin/bash

function mak() {

col=$(head -n1 finaldata|awk -F '|' '{print NF}')
while read line
do
for i in $(seq 1 $col)
do
#eval data_${i}=`echo $line|awk  -v map="$i" -F '|' '{print $map}'`
data_[i]=`echo $line|awk  -v map="$i" -F '|' '{print $map}'`
done
#echo -e "${data_[1]},'${data_[2]}'"
echo -e "call Emi_Activation('${data_[1]}','${data_[2]}','${data_[3]}','${data_[4]}',${data_[5]},${data_[6]},${data_[7]},'${data_[8]}','${data_[9]},'${data_[10]}','${data_[11]}','${data_[12]}')"
done < finaldata

}


mak
