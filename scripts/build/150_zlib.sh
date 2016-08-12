#! /bin/sh
set -eu

ROOT=$PWD

mkdir -p build
cp -R src/zlib build/zlib
mkdir -p prefix
mkdir -p trash
cd build/zlib

CC=gcc-static \
$ROOT/src/zlib/configure \
	--prefix=$ROOT/trash \
	--sharedlibdir=$ROOT/trash \
	--libdir=$ROOT/prefix/lib \
	--includedir=$ROOT/prefix/include \
	--const \
	--static

make
make install
