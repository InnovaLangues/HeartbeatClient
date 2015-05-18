#!/bin/bash

# Json start
printf "{"

# Timestamp
printf "\"timestamp\":";
printf "\""
date +%s | /usr/bin/tr -d '\n'
printf "\","

# Disk
printf "\"disk\":{";
printf "\""
/bin/df --total 2> /dev/null | /usr/bin/awk  '/total/ { printf "total\":\""$2"\",\"used\":\""$3"\",\"free\":\""$4"\""}' | /usr/bin/tr -d '\n'
printf "},"

# CPU
printf "\"cpu\":{";
# Count
printf "\"count\":\""
/bin/grep -c ^processor /proc/cpuinfo | /usr/bin/tr -d '\n'
printf "\","

# Load
printf "\"load\":{\""
/bin/cat /proc/loadavg | /usr/bin/awk '{print "min1\":\""$1"\",\"min5\":\""$2"\",\"min15\":\""$3""}' | /usr/bin/tr -d '\n'
printf "\"}},"

# Memory
printf "\"memory\":{";
/usr/bin/free | /usr/bin/awk 'NR == 2 {printf "\"total\":\""$2"\",\"used\":""\""$3"\",\"free\":\""$4"\","} NR == 3 {printf "\"buffersCache\":{\"used\":\""$3"\",\"free\":\""$4"\"},"} NR ==4 {printf "\"swap\":{\"total\":\""$2"\",\"used\":\""$3"\",\"free\":\""$4"\"}"}'
printf "},"

#Processes
printf "\"processes\":[";
echo $(/bin/ps axo user,comm,pcpu,vsz --sort -pcpu | /usr/bin/awk 'BEGIN{OFS=":"} NR>1 {print "{ \"user\" : \"" $1 "\", \"command\" : \"" $2 "\", \"percent_cpu\" : "$3", \"memory_used\" : "$4" },"}') | /bin/sed '$s/,$//';
printf "]";

# Json end
printf "}";
