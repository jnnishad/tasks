#!/bin/bash

for i in `cat tract`
do 
#echo -e "  $i  `grep  "<AccountNo>" $i|head -1 |grep -o "[[:digit:]]\+"`                 `grep '<OrderNo>' $i |tail -1|awk '{print$7}'|awk -F '<' '{print$2}'|awk -F '>' '{print$2}'` "

a=`grep  "<AccountNo>" $i|head -1 |grep -o "[[:digit:]]\+" |sed "s/\(......\)\(......\)/\1\XXXXXX/g"`
#brrn=`grep -A 2 $(grep -B 12 "</x:NetworkRequest> for - $i"  server.log.2018-11-23 |grep Trans|head -1|awk -F '<' '{print$2}'|awk -F '>' '{print$2}') |grep OrderNo|tail -1|awk -F '<' '{print$2}'|awk -F '>' '{print$2}'`
brrn=` grep -B 20 "</x:NetworkRequest> for - $i"  $i |grep -A 3 "<RespCode>0000"|grep OrderNo|awk -F '<' '{print$2}'|awk -F '>' '{print$2}'`


#tid=`grep -B 12 "</x:NetworkRequest> for - $i" $i |grep Trans|head -1|awk -F '<' '{print$2}'|awk -F '>' '{print$2}'`
tid=`grep -B 12 "</x:NetworkRequest> for - $i" $i |grep '<TransData>........</TransData>'|tail -1|awk -F '<' '{print$2}'|awk -F '>' '{print$2}'`
#if [ -z "$tid" ]
#then 
#tid=`grep -A 8 $i $i|grep '<TransData>1091....</TransData>'|tail -1|awk -F '<' '{print$2}'|awk -F '>' '{print$2}'`
echo -e "update transaction_log set cardnumber='"$a"',response_code='0000',txn_status='OK',rrn='"$brrn"',stage='Transaction Success',user_data_27='00' where transaction_id='"$tid"';   -- $i "
#fi
done



# echo 6225760805198541| sed "s/\(......\)\(......\)/\1\XXXXXX/g"
