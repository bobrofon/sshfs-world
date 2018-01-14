#! /bin/sh
set -eu

ROOT=$PWD
PREFIX=$ROOT/prefix

mkdir -p build/fuse
mkdir -p prefix
mkdir -p trash
cd build/fuse

CC=gcc-static \
meson \
	--prefix=$PREFIX \
	--backend ninja \
	--buildtype release \
	--default-library static \
	-D disable-mtab=true \
	-D udevrulesdir=$ROOT/src/fuse/util/udev.rules \
	$ROOT/src/fuse

ninja
echo "#! /bin/sh" > $ROOT/src/fuse/util/install_helper.sh
ninja install
