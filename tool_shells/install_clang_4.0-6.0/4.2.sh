#!/bin/bash
rm -rf clang-tools-extra-3.4 clang-tools-extra-3.4.2.src compiler-rt-3.4 compiler-rt-3.4.2.src cfe-3.4.2.src llvm-3.4.2.src clang extra compiler-rt

tar xvf clang-tools-extra-3.4.src.tar.gz
tar xvf compiler-rt-3.4.src.tar.gz
tar xvf cfe-3.4.2.src.tar.gz
tar xvf llvm-3.4.2.src.tar.gz

mv clang-tools-extra-3.4 clang-tools-extra-3.4.2.src
mv compiler-rt-3.4 compiler-rt-3.4.2.src

mv cfe-3.4.2.src clang
mv clang llvm-3.4.2.src/tools/

mv clang-tools-extra-3.4.2.src extra
mv extra llvm-3.4.2.src/tools/clang/

mv compiler-rt-3.4.2.src compiler-rt
mv compiler-rt llvm-3.4.2.src/projects/

mkdir build-3.4.2
cd build-3.4.2

../llvm-3.4.2.src/configure --enable-optimized --enable-targets=host-only

echo -e "continue?[y/N] \c"
read ans
if [ "${ans}"x = "n"x -o "${ans}"x = "N"x ]
then
    echo "done!"
    exit
else
    make
fi
