#!/bin/bash

# Json start
printf "{"

# Network
printf "\"Network\" : { "

# Hostname
printf "\"Hostname\" : \""
/bin/hostname | /usr/bin/tr -d '\n'
printf "\" },"

# Uptime
printf "\"Uptime\" : \""
/usr/bin/uptime | /bin/grep -ohe 'up .*' | /bin/sed 's/,//g' | /usr/bin/awk '{ print $2" "$3 }' | /usr/bin/tr -d '\n'
printf "\""

# Json end
printf "}"