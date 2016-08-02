#!/bin/bash

pid_file=/Users/narendra/Documents/workspace/SourceTreeRepositories/java-heap-tool/pid

pid=$(head -n 1 $pid_file)

echo "$pid"

#buffer=1024.0 #1mb
buffer=800.0 #KB
OC=`jstat -gc $pid | awk '{print $7}' | tail -1` #returns memory size in KB
OU=`jstat -gc $pid | awk '{print $8}' | tail -1` #returns memory size in KB
OGCMX=`jstat -gccapacity $pid | awk '{print $8}' | tail -1` #returns memory size in KB

#http://docs.oracle.com/javase/1.5.0/docs/tooldocs/share/jstat.html#gc_option documentation on jstat

echo "OC: $OC"
echo "OU: $OU"
echo "OGCMX: $OGCMX"

#result=`awk "BEGIN { print (($OC-$buffer) > $OU) }"`
result=`awk "BEGIN { print (($OGCMX-$OU) > $buffer) }"`
if [ "$result" = 0 ]; then
    echo "Killing program because JVM Memory leak is detected."
    kill -9 $pid
elif [ "$result" = 1 ]; then 
	echo "Program running fine."
fi

#echo "$result"