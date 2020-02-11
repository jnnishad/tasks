#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`


menu=( 'list vpc' 'list region' 'Create vpc' 'Create subnet in vpc' 'Create SG' 'edit route table'  'Delete task' )
menu_len=${#menu[@]}
len=$(( $menu_len-1 ))
#echo len is $len
for list in $(seq 0 $len)
do
printf "\t\t\t\t\t ($list) ${menu[$list]}\n"
done

echo -ne "Enter operation number : "
read input
case $input in
        0)
                aws ec2 describe-vpcs|grep -A 6 "VpcId" |egrep -w "VpcId|CidrBlock"|tr -d  '",'
                ;;
        1)
                echo -e "\t\t\t\tUS East (N. Virginia)"
                echo -e "\t\t\t\tUS East (Ohio)"
                echo -e "\t\t\t\tUS West (N. California)"
                echo -e "\t\t\t\tUS West (Oregon)"
                echo -e "\t\t\t\tAsia Pacific (Hong Kong)"
                echo -e "\t\t\t\tAsia Pacific (Mumbai)"
                echo -e "\t\t\t\tAsia Pacific (Seoul)"
                echo -e "\t\t\t\tAsia Pacific (Singapore)"
                echo -e "\t\t\t\tAsia Pacific (Sydney)"
                echo -e "\t\t\t\tAsia Pacific (Tokyo)"
                echo -e "\t\t\t\tCanada (Central)"
                echo -e "\t\t\t\tEU (Frankfurt)"
                echo -e "\t\t\t\tEU (Ireland)"
                echo -e "\t\t\t\tEU (London)"
                echo -e "\t\t\t\tEU (Paris)"
                echo -e "\t\t\t\tEU (Stockholm)"
                echo -e "\t\t\t\tSouth America (São Paulo)"
                echo ""
                ;;
        2)
                echo ""
                read -p "Choose/Creare cidr-block/ipv4-address : " add

                aws ec2 create-vpc --cidr-block $add
                ;;
        3)      aws ec2 describe-vpcs|grep -A 6 "VpcId" |egrep -w "VpcId|CidrBlock"|tr -d  '",'
                echo -ne "Select VPC for subnet : "
                read vpc
                read -p "Enter subnet range : " sub
                aws ec2 create-subnet --vpc-id $vpc --cidr-block $sub
                ;;
        4)
                echo $red
                echo -e  "\t\t\t\t(0)Delete vpc"
                echo -e  "\t\t\t\t(1)Delete SG"
                echo -e  "\t\t\t\t(2)Delete Route table"
                echo -e  "\t\t\t\t(3)Delete Internet gw"
                echo $reset
                read -p "Enter your choice : " input
                        case $input in
                        0)
                        echo -e "choose vpc-id"
                        echo ""
                        aws ec2 describe-vpcs|grep -A 6 "VpcId" |egrep -w "VpcId|CidrBlock"|tr -d  '",'

                        read -p  "Enter VPC_ID : " vpc
                        aws ec2 delete-vpc --vpc-id $vpc
                        ;;
                        esac
esac
