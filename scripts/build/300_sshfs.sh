#! /bin/sh
set -eu

ROOT=$PWD

mkdir -p build/sshfs
mkdir -p prefix
mkdir -p trash
cd build/sshfs

PKG_CONFIG_PATH=$ROOT/prefix/lib/pkgconfig \
$ROOT/src/sshfs/configure \
	CC=gcc-static \
	SSHFS_LIBS="-L/src/prefix/lib -lfuse -lgthread-2.0 -pthread -lglib-2.0 -ldl" \
	--prefix=$ROOT/trash \
	--bindir=$ROOT/prefix/bin \
	--host=$HOST

make
make install
