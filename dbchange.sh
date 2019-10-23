
#!/bin/bash


for i in `cat transaction`

do
echo "select * from transaction_log where transaction_id="$i";"
done
