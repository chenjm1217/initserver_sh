# initserver_sh
Init new installed linux server
===============================

理论上可以按照需要按照编码顺序执行脚本。各个脚本之间在完成的功能上基本相互独立，但是后一个脚本可能依赖前一个脚本的结果。  
脚本名称规范约定如下：  
 - 脚本名说明脚本的主要功能
 - 后缀`_root`表示脚本需要的用户权限
 - 后缀`_[1-~]`表示脚本顺序
 - 单词全部小写并用`_`符相连
    - sub item 1
    - sub item 2

各个脚本的功能说明如下：  
`create_new_user_root_1.sh`  
**root**权限下创建新用户并设置密码，将新建用户加入`sudoer`列表  
  
`update_and_install_root_2.sh`  
更新系统，清理缓存并安装必要的常用软件：  
- man
- wget
- ctags
- cscope
- git
- lrzsz
- openssh-server
- openssh-client
- openssl-devel
- **Development Tools**

`create_ssh_to_github_3.sh`  
创建ssh密钥对，并将公钥提供给`github`，测试与`github`的`ssh`加密通信  

`git_my_repos_4.sh`  
从`github`服务器上`git`我的工程到`~/work/github`目录下  
- vimrc
- initserver_sh

`download_software_5.sh`  
下载常用软件软件的源码包到`~/download`目录下  
- vim-7.4.tar.bz2
- Python-2.7.9.tar.xz

`tar_xvf_all_files_6.sh`  
解压`~/download`目录下的压缩包  
- vim-7.4.tar.bz2
- Python-2.7.9.tar.xz
