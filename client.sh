#!/bin/bash

# Json start
printf "{"

# Disk
printf "\"disk\":{";
printf "\""
printf /bin/df --total 2> /dev/null | /usr/bin/awk  '/total/ { printf "total\":\""$2"\",\"used\":\""$3"\",\"free\":\""$4"\""}' | /usr/bin/tr -d '\n'
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
printf "}"

# Json end
printf "}"
