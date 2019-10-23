for((i=1;i<=$1;i++))
do
j=0
while [ $j -lt $i ]
do
echo -ne "*"
j=$((j+1))
done
echo ""
done
