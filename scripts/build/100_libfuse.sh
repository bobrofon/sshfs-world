#! /bin/sh

ROOT=$PWD

mkdir -p build/fuse
mkdir -p prefix
mkdir -p trash
cd build/fuse

UDEV_RULES_PATH=$ROOT/trash \
$ROOT/src/fuse/configure \
	CC=gcc-static \
	--prefix=$ROOT/trash \
	--bindir=$ROOT/prefix/bin \
	--libdir=$ROOT/prefix/lib \
	--includedir=$ROOT/prefix/include \
	--host=$HOST \
	--disable-shared \
	--enable-static \
	--enable-lib \
	--enable-util \
	--disable-test \
	--disable-example \
	--disable-mtab \
	--disable-rpath \
	--with-pic \
	--without-libiconv-prefix \
	--enable-largefile

make
make install
