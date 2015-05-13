#!/bin/bash

user=`whoami`
if [ "$user"x = "root"x ]
then
    exit
fi

# 创建工作目录
cd
mkdir work
cd work
mkdir github
cd github

cd ~/work/github/
echo "git clone git@github.com:chenjm1217/initserver_sh.git to ~/work/github"
git clone git@github.com:chenjm1217/initserver_sh.git
echo "done!"

echo "git clone git@github.com:chenjm1217/vimrc.git to ~/work/github"
git clone git@github.com:chenjm1217/vimrc.git
echo "done!"
