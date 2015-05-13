#!/bin/bash

user=`whoami`
if [ "$user"x = "root"x ]
then
    exit
fi

# 创建工作目录
mkdir ~/download
cd ~/download

wd=`pwd` 
target="${HOME}/download"
echo "pwd = ${wd}"
echo "target = ${target}"

if [ "${wd}"x != "${target}"x ]
then
    exit 1
fi

softwares=("vim-7,4.tar.bz2" "Python-2.7.9.tar.xz")
urls=("ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2" "https://www.python.org/ftp/python/2.7.9/Python-2.7.9.tar.xz")
echo "will download following software:"

echo "${softwares[0]}  from  ${urls[0]}"
echo "${softwares[1]}  from  ${urls[1]}"

echo -e "download?[y/N] \c"
read ans

if [ "${ans}"x = "N"x -o "${ans}"x = "n"x ]
then
    echo "nothing to do!"
else
    echo -e "download one by one or together?[o/t] \c"
    read ans
    
    count=${#softwares[@]}
    echo "total download ${count} softwares"
    for ((i=0;i<${count};i++ ))
    do
        if [ "${ans}"x = "T"x -o "${ans}"x = "t"x ]
        then
            wget ${urls[${i}]}
        else
            echo -e "download [${softwares[${i}]}]?[y/N] \c"
            read down
            
            if [ "${down}"x = "n"x -o "${down}"x = "N"x ]
            then
                echo -e "jump [${softwares[${i}]}]"
            else
                wget ${urls[${i}]}
            fi
            echo "Next------------------->"
            echo "Next------------------->"
        fi
    done
fi

echo "all softwares dowload finished!"
echo "done!"
