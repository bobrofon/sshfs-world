#! /bin/sh
set -eu

mkdir -p src
git clone https://github.com/libfuse/sshfs.git src/sshfs
cd src/sshfs
autoreconf -i
