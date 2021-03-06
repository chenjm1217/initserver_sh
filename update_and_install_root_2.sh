#!/bin/bash

user=`whoami`
if [ "$user"x = "root"x ]
then
    echo "the current user is root. please change to normal user."
    exit
fi

############################################################
echo -e "system will update?[y/N]\c"
read ans

if [ "${ans}"x = "N"x -o "${ans}"x = "n"x ]
then
    echo "nothing to do!"
else
    sudo yum clean all && yum clean metadata && yum clean dbcache
    sudo yum -y update
    sudo yum -y upgrade
fi

###########################################################
echo -e "install necessary package?[y/N]\c"
read ans

if [ "${ans}"x = "N"x -o "${ans}"x = "n"x ]
then
    echo "nothing to do!"
else
    sudo yum install -y man epel-release screen wget ctags cscope git git-svn lrzsz ncurses-devel openssh-server openssh-clients openssl openssl-devel nc gdb ntsysv
    sudo yum groupinstall -y "Development Tools"
fi

echo -e "\ndone!" 
