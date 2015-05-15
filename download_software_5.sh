#!/bin/bash

user=`whoami`
if [ "$user"x = "root"x ]
then
    echo "current user is root. please change to normal user"
    exit -1
fi

# 创建工作目录
work_dir="${HOME}/download"
if [ ! -d "${work_dir}" ]
then
    mkdir ${work_dir}
fi
cd ${work_dir}

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
"clang-tools-extra-3.6.0.src.tar.xz" 
"cmake-3.2.2.tar.gz")


urls=("ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2" 
"https://www.python.org/ftp/python/2.7.9/Python-2.7.9.tar.xz" 
"http://llvm.org/releases/3.6.0/cfe-3.6.0.src.tar.xz" 
"http://llvm.org/releases/3.6.0/llvm-3.6.0.src.tar.xz" 
"http://llvm.org/releases/3.6.0/compiler-rt-3.6.0.src.tar.xz" 
"http://llvm.org/releases/3.6.0/libcxx-3.6.0.src.tar.xz" 
"http://llvm.org/releases/3.6.0/clang-tools-extra-3.6.0.src.tar.xz" 
"http://www.cmake.org/files/v3.2/cmake-3.2.2.tar.gz")


scount=${#softwares[*]}
echo "will download following ${scount} softwares:"

for((i=0;i<${scount};i++))
do
    echo "${softwares[${i}]}  from ${urls[${i}]}"
done

echo
echo -e "download?[y/N] \c"
read ans

if [ "${ans}"x = "N"x -o "${ans}"x = "n"x ]
then
    echo -e "nothing to do!\n"
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
    echo -e "all softwares dowload finished!\n"
fi

echo "done!"
