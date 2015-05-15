#!/bin/bash

user=`whoami`
if [ "$user"x = "root"x ]
then
    echo "the current user is root. please change to normal user."
    exit -1
fi

# 切换到工作目录
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

softwares=("Python-2.7.9" 
"vim74")


install_steps=( "cd Python-2.7.9:"\
"./configure:make:sudo make install"
		
"cd vim74:sudo yum remove vim vim-enhanced vim-common:"\
"sudo yum -y install  -y ncurses-devel:"\
"./configure --with-features=huge --enable-multibyte --enable-fontset --enable-cscope --enable-xim "\
" --enable-sniff --enable-gui=auto --enable-pythoninterp --with-python-config-dir=/usr/local/lib/python2.7/config --enable-rubyinterp --enable-luainterp:"\
"make:sudo make install")


echo "will install following software:"

count=${#softwares[@]}
for (( i=0;i<${count};i++ ))
do
    echo "${softwares[${i}]}"
done

echo -e "\ninstall now?[y/N] \c"
read ans

if [ "${ans}"x = "N"x -o "${ans}"x = "n"x ]
then
    echo -e "nothing to do!\n"
else
    echo -e "install one by one or together?[o/t] \c"
    read ans
    
    count=${#softwares[@]}
    echo "total install ${count} softwares"
    for ((i=0;i<${count};i++ ))
    do
        cd ${work_dir}

        if [ "${ans}"x = "T"x -o "${ans}"x = "t"x ]
        then
            index=1
            cmd=`echo ${install_steps[${i}]}|cut -d : -f ${index}`
            while [ "${cmd}"x != ""x ]
            do
                echo ${cmd}
                eval ${cmd}
                index=`expr ${index} + 1`
                cmd=`echo ${install_steps[${i}]}|cut -d : -f ${index}`
            done
        else
            echo -e "install [${softwares[${i}]}] now? [y/N]\c"
            read install_now
            
            if [ "${install_now}"x = "n"x -o "${install_now}"x = "N"x ]
            then
                echo -e "jump [${softwares[${i}]}]"
            else
                index=1
                cmd=`echo ${install_steps[${i}]}|cut -d : -f ${index}`
                while [ "${cmd}"x != ""x ]
                do
                    echo ${cmd}
                    eval ${cmd}
                    index=`expr ${index} + 1`
                    cmd=`echo ${install_steps[${i}]}|cut -d : -f ${index}`
                done
            fi
            echo "Next------------------->"
            echo "Next------------------->"
        fi
    done
    echo -e "all softwares install finished!\n"
fi

echo "done!"
