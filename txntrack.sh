#!/bin/bash
#################################################################
# Name : Jaihind.R.Nishad					#
# Script : Fetch transactions from log				#
# Created : 5/12/18						#
#################################################################


if [ $UID -ne 505 ]
then
echo `tput setaf 1` "YOU DONT HAVE PRIVILEGE TO THIS SCRIPT" `tput sgr0`
exit
fi


if [ $# -lt 1 ]
then
echo `tput setaf 1` WRONG USAGE `tput sgr0`
echo 'USAGE : sh <script> <filename>'
exit
fi

if [ -f $1 ]
then echo Starting process.....
else
echo argument must be proper log file
fi

for i in `cat tract`
do
#txn=$1
file=$1 

top=`cat -n $1|grep $i | head -1|awk '{print$1}'`
bot=`cat -n $1|grep $i | tail -1|awk '{print$1}'`

#get merchant login
login=`grep $i $1 |grep login` 

echo $login>$i

#req=`grep -A 15 -B 15 "$i" $file |grep -B 22 "</x:NetworkRequest>"`
#req=`awk '/\<x\:NetworkRequest*/,/<\/x\:NetworkRequest>/'`

req=`sed -n "$top,$bot p" $1 |awk '/\<x\:NetworkRequest*/,/<\/x\:NetworkRequest>/'`
echo "$req">>$i

merchant_req=`grep $i $file  |grep amt|tail -1`
echo "$merchant_req">>$i
done  
#grep -A 15 -B 15 376023067 server.log.2018-11-23 |grep -B 22 "</x:NetworkRequest>"

#for network xml pattern
# awk '/\<x\:NetworkRequest*/,/<\/x\:NetworkRequest>/' 344488366

#awk '/\<x\:NetworkRequest*/{n+=1}; n % 2 == 1 && ! /\<\/x\:NetworkRequest>/ {print > "output"((n-1)/2)}' 344488366

