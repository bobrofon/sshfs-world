#! /bin/sh
set -eu

mkdir -p src
git clone https://github.com/libfuse/libfuse.git src/fuse
cd src/fuse
./makeconf.sh
