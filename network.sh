echo -n "{"

#Network
echo -n "\"Network\" : { "

#hostname
echo -n "\"Hostname\" : \""
/bin/hostname | /usr/bin/tr -d '\n'
echo -n "\" },"

#Uptime
echo -n "\"Uptime\" : \""
/usr/bin/uptime | /bin/grep -ohe 'up .*' | /bin/sed 's/,//g' | /usr/bin/awk '{ print $2" "$3 }' | /usr/bin/tr -d '\n'
echo -n "\""

echo -n "}"