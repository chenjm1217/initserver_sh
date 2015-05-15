#!/bin/bash
rm -rf cfe-3.5.2.src clang clang-tools-extra-3.5.2.src extra compiler-rt-3.5.2.src compiler-rt llvm-3.5.2.src

tar xvf cfe-3.5.2.src.tar.xz 
tar xvf clang-tools-extra-3.5.2.src.tar.xz 
tar xvf compiler-rt-3.5.2.src.tar.xz 
tar xvf llvm-3.5.2.src.tar.xz

mv cfe-3.5.2.src clang
mv clang llvm-3.5.2.src/tools/

mv clang-tools-extra-3.5.2.src extra
mv extra llvm-3.5.2.src/tools/clang/

mv compiler-rt-3.5.2.src compiler-rt
mv compiler-rt llvm-3.5.2.src/projects/

mkdir build-3.5.2
cd build-3.5.2

../llvm-3.5.2.src/configure --enable-optimized --enable-targets=host-only

echo -e "continue?[y/N] \c"
read ans
if [ "${ans}"x = "n"x -o "${ans}"x = "N"x ]
then
    echo "done!"
    exit
else
    make
fi