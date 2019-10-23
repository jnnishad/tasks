#!/bin/bash

txn=225905024
file=server.log.2018-11-23
top=`cat -n $file| grep $txn|head -1|awk '{print$1}'`
bot=`cat -n $file| grep $txn|tail -1|awk '{print$1}'`
#echo -e "$top - $bot"

sed -n  "$top,$bot p" $file
