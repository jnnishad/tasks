#!/bin/bash
#################################################################
# Name : Jaihind.R.Nishad                                       #
# Script : Fetch transactions from log                          #
# Created : 5/12/18                                             #
#################################################################


function LAYBACK() {
#if [ "$USER" == "`ls -l .system/crpyt|awk '{print$3}'`" ]
#then  echo tracked > /dev/null
for(( i=1,b=5;i<=5;i++,b-- ))
do
if [[ $1 = $UID &&  "$USER" == "`ls -l .system/crpyt|awk '{print$3}'`" ]]
then  echo tracked > /dev/null 
else
echo -e  `tput setaf 2` "Attempt $i \n" `tput sgr0`
echo -e `tput setaf 1` "BAD INPUT SERVER WILL GO DOWN IN $b WRONG ATTEMPTS \n"`tput sgr0`
#sleep 2
echo -ne " Enter Encryption to use this script : "
read -s password
if [ $password = `nl -bn $LOOP | sed -n 3p ` ] 
then break
fi
if [[ $i = 5 && $b = 1 ]] ;then exit ;fi
fi
done
};
LOOP='.system/crpyt'
UNIQUE_ID=`nl -bn $LOOP | sed -n 1p` 
TRAP=1

function sql(){
mysql -u paynetz --password=`sed -n 2p $LOOP` -D mmp -h 192.168.151.87 -e "select count(*) from $1;"
#query=$(echo -e `mysql -u paynetz -p mmp -h 192.168.151.87 -e "select * from mm_txn limit 5;"`)

};
if [ $UID -eq $UNIQUE_ID ]
then
while TRAP=1
do
##clear
CONTENT=( 'Search transaction' 'Processor' 'Memory' 'Space' 'Process' 'Time' 'more' 'exit' )
for i in $(seq 0 7)
do
echo -e "\t\t\t\t\t\t\t\t($i) ${CONTENT[$i]} "
done
echo -ne  "Enter ur choice : "
read num
case $num in
0 ) 
LAYBACK  $UNIQUE_ID #$(sed -n 1,1p $LOOP)
echo -ne "\n\n\n Enter ur txn : "
read txn
mysql -u paynetz --password=`sed -n 2p $LOOP` -D mmp -h 192.168.151.87 -e "select * from mm_txn where txn_id=$txn;"
#query=$(echo -e `mysql -u paynetz -p mmp -h 192.168.151.87 -e "select * from mm_txn limit 5;"`)
echo "$query"
break;;
1 )
LAYBACK  $UNIQUE_ID 
CPU_THRESOLD=90
CPU_USAGE=$(echo -e " `top -b -n3 -d 0.5  -p 1|fgrep Cpu|tail -1| awk -F 'id,' -v prefix="$prefix" '{ split ($1, vs, ","); v=vs[length(vs)]; sub("%", "", v); printf "%s%.1f%%\n", prefix, 100 - v }'` -----  `date` ")
if [[ `echo $CPU_USAGE | cut -d '.' -f1` -lt $CPU_THRESOLD ]]
then
echo -e " THRESOLD is  `tput setaf 2`$CPU_THRESOLD%`tput sgr0` Usage is `tput setaf 3`$CPU_USAGE`tput sgr0` "
else echo -e " THRESOLD is  `tput setaf 2`$CPU_THRESOLD%`tput sgr0` Usage is `tput setaf 1`$CPU_USAGE`tput sgr0` "
fi
;;
2 ) free -m 
break;;
3 ) 
SPACE=`df -h`
#BORDER=`awk '{print$2"\t"$3"\t"$4"\t"$5}'`
echo "$SPACE"|grep -B 1 -w /|awk '{print$2"\t"$3"\t"$4"\t"$5}'
#df -h|grep -B 1 -w /|awk '{print$2"\t"$3"\t"$4"\t"$5}' 
break;;
4 ) top 
break;;
5 ) date 
;;
6 ) clear
while true
	do
	#clear` 'exit' )
	CONTENT=( 'mm_txn' 'mm_txn_final' 'mm_txn_extn' 'GO_TO_BACK_MENU' )
	for i in $(seq 0 3)
	do
	
	printf "\t\t\t\t\t\t\t\t%s\n" "($i) ${CONTENT[$i]} "
	done
	echo -ne  "Enter ur choice : "
	read choice 
	case $choice in
	0 ) sql mm_txn
	;;
	1 ) sql mm_txn_final
	;;
	2 ) sql mm_txn_extn
	;;
	3 )
	break	
	;;
	esac
	done
;;
7 )  
break;;
* )
echo "INVALID OPTION"
;;
esac
done
fi
