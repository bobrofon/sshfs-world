#! /bin/sh
set -eu

mkdir -p src
git clone https://github.com/libffi/libffi.git src/libffi
cd src/libffi
./autogen.sh
