#!/bin/bash

user=`whoami`
if [ "$user"x = "root"x ]
then
    echo "the current user is root. please change to normal user."
    exit -1
fi

# 创建工作目录
work_dir="${HOME}/work/github"
if [ !-d "${work_dir}" ]
then
    mkdir -p ${work_dir}
fi
cd ${work_dir}

echo "git clone git@github.com:chenjm1217/initserver_sh.git to ${work_dir}"
git clone git@github.com:chenjm1217/initserver_sh.git ${workdir}
echo "done!"

echo "git clone git@github.com:chenjm1217/vimrc.git to ${work_dir}"
git clone git@github.com:chenjm1217/vimrc.git ${work_dir}
echo "done!"
