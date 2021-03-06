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
"vim74" 
"cmake-3.2.2"
"webbench-1.5.tar.gz"
"iftop-0.17" 
"clang-3.4.2")

# python2.7 must enable share like --enable-share!!! to make YouCompleteMe install ok
#"sudo ln -s /usr/local/lib/libpython2.7.so.1.0  /usr/lib64/libpython2.7.so.1.0"
# -rpath表示复制一份so到该目录下。可用于解决软件非默认安装时找不到相关so的问题
# /usr/local/lib/libpython2.7.so.1.0是python安装到/usr/local后的so路径
# 必须注意要使/usr/lib64/libpython2.7.so.1.0的路径与python希望查找的so路径匹配。可以通过ldd /dir/to/python来比较

install_steps=( "rm -rf Python-2.7.9:"\
"tar xvf Python-2.7.9.tar.xz:cd Python-2.7.9:"\
"./configure --prefix=/usr/local --enable-shared LDFLAGS='-Wl,-rpath=/usr/lib64':"\
"make:sudo make install:"\
"sudo ln -s /usr/local/lib/libpython2.7.so.1.0  /usr/lib64/libpython2.7.so.1.0"

"rm -rf vim74:"\
"tar xvf vim-7.4.tar.bz2:cd vim74:"\
"sudo yum remove vim vim-enhanced vim-common:"\
"sudo yum install -y ncurses-devel ruby ruby-devel lua lua-devel luajit luajit-devel mercurial "\
"tcl-devel perl perl-devel perl-ExtUtils-ParseXS perl-ExtUtils-XSpp perl-ExtUtils-CBuilder perl-ExtUtils-Embed:"\
"./configure --with-features=huge  --enable-cscope --enable-multibyte --enable-fontset --enable-xim --enable-sniff "\
" --enable-pythoninterp  --enable-luainterp  --with-python-config-dir=/usr/local/lib/python2.7/config --enable-rubyinterp --enable-perlinterp:"\
"make:sudo make install"

"rm -rf cmake-3.2.2:"\
"tar xvf cmake-3.2.2.tar.gz:"\
"sudo yum install ncurses-devel:"\
"cd cmake-3.2.2:"\
"./configure:make:sudo make install"

"rm -rf webbench-1.5:"\
"tar xvf webbench-1.5.tar.gz:"\
"cd webbench-1.5:"\
"make:sudo make install"

"rm -rf iftop-0.17:"\
"tar xvf iftop-0.17.tar.gz:"\
"sudo yum install -y flex byacc libpcap ncurses ncurses-devel libpcap-devel:"\
"cd iftop-0.17:"\
"./configure:"\
"make:sudo make install"

"rm -rf clang-tools-extra-3.4 clang-tools-extra-3.4.2.src compiler-rt-3.4 compiler-rt-3.4.2.src cfe-3.4.2.src llvm-3.4.2.src clang extra compiler-rt build-3.4.2:"\
"tar xvf clang-tools-extra-3.4.src.tar.gz:"\
"tar xvf compiler-rt-3.4.src.tar.gz:"\
"tar xvf cfe-3.4.2.src.tar.gz:"\
"tar xvf llvm-3.4.2.src.tar.gz:"\
"mv clang-tools-extra-3.4 clang-tools-extra-3.4.2.src:"\
"mv compiler-rt-3.4 compiler-rt-3.4.2.src:"\
"mv cfe-3.4.2.src clang:"\
"mv clang llvm-3.4.2.src/tools:"\
"mv clang-tools-extra-3.4.2.src extra:"\
"mv extra llvm-3.4.2.src/tools/clang:"\
"mv compiler-rt-3.4.2.src compiler-rt:"\
"mv compiler-rt llvm-3.4.2.src/projects:"\
"mkdir build-3.4.2:"\
"cd build-3.4.2:"\
"../llvm-3.4.2.src/configure --enable-optimized --enable-targets=host-only:"\
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
