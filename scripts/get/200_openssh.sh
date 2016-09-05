#! /bin/sh
set -eu

mkdir -p src
git clone https://github.com/bobrofon/openssh-portable.git -b passwd src/openssh
cd src/openssh
autoreconf -i
