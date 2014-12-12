#!/bin/bash

# Json start
printf "{"

printf "\"updates\" : \""

#debian/ubuntu
printf `apt-get -s upgrade | awk '/[0-9]+ upgraded,/ {print $1}'`

printf "\""

# Json end
printf "}"