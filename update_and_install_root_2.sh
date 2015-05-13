#!/bin/bash

user=`whoami`
if [ "$user"x = "root"x ]
then
    exit
fi

############################################################
echo -e "system will update?[y/N]\c"
read ans

if [ "${ans}"x = "N" -o "${ans}"x = "n" ]
then
    echo "nothing to do!"
else
    yum clean all && yum clean metadata && yum clean dbcache
    yum -y update
    yum -y upgrade
fi

###########################################################
echo -e "install necessary package?[y/N]\c"
read ans

if [ "${ans}"x = "N" -o "${ans}"x = "n" ]
then
    echo "nothing to do!"
else
    yum install -y man wget ctags cscope git lrzsz openssh-server openssh-client openssl-devel
    yum groupinstall -y "Development Tools"
fi
   
