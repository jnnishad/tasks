#!/bin/bash

# File Specifier can be changed if data needs to be feeded from different file
FILE=ec2-data.csv
COPY=ec2-data.tmp

# ARG
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
yellow=`tput setaf 3`

# File Content validater
        count=$(awk -F ',' '{print NF}' $FILE)
        N=1
        for length in $count
        do
        if [[ $length -ne 10 && $length -ne 11 ]]
        then
        echo -e "Parameter in $red line $N $reset is missing"
        exit
        fi
        N=$((N+1))
        done

#Status check of querry
                function CHECK(){
                STATUS=1
                COUNTER=1
                while [ $STATUS -ne 0 ]
                do
                QUERRY $2 $3 $4
                if [ $? -ne 0 ]
                then
                echo -e "Metric $2 failed for ${data_[1]}"
                echo -e "$red Attempt $COUNTER $reset"
                COUNTER=$((COUNTER+1))
                sleep $COUNTER
                else
                STATUS=0
                fi
                done
                }

# awscli for alarm creation AWS/EC2 "System/Linux"
function QUERRY() {
echo -e "Setting $green$1$reset Alarm for ${data_[2]}"
aws cloudwatch put-metric-alarm --alarm-name Ec2_"$1"_${data_[2]}_$2 --alarm-description "Alarm when $1 exceeds $2" --metric-name $1 --namespace AWS/EC2 --statistic Maximum  --period ${data_[9]} --threshold $2 --comparison-operator GreaterThanOrEqualToThreshold --dimensions  Name=InstanceId,Value=${data_[2]} --treat-missing-data breaching --evaluation-periods 1 --alarm-actions ${data_[10]} --unit $3
}
# Execution
sed '1d' $FILE > $COPY
while read line
do
col=$(echo "$line"|tr ',' ' '|wc -w)
for parse in $(seq 1 $col)
do
data_[parse]=`echo $line|awk  -v map="$parse" -F ',' '{print $map}'`
done
CHECK QUERRY CPUUtilization ${data_[3]} Percent
CHECK QUERRY NetworkIn ${data_[4]} Bytes
CHECK QUERRY NetworkOut ${data_[5]} Bytes

if [ $col -eq 10 ]
then
CHECK QUERRY DiskReadBytes ${data_[6]} Bytes
CHECK QUERRY DiskWriteBytes ${data_[7]} Bytes
elif [ $col -eq 11 ]
then
CHECK QUERRY EBSReadBytes ${data_[6]} Bytes
CHECK QUERRY EBSWriteBytes ${data_[7]} Bytes
fi
done < $COPY
