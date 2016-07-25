#! /bin/sh

mkdir -p src
git clone https://github.com/bobrofon/libfuse.git src/fuse
cd src/fuse
./makeconf.sh
