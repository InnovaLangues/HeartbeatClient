#!/bin/bash

# Json start
printf "{"

# Disk
printf "\"disk\":{";
printf "\""
echo /bin/df --total | /usr/bin/awk  '/total/ { printf "total\":\""$2"\",\"used\":\""$3"\",\"free\":\""$4"\""}' | /usr/bin/tr -d '\n'
printf "},"

# CPU
printf "\"cpu\":{";
# Count
printf "\"count\":\""
echo /bin/grep -c ^processor /proc/cpuinfo | /usr/bin/tr -d '\n'
printf "\","

# Load
printf "\"load\":{\""
echo /bin/cat /proc/loadavg | /usr/bin/awk '{print "min1\":\""$1"\",\"min5\":\""$2"\",\"min15\":\""$3""}' | /usr/bin/tr -d '\n'
printf "\"}},"

# Memory
printf "\"memory\":{";
echo /usr/bin/free | /usr/bin/awk 'NR == 2 {printf "\"total\":\""$2"\",\"used\":""\""$3"\",\"free\":\""$4"\","} NR == 3 {printf "\"buffersCache\":{\"used\":\""$3"\",\"free\":\""$4"\"},"} NR ==4 {printf "\"swap\":{\"total\":\""$2"\",\"used\":\""$3"\",\"free\":\""$4"\"}"}'
printf "}"

# Json end
printf "}"
