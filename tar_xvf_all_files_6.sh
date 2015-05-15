#!/bin/bash

user=`whoami`
if [ "$user"x = "root"x ]
then
    echo "the current user is root. please change to normal user."
    exit -1
fi

# 切换工作目录
work_dir="${HOME}/download"
if [ -d "${work_dir}" ]
then
    cd ~/download
else
    echo "work folder [${work_dir}] not found, nothing to do!"
    exit -1
fi

wd=`pwd` 
echo "pwd = ${wd}"
echo -e "work_folder = ${work_dir}\n"

if [ "${wd}"x != "${work_dir}"x ]
then
    echo "work dir incorrect!"
    exit -1
fi

softwares=("vim-7.4.tar.bz2" 
"Python-2.7.9.tar.xz" 
"cfe-3.6.0.src.tar.xz" 
"llvm-3.6.0.src.tar.xz" 
"compiler-rt-3.6.0.src.tar.xz" 
"libcxx-3.6.0.src.tar.xz" 
"clang-tools-extra-3.6.0.src.tar.xz")

echo "will tar following softwares:"

count=${#softwares[@]}
for (( i=0;i<${count};i++ ))
do
    echo "${softwares[${i}]}"
done

echo -e "tar -xvf now?[y/N] \c"
read ans

if [ "${ans}"x = "N"x -o "${ans}"x = "n"x ]
then
    echo -e "nothing to do!\n"
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
    echo "all softwares tar xvf finished!"
fi

echo "done!"