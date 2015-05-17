#!/bin/bash

user=`whoami`
if [ "$user"x = "root"x ]
then
    echo "the current user is root. please change to normal user."
    exit
fi

# 查看是否已经存在密钥对
echo "ls -al ~:"

ls -al ${HOME}

echo -e "确认生成ssh密钥对?[y/N] \c"
read ans

if [ "$ans"x = "n"x -o "$ans"x = "N"x ] 
then
    echo "use existed ssh key pair!"
else
    # 创建密钥对
    ssh-keygen -t rsa -C "chenjm1217@126.com"
fi

# 将密钥对加入ssh-agent
echo "请新建一个ssh连接，执行以下命令，将密钥对加入ssh-agent"
echo "ssh-agent bash"
echo "sh-add ~/.ssh/id_rsa"

echo "请将公钥 ~/.ssh/id_rsa.pub 中的内容拷贝到github服务器上"
read ans

echo -e "press any key to continue...\c"
read ans

# 测试
echo "testing ssh to github..."
ssh -T git@github.com
echo "testing : done!"

# config git global setting
cmd="git config --global user.name 'jeremy'"
echo ${cmd}
eval ${cmd}

cmd="git config --global user.email chenjm1217@126.com"
echo ${cmd}
eval ${cmd}

echo "done!"
