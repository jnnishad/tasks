#!/bin/bash

red=$(tput setaf 1)
green=$(tput setaf 2)
blink=$(tput blink)
reset=$(tput sgr0)

read -p "Enter IP to be scanned : " IP

data=$(nmap -sL $IP|awk '/Nmap scan report/{print $NF}')
ip_host=$(nmap -sL $IP|awk '/Nmap scan report/{print $NF}'|wc -l)
pivot=$(nmap -sL $IP|awk '/Nmap scan report/{print $NF}'|head -1)
echo -e "Number of hosts : $ip_host"
while true
do

echo -e "\t\t\t\t\t 1 > Enter subet"
echo -e "\t\t\t\t\t 2 > Exit"
read -p " $red Enter ur choice : $reset" opt
case $opt in

        1) read -p "Enter Subnet range to be scanned : " SUBNET
                sub1=`nmap -sL $SUBNET|awk '/Nmap scan report/{print $NF}'`
                for range in $sub1
                do
                if [ "$pivot" == "$range" ]
                then
                echo "$green $IP can be in given subnet $reset"
                exit
                fi
                done
        ;;
        2) exit
        ;;
esac
done
