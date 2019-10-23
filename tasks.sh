#################################################################
# Name : Jaihind.R.Nishad                                       #
# Script : Follow instructions according to scripts             #
# Created : 09/09/2019                                          #
#################################################################

#!/bin/bash
DATE=`date +"%d-%m-%Y"`
PRODUCT=('EMI_ACTIVATION' 'EPAYLATER_ACTIVATION' 'NB_ACTIVATION' 'PRODUCT_ADDITION')
MODE=$((${#PRODUCT[@]}-1))
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
BOLD=$(tput bold)
RESET=$(tput sgr0)
#==============================================================================================
function file_modder(){
if [ -f /missender/ACTIVATION/$1/$1-$date.csv ]
	then
	echo -e "$GREEN FILE FOUND SUCCESSFULLY $RESET"
	else echo -e "$RED ERROR $RESET : No such File found in missender/ACTIVATION/$1/"
	echo -e "Place right file with csv extension"
	exit
	fi
}
#==============================================================================================
function EMI_ACTIVATION_PATTERN() {
echo -e "call Emi_Activation('${data_[1]}','${data_[2]}','${data_[3]}','${data_[4]}',${data_[5]},${data_[6]},${data_[7]},'${data_[8]}','${data_[9]}','${data_[10]}','${data_[11]}','${data_[12]}')"  >> "${PRODUCT[$input]}"-$date.tmp
}
#==============================================================================================
function NB_ACTIVATION_PATTERN() {
echo -e "call add_new_nbbank_withChargesWOmerchant_bank_allowed(${data_[1]},${data_[2]},'${data_[3]}',${data_[4]},${data_[5]},${data_[6]},${data_[7]},${data_[8]},'${data_[9]},${data_[10]},${data_[11]},${data_[12]},${data_[13]},"${data_[14]}")"  >> "${PRODUCT[$input]}"-$date.tmp
}
#==============================================================================================
function EMI () {
cols="$2"
	while read line
	do
		for num in $(seq 1 $cols)
		do
		data_[num]=`echo $line|awk  -v map="$num" -F '|' '{print $map}'`
		done
	#boto=$3
	 $3
	done < "/missender/ACTIVATION/$1/$1-$date.csv"
	tr -d '\r' < "${PRODUCT[$input]}"-$date.tmp > "${PRODUCT[$input]}"-$date.sql
}
#==============================================================================================
function DB_DROID () {
read -p "Check Content (y/n) : " ans
	if [ $ans == n]
	then exit
	elif [ $ans == y ]
	then head -20 "${PRODUCT[$input]}"-$date.sql
	else exit
	fi

read -p "Do you want to take backup for ${PRODUCT[$input]} (y/n)" db
	if [ $db == n ] 
		then exit
	elif [ $db == y ]
        	then 
		read -p "Specify DB user : " DB_USER
		mysqldump -h 10.0.51.50 -u"$DB_USER" -p mmp "$1" > "$1"_"$date"_mysqldump.sql
		echo "========================== BACKUP COMPLETED for "$1" ==============================================="
	else exit
	fi

	read -p "Import sql file to Database (y/n) : " DATA
		if [ $db == n ]
                then exit
        elif [ $db == y ]
                then
		mysql -u"$DB_USER" -h 10.0.51.50 -p  mmp  < "$1"_"$date"_mysql.sql  > "$1"_"$date"_mysql.log
        else exit
        fi
}
#==============================================================================================
for((lost=0; lost<=$MODE; lost++))
	do
	printf   "\t\t\t\t %s) %s\n"     "$lost"  "${PRODUCT[$lost]}" 
	done

	read -p "Enter the Your Choice : " input
		if [ $input -gt $MODE ]
			then printf "$RED Enter valid input $RESET\n"
			exit
		fi

read -p "Are You Sure for $GREEN${PRODUCT[$input]}$RESET (y/n) : " choice
	if [[ $choice == n ]] 
		then exit 1	
	elif [[ $choice == y ]] 
		then echo "proceed" 
			case "${PRODUCT[$input]}" in
			EMI_ACTIVATION) printf  "selected option is %s\n" "${PRODUCT[$input]}"
			read -p "Look for file "${PRODUCT[$input]}"-"$DATE".csv (y/n): " file
				if [ $file == n ]
					then
					read -p "$YELLOW Provide file date DD-MM-YYYY : e.g 01-02-2019 : $RESET" date
					file_modder "${PRODUCT[$input]}"
					EMI "${PRODUCT[$input]}" "12" EMI_ACTIVATION_PATTERN #> "${PRODUCT[$input]}"-$date
				elif [ $file == y ]
					then 
					date=`date +"%d-%m-%Y"`
					file_modder "${PRODUCT[$input]}"
					EMI "${PRODUCT[$input]}" "12" EMI_ACTIVATION_PATTERN
				else exit
				fi
					;;
					EPAYLATER_ACTIVATION)
					;;
					NB_ACTIVATION) printf  "selected option is %s\n" "${PRODUCT[$input]}"
			read -p "Look for file "${PRODUCT[$input]}"-"$DATE".csv (y/n): " file
                                if [ $file == n ]
                                        then
                                        read -p "$YELLOW Provide file date DD-MM-YYYY : e.g 01-02-2019 : $RESET" date
                                        file_modder "${PRODUCT[$input]}"
                                        EMI "${PRODUCT[$input]}" "14" NB_ACTIVATION_PATTERN #> "${PRODUCT[$input]}"-$date
                                elif [ $file == y ]
                                        then
                                        date=`date +"%d-%m-%Y"`
                                        file_modder "${PRODUCT[$input]}"
                                        EMI "${PRODUCT[$input]}" "14" NB_ACTIVATION_PATTERN #; DB_DROID merchant_conversion_conf
				else exit
                                fi
					;;
					PRODUCT_ADDITION) printf  "selected option is %s\n" " ${PRODUCT[$input]}"
					;;
			esac
	else 
	echo " $RED Enter valid input $BOLD** $RESET"
	fi 
#==============================================================================================
