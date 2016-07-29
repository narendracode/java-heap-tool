#!/bin/bash

pid_file=/Users/narendra/Documents/workspace/shellscript/jvmtool/pid

pid=$(head -n 1 $pid_file)

echo "$pid"

buffer=1024.0 #1mb
#buffer=24.0 #1mb
OC=`jstat -gc $pid | awk '{print $7}' | tail -1` #returns memory size in KB
OU=`jstat -gc $pid | awk '{print $8}' | tail -1` #returns memory size in KB

#http://docs.oracle.com/javase/1.5.0/docs/tooldocs/share/jstat.html#gc_option documentation on jstat

echo "$OC"
echo "$OU"

result=`awk "BEGIN { print (($OC-$buffer) > $OU) }"`

if [ "$result" = 0 ]; then
    echo "Killing program because JVM Memory leak is detected."
    kill -9 $pid
elif [ "$result" = 1 ]; then 
	echo "Program running fine."
fi

echo "$result"