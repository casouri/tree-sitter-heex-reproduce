#!/bin/bash

EXT=dylib

git clone https://github.com/tree-sitter/tree-sitter.git --depth=1
git clone git@github.com:casouri/tree-sitter-module.git --depth=1

cd tree-sitter
make
cp libtree-sitter.* ..
cd ../tree-sitter-module
./build.sh heex
cp dist/* ..
cd ..

gcc recipe.c -o recipe -ltree-sitter -ltree-sitter-heex -L. -I./tree-sitter/lib/include
./recipe
