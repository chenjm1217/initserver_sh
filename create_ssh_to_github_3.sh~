#!/bin/bash

user=`whoami`
if [ "$user"x = "root"x ]
then
    exit
fi

# 查看是否已经存在密钥对
echo "ls -al ~/.ssh:"
ls -al ~/.ssh

echo -e "确认生成ssh密钥对?[y/N] \c"
read ans

if [ "$ans"x = "n"x -o "$ans"x = "N"x ] 
then
    # 创建密钥对
    ssh-keygen -t rsa -C "chenjm1217@126.com"
fi

# 将密钥对加入ssh-agent
echo "将密钥对加入ssh-agent"
ssh-agent bash
ssh-add ~/.ssh/id_rsa

echo "请将公钥 ~/.ssh/id_rsa.pub 中的内容拷贝到github服务器上"
read ans

# 测试
ssh -T git@github.com
