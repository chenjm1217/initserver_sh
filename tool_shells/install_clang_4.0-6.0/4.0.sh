#!/bin/bash
rm -rf clang-3.4 clang-tools-extra-3.4 compiler-rt-3.4 llvm-3.4 cfe-3.4.0.src clang-tools-extra-3.4.0.src compiler-rt-3.4.0.src llvm-3.4.0.src clang extra compiler-rt

tar xvf clang-3.4.src.tar.gz
tar xvf clang-tools-extra-3.4.src.tar.gz
tar xvf compiler-rt-3.4.src.tar.gz
tar xvf llvm-3.4.src.tar.gz

mv clang-3.4 cfe-3.4.0.src
mv clang-tools-extra-3.4 clang-tools-extra-3.4.0.src
mv compiler-rt-3.4 compiler-rt-3.4.0.src
mv llvm-3.4 llvm-3.4.0.src

mv cfe-3.4.0.src clang
mv clang llvm-3.4.0.src/tools/

mv clang-tools-extra-3.4.0.src extra
mv extra llvm-3.4.0.src/tools/clang/

mv compiler-rt-3.4.0.src compiler-rt
mv compiler-rt llvm-3.4.0.src/projects/

mkdir build-3.4.0
cd build-3.4.0

../llvm-3.4.0.src/configure --enable-optimized --enable-targets=host-only

echo -e "continue?[y/N] \c"
read ans
if [ "${ans}"x = "n"x -o "${ans}"x = "N"x ]
then
    echo "done!"
    exit
else
    make
fi