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

repos=("initserver_sh" 
"vimrc" 
"spf13-vim")

git_urls=("git@github.com:chenjm1217/initserver_sh.git" 
"git@github.com:chenjm1217/vimrc.git" 
"git@github.com:chenjm1217/spf13-vim.git")

repo_count=${#repos[*]}
echo -e "\nwill download following ${repo_count} repos from github:"

for((i=0;i<${repo_count};i++))
do
    echo -e "${repos[${i}]}\tfrom\t${git_urls[${i}]}"
done

echo -e "git now?[y/N] \c"
read ans

if [ "${ans}"x = "n"x -o "${ans}"x = "N"x ]
then
    echo -e "nothing to do!\n"
else
    echo -e "git one by one or together?[o/t] \c" 
    read ans
    
    for((i=0;i<${repo_count};i++))
    do
        if [ "${ans}"x = "t"x -o "${ans}"x = "T"x ]
        then
            git clone ${git_urls[${i}]}
            echo "git clone ${repos[${i}]}: done!"
        else
            echo -e "git clone [${repos[${i}]}]?[y/N] \c"
            read git_ans
            
            if [ "${git_ans}"x = "n"x -o "${git_ans}"x = "N"x ]
            then
                echo "jump [${repos[${i}]}]"
            else
                if [ -d "${repos[${i}]}" ]
                then
                    echo -e "remove existing folder [${repos[${i}]}]?[y/N] \c"
                    read rm_ans
                    if [ "${rm_ans}"x = "n"x -o "${rm_ans}"x = "N"x ]
                    then
                        echo "git cancled! target folder existed!"
                    else
                        rm -rf ${repos[${i}]}
                    fi
                fi
                git clone ${git_urls[${i}]}
                echo "git clone ${repos[${i}]}: done!"
            fi
        fi
        echo "-------------------------------------------"
    done
fi

echo "done!"
