#!/bin/bash


file=/home/DevOpsOnly/test

A=`grep -o "[[:digit:]]\+" $file`

echo "$A"
