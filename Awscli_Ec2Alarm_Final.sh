#!/bin/bash

# File Specifier can be changed if data needs to be feeded from different file
FILE=custom_ec2.csv
COPY=custom_ec2.tmp

# ARG
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
blink=`tput blink`
yellow=`tput setaf 3`

# File Content validater
        count=$(awk -F ',' '{print NF}' $FILE)
        N=1
        for length in $count
        do
        if [[ $length -ne 8 ]]
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
                QUERRY $2 $3 $4 $5
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
aws cloudwatch put-metric-alarm --alarm-name Ec2_"$1"_${data_[2]}_$2 --alarm-description "Alarm when $1 exceeds $2" --metric-name $1 --namespace "System/Linux" --statistic Maximum  --period ${data_[7]} --threshold $2 --comparison-operator $4 --dimensions  Name=InstanceId,Value=${data_[2]} --treat-missing-data breaching --evaluation-periods 1 --alarm-actions ${data_[8]} --unit $3
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
CHECK QUERRY MemoryUtilization ${data_[3]} Percent GreaterThanOrEqualToThreshold
CHECK QUERRY Port${data_[4]} 0 Count LessThanOrEqualToThreshold
CHECK QUERRY ${data_[5]} 0 Count LessThanOrEqualToThreshold
CHECK QUERRY URLCheck-${data_[6]} 0 Count LessThanOrEqualToThreshold

done < $COPY
