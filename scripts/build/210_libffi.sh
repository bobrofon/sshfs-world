#! /bin/sh
set -eu

ROOT=$PWD

mkdir -p build/libffi
mkdir -p prefix
mkdir -p trash
cd build/libffi

$ROOT/src/libffi/configure \
	CC=gcc-static \
	--prefix=$ROOT/trash \
	--libdir=$ROOT/prefix/lib \
	--includedir=$ROOT/prefix/include \
	--host=$HOST \
	--enable-static \
	--disable-shared \
	--enable-portable-binary \
	--disable-docs \
	--with-pic

make
make install
