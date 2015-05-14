#!/bin/bash

user=`whoami`
if [ "$user"x = "root"x ]
then
    exit
fi

# 创建工作目录
cd ~/download

wd=`pwd` 
target="${HOME}/download"
echo "pwd = ${wd}"
echo "target = ${target}"

if [ "${wd}"x != "${target}"x ]
then
    exit 1
fi

softwares=("vim-7.4.tar.bz2" "Python-2.7.9.tar.xz")
echo "will tar following software:"

count=${#softwares[@]}
for (( i=0;i<${count};i++ ))
do
    echo "${softwares[${i}]}"
done

echo -e "tar -xvf now?[y/N] \c"
read ans

if [ "${ans}"x = "N"x -o "${ans}"x = "n"x ]
then
    echo "nothing to do!"
else
    echo -e "tar -xvf one by one or together?[o/t] \c"
    read ans
    
    count=${#softwares[@]}
    echo "total tar -xvf ${count} softwares"
    for ((i=0;i<${count};i++ ))
    do
        if [ "${ans}"x = "T"x -o "${ans}"x = "t"x ]
        then
            tar xvf ${softwares[${i}]}
        else
            echo -e "tar xvf [${softwares[${i}]}]?[y/N] \c"
            read tarnow
            
            if [ "${tarnow}"x = "n"x -o "${tarnow}"x = "N"x ]
            then
                echo -e "jump [${softwares[${i}]}]"
            else
                tar xvf ${softwares[${i}]}
            fi
            echo "Next------------------->"
            echo "Next------------------->"
        fi
    done
fi

echo "all softwares tar xvf finished!"
echo "done!"
