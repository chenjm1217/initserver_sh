#!/bin/bash

user=`whoami`
if [ ! "$user"x = "root"x ]
then
    echo "current user is not root. please change to root user."
    exit -1
fi

# start iptables if not started!
echo "starting iptables..."
service iptables restart
echo "done!"
cd 

echo -e "which ports would you like to ACCEPT [press Enter to quit]: \c"
read port
while [ ! "$port"x = ""x ]
do
    iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport ${port} -j ACCEPT
    echo -e "which ports would you like to ACCEPT [press Enter to quit]: \c"
    read port
done
echo "done!"

echo -e "which ports would you like to DROP [press Enter to quit]: \c"
read port
while [ ! "$port"x = ""x ]
do
    iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport ${port} -j DROP
    echo -e "which ports would you like to DROP [press Enter to quit]: \c"
    read port
done
echo "done!"
