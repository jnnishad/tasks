#!/bin/bash


read -p "Enter txn : " txn
grep -A 10 -B 10 $txn txntest > /home/jai/$txn.txt
