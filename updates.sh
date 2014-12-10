echo -n "{"
# package updates, uncomment for your distro
echo -n "\"updates\" : \""
#debian/ubuntu
echo -n `apt-get -s upgrade | awk '/[0-9]+ upgraded,/ {print $1}'`

echo -n "\""

echo -n "}"