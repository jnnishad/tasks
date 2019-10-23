#!/bin/bash


function pi() {

ping -c1 $1

};


for i in ` arp -a|awk '{print$2}'| awk -F '(' '{print$2}'| awk -F ')' '{print$1}'`
do 
pi $i
done
