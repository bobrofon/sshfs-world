#! /bin/sh
set -eu

ROOT=$PWD

mkdir -p build/glib
mkdir -p prefix
mkdir -p trash
cd build/glib

PKG_CONFIG_PATH=$ROOT/prefix/lib/pkgconfig \
$ROOT/src/glib/configure \
	CC=gcc-static \
	--prefix=$ROOT/trash \
	--libdir=$ROOT/prefix/lib \
	--includedir=$ROOT/prefix/include \
	--host=$HOST \
	--enable-static \
	--disable-shared \
	--disable-man \
	--disable-systemtap \
	--with-pic \
	--with-pcre=internal

make
make install
