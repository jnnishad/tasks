#!/bin/bash

Task=( 'Set_Alarm' 'Edit_Alarm' )

for menu in $(seq 0 1)
do
echo -e "\t\t\t\t\t\t\t\t($menu) ${Task[$menu]} "
done
echo -ne  "Enter ur choice : "
read num
case $num in
0 )     echo -e "Choose Component to Monitor "
        Feature=( 'EC2' 'RDS' )
        for menu in $(seq 0 1)
        do
        echo -e "\t\t\t\t\t\t\t\t($menu) ${Feature[$menu]} "
        done
        echo -ne  "Enter ur choice : "
        read num
        case $num in
        0)      list=( 'CPU' 'Diskiop-count' 'Diskiop-bytes' 'Network-IN' 'Network-OUT' )
                for menu in $(seq 0 4)
                do
                echo -e "\t\t\t\t\t\t\t\t($menu) ${list[$menu]} "
                done
                echo -ne  "Enter ur choice : "
                read num
                case $num in
                0)
                echo -ne "Enter Name of the instace :"
                read name
                echo -ne "Enter ID of the instace :"
                read ID
                echo -ne "Submit CPU cap in percent .,`tput setaf 2`50 , 60 , 70`tput sgr0` :"
                read cap
                echo -ne "Submit Unit .,`tput setaf 2`Percent , Seconds`tput sgr0` :"
                read unit
                echo -ne "Submit periods in seconds ,Not less than a min.,`tput setaf 2`60 , 120 , 180`tput sgr0` :"
                read sec
        aws cloudwatch put-metric-alarm --alarm-name ${Feature[0]}_"$name"_"$cap"  --alarm-description "Alarm when CPU exceeds $cap%" --metric-name CPUUtilization --namespace AWS/EC2 --statistic Maximum  --period "$sec" --threshold "$cap" --comparison-operator GreaterThanOrEqualToThreshold --dimensions  Name=InstanceId,Value="$ID" --evaluation-periods 1 --alarm-actions arn:aws:sns:us-east-2:472811501032:Default_CloudWatch_Alarms_Topic  --unit "$unit"
                esac
                ;;
        1)      list=( 'CPU' 'Diskiop-count' 'Diskiop-bytes' 'Network-IN' 'Network-OUT' )
                for menu in $(seq 0 4)
                do
                echo -e "\t\t\t\t\t\t\t\t($menu) ${list[$menu]} "
                done
                echo -ne  "Enter ur choice : "
                read num
                case $num in
                0)
                echo -ne "Enter Name of the RDS :"
                read name
                echo -ne "Submit CPU cap in percent .,`tput setaf 2`50 , 60 , 70`tput sgr0` :"
                read cap
                echo -ne "Submit Unit .,`tput setaf 2`Percent , Seconds`tput sgr0` :"
                read unit
                echo -ne "Submit periods in seconds ,Not less than a min.,`tput setaf 2`60 , 120 , 180`tput sgr0` :"
                read sec
        aws cloudwatch put-metric-alarm --alarm-name ${Feature[0]}_"$name"_"$cap" --alarm-description "Alarm when CPU exceeds $cap" --metric-name CPUUtilization --namespace AWS/EC2 --statistic Maximum  --period "$sec" --threshold "$cap" --comparison-operator GreaterThanOrEqualToThreshold --evaluation-periods 1 --alarm-actions arn:aws:sns:us-east-2:472811501032:Default_CloudWatch_Alarms_Topic --unit "$unit"
                esac;;


        esac
esac



#aws cloudwatch put-metric-alarm --alarm-name cpu-mon-usage-80  --alarm-description "Alarm when CPU exceeds 20%" --metric-name CPUUtilization --namespace AWS/EC2 --statistic Average --period 60 --threshold 20 --comparison-operator GreaterThanOrEqualToThreshold --dimensions  Name=InstanceId,Value=i-12345678 --evaluation-periods 1 --alarm-actions arn:aws:sns:us-east-2:472811501032:Default_CloudWatch_Alarms_Topic  --unit Percent
