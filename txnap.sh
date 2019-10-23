#!/bin/bash
for i in `cat AP`
do
a=`grep -A 1 -B 2 "$i"  "$1" |grep OrderNo |tail -1|awk '{print$NF}'|tr '\<' '\ '|tr '\>' '\ '|awk '{print$2}'`
#a=` grep -A 1 -B 2 $i  $1 |grep -w OrderNo|tail -1|tr '\<' '\ '|tr '\>' '\ '|awk '{print$8}'`
if [ $? -eq 0 ]
then
a=`grep -B 20 $i server.log.2018-11-23|grep Thread|grep -w OrderNo|tr '\<'  '\ '|tr '\>'  '\ '|awk '{print$7}'|tail -1`
card=`grep -A 2 $i $1 |grep AccountNo|head -1|tr '\<' '\ '|tr '\>' '\ '|awk '{print$2}'|sed "s/\(......\)\(.........\)/\1\XXXXXXXXX/g"`
echo -e "update transaction_log set cardnumber='$card',response_code='0000',txn_status='OK',rrn='$a',stage='Transaction Success',user_data_27='00' where transaction_id='$i';" 
else 
echo -e ' '$i'  - not found '
fi
done


#grep -A 2 10915956 server.log.2018-11-23|grep AccountNo|head -1|tr '\<' '\ '|tr '\>' '\ '|awk '{print$2}'
