#!/bin/bash

user=`whoami`
if [ "$user"x = "root"x ]
then
    echo "the current user is root. please change to normal user."
    exit -1
fi

# 创建工作目录
work_dir="${HOME}/work/github"
if [ ! -d "${work_dir}" ]
then
    mkdir -p ${work_dir}
fi
cd ${work_dir}

target_repo="spf13-vim"
target_url="git@github.com:chenjm1217/spf13-vim.git"

echo -e "will download and install ${target_repo} now? [y/N] \c"
read ans

if [ "${ans}"x = "n"x -o "${ans}"x = "N"x ]
then
    echo -e "nothing to do!\n"
else
    if [ -d "${work_dir}/spf13-vim" ]
    then
        echo -e "spf13-vim already exists! remove it? [y/N] \c"
        read remove_ans
        
        if [ "${remove_ans}"x = "n"x -o "${remove_ans}"x = "N"x ]
        then
            echo "use existed spf13-vim version"
        else
            echo "removing..."
            rm -rf "${target_repo}"
            echo "remove: done!"
            echo "install spf13-vim start..."
            
            echo "git clone ${target_url}"
            git clone ${target_url}
            echo "git cloneL done!"
        fi
    else
        echo "git clone ${target_url}"
        git clone ${target_url}
        echo "git cloneL done!"
    fi
    
    echo -e "install now? [y/N] \c"
    read install_ans
    
    if [ "${install_ans}"x = "n"x -o "${install_ans}"x = "N"x ]
    then
        echo -e "nothing to do!\n"
    else
        echo "install: curl https://j.mp/spf13-vim3 -L > spf13-vim.sh && sh spf13-vim.sh"
        curl https://j.mp/spf13-vim3 -L > spf13-vim.sh && sh spf13-vim.sh
        echo -e "curl install ${target_repo}: done!\n"
    fi
fi

echo "done!"
