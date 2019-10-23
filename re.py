#!/bin/python
#import re
#import glob
#
#
#
#
#for line in content :
#	for file in glob.iglob(line):
#		for arg in open("re_test_arena","r")
#	if re.search("Paynetz", content):
#		print line,
#content.close()

#Paynetz transaction id created as

import re
import os
import sys

#for f in filter(os.path.isfile, sys.argv[2:]):
#	for line in open(f).readline():
#		if re.findall(sys.argv[1], line):
#			print line

file = open("re_test_arena","r")
for line in file:
	if "Paynetz" in line :
		print(line)
