#!/bin/bash

user=`whoami`
if [ "$user"x = "root"x ]
then
    echo "current user is root. please change to normal user."
    exit -1
fi

dir_prefix="${HOME}/work/github"
# 判断工作目录
if [ ! -d ${dir_prefix} ]
then
    mkdir -p ${dir_prefix}
fi

cd 
cd ${dir_prefix}

# git from github
echo "git clone git@github.com:chenjm1217/vimrc.git to ${dir_prefix}"
if [ -d "${dir_prefix}/vimrc" ]
then
    echo "folder [vimrc] exists! remove it?[y/N]"
    read ans
    if [ "${ans}"x = "n"x -o "${ans}"x = "N"x ]
    then
        echo "nothing to do!"
    else
        rm -rf "${dir_prefix}/vimrc" 
        git clone git@github.com:chenjm1217/vimrc.git ${dir_prefix}/vimrc
        echo "git: done!"
    fi
else
    git clone git@github.com:chenjm1217/vimrc.git ${dir_prefix}/vimrc
    echo "git: done!"
fi

# copy .vimrc
echo "copy .vimrc from vimrc/_vimrc..."
if [ ! -f "${dir_prefix}/vimrc/_vimrc" ]
then
    echo "git vimrc/_vimrc failed! check please!"
    exit -1
else
    eval "cp ${dir_prefix}/vimrc/_vimrc  ~/.vimrc"
    echo "copy .vimrc: done!"
fi

# git Vundle from https://github.com/gmarik/Vundle.vim
echo "git Vundle"
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo "git Vundle: done!"

echo "install plugins for vim"
vim

echo "wait for finishing... and enjoy it!"
