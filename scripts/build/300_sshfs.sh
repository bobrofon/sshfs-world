#! /bin/sh
set -eu

ROOT=$PWD
PREFIX=$ROOT/prefix

mkdir -p build/sshfs
mkdir -p prefix
cd build/sshfs

PKG_CONFIG_PATH="${PREFIX}/lib/pkgconfig:${PREFIX}/lib64/pkgconfig" \
CC=gcc-static \
meson \
	--prefix=$PREFIX \
	--backend ninja \
	--buildtype release \
	--strip \
	--unity off \
	--default-library static \
	$ROOT/src/sshfs

ninja
ninja install
