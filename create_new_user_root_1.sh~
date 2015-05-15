#!/bin/bash

# test the server type and version
echo "OS Information:"

os_distribute=`cat /etc/issue | head -1`
echo "distribute version: ${os_distribute}"

os_kernel=`uname -r`
echo "kernel version    : ${os_kernel}"

#os_version=`cat /proc/version`
os_gcc=`gcc --version | grep gcc`
echo "gcc version       : ${os_gcc}"

echo -e ${str}
# add new user and add it to the sudoer

echo -e "add new user?[y/N]\c"
read ans

if [ "${ans}" = "N"x -o "${ans}"x = "n"x ]
then
    echo "nothing to do!"
else
    user=`whoami`
    if [ "$user"x = "root"x ]
    then
        echo -e "new user name     : \c"
        read new_username
        check_str="${new_username}:"
        user_exist=`cat /etc/passwd | grep ${check_str}`
    
        # if null, user not exist
        if [ -z $user_exist ]
        then
            echo -e "adding new user...\c"
            useradd ${new_username} 2>/dev/null
            err=$?
            if [ "${err}"x != "0"x ]
            then
                echo -e "Error: user [${new_username}] add failed.[errno = ${err}]"
                exit 1
            fi
            echo "done!"
            passwd ${new_username}
            echo "done!"
        else
            echo "Warning: user [${new_username}] existed."
            exit 1
        fi
    else
        echo "current user     : $user"
        echo "Error: please make sure to run the script with root user!"
        exit 1
    fi
fi

##########################################################
echo -e "if add new user to the sudoers?[y/N]\c"
read ans

if [ "${ans}"x = "N" -o "${ans}"x = "n" ]
then
    echo "nothing to do!"
else
    cp /etc/sudoers /etc/sudoers.backup
    echo "backup suoders...done!"
    echo -e "input the new user name: \c"
    read new_sudoname
    
    echo -e "add user [${new_sudoname}] to sudoers...\c"
    str="${new_sudoname}\tALL=(ALL)\tALL"
    sed -i "/^root/ a\\${str}" /etc/sudoers
    echo "done!"
fi
