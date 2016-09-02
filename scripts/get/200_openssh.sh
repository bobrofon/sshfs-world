#! /bin/sh
set -eu

mkdir -p src
git clone https://github.com/openssh/openssh-portable.git src/openssh
cd src/openssh
autoreconf -i
