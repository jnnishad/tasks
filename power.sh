#!/bin/bash

echo "jai ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

if [ $? -ne 0 ]
then 
chmod u+w /etc/sudoers
echo "jai ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
chmod u-w /etc/sudoers
echo check status
fi
