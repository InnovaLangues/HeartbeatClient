#!/bin/bash

# Json start
echo -n "{"

# Disk
echo -n "\"Disk\" : { ";
echo -n "\""
/bin/df --total | awk  ' /total/ { print "total\" : \""$2"\", \"used\" : \""$3"\", \"free\" : \""$4"\", \"percentage\" : \""$5"" }' | /usr/bin/tr -d '\n'
echo -n "\" }, "

# CPU
echo -n "\"CPU\" : { ";

# Count
echo -n "\"Count\" : \""
/bin/grep -c ^processor /proc/cpuinfo | /usr/bin/tr -d '\n'
echo -n "\", "

# Load
echo -n "\"Load\" : \""
/bin/cat /proc/loadavg | /usr/bin/awk '{print $1","$2","$3}' | /usr/bin/tr -d '\n'
echo -n "\" }, "

# Memory
echo -n "\"Memory\" : { ";

echo -n "\"Free\" : \""
/usr/bin/free -m | /bin/grep -v shared | /usr/bin/awk '/buffers/ {printf $4 }'
echo -n "\", "

echo -n "\"Total\" : \""
/usr/bin/free -m | /bin/grep -v shared | /usr/bin/awk '/Mem/ {printf $2 }'
echo -n "\" }"

# Json end
echo -n "\" }"