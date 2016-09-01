#! /bin/sh
set -eu

mkdir -p src
git clone https://github.com/GNOME/glib.git src/glib
cd src/glib
NOCONFIGURE=1 ./autogen.sh
