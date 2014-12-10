# Json start
echo -n "{"

echo -n "\"updates\" : \""

#debian/ubuntu
echo -n `apt-get -s upgrade | awk '/[0-9]+ upgraded,/ {print $1}'`

echo -n "\""

# Json end
echo -n "}"