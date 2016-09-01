#! /bin/sh
set -eu

mkdir -p src
git clone https://github.com/libfuse/libfuse.git -b fuse_2_9_bugfix src/fuse
cd src/fuse
./makeconf.sh
