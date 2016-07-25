#! /bin/sh

mkdir -p src
git clone ${LIBFUSE_URL} src/fuse
cd src/fuse
./makeconf.sh
