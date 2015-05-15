#!/bin/bash

user=`whoami`
if [ "$user"x = "root"x ]
then
    echo "current user is root. please change to normal user."
    exit -1
fi

work_dir="${HOME}/.vim/bundle/YouCompleteMe"
# 判断工作目录
if [ ! -d ${work_dir} ]
then
    echo "Vundle is not installed or YouCompleteMe is not installed"
    exit -1
fi

cd 
cd ${work_dir}

clang_version=`clang --version|grep 'clang version'`
if [ "${clang_version}"x = ""x ]
then
    echo "clang 3.3.0 or heigher version is not installed, check please!"
    exit -1
fi
echo ${clang_version}
echo "ok"

cmake_version=`cmake --version|grep 'cmake version'`
if [ "${cmake_version}"x = ""x ]
then
    echo "cmake is not installed, check please!"
    exit -1
fi
echo ${cmake_version}
echo "ok"

cd
cd ${work_dir}

echo -e "do you want to backup YouCompleteMe first?[y/N] \c"
read ans
if [ "${ans}"x = "n"x -o "${ans}"x = "N"x ]
then
    echo -e "did not backup!\n"
else
    cp -rf ${work_dir} "${work_dir}_backup"
    echo -e "backup: ${work_dir}_bakcup\n"
fi

echo -e "start to install now?[y/N] \c"
read ans

if [ "${ans}"x = "n"x -o "${ans}"x = "N"x ]
then
    echo -e "nothing to do!\n"
else
    # start the YouCopleteMe install shell to compile the libclang.so
    ./install.sh --clang-completer --system-libclang
    echo "YouCompleteMe install shell finished!"
    
    # copy comfig file to user home dir
    cp .vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py ~
    echo "YouCompleteMe install finished, enjoy it! ^^"
fi

echo "done!"
