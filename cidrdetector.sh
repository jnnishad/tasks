#!/bin/bash

green=`tput setaf 2`
reset=`tput sgr0`
cidrs=(10.0.0.0/16 10.241.0.0/16 10.244.0.0/16 172.20.0.0/16 172.31.0.0/16 10.252.0.0/16 10.247.0.0/16 10.242.0.0/16 10.235.0.0/16 10.234.0.0/16 10.255.0.0/16 10.253.0.0/16 10.239.0.0/16 10.238.0.0/16 10.245.0.0/16 10.237.0.0/16 10.249.0.0/16 10.246.0.0/16 10.254.0.0/16 10.236.0.0/16 172.16.0.0/16 10.251.0.0/16 10.240.0.0/16 10.243.0.0/16 10.233.64.0/19 10.233.0.0/19 10.233.32.0/19 10.248.0.0/16 10.233.96.0/19)
#cidrs=`cat list_ip|awk -F ';' '{print$2}'`
cidrarr=()
for cidr in "${cidrs[@]}"; do
    mask=$(echo $cidr | cut -d/ -f2)
    ip=$(echo $cidr | cut -d/ -f1)
    cidrdec=0;maskdec=0;p=0
    for i in {1..4}; do
        e=$((2**$((8*(4-$i)))))
        o=$(echo $ip | cut -d. -f$i)
        cidrdec=$(($cidrdec+$o*$e))
    done
    for ((i=1; i<=$mask; i++)); do
        maskdec=$(($maskdec+2**(32-$i)))
    done
    cidrarr+=($cidr)
    cidrarr+=($cidrdec)
    cidrarr+=($maskdec)
done
# END SETUP CIDR ARRAY DATA

cidrtest() {
    ipdec=0
    for i in {1..4}; do
        e=$((2**$((8*(4-$i)))))
        o=$(echo $1 | cut -d. -f$i)
        ipdec=$(($ipdec+$o*$e))
    done
    for i in ${!cidrarr[@]}; do
        [ $((i%3)) -ne 0 ] && continue
        t=${cidrarr[i+1]}
        m=${cidrarr[i+2]}
        ipm=$(($ipdec & $m))
        [[ $ipm -eq $t ]] && echo "$1 ; $green ${cidrarr[i]} $reset"
    done
}
list=$(cat all_ip_tmp |grep '/')
for test in $list
do
cidrtest $test
done
