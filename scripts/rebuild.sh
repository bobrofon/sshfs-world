#! /bin/bash
set -eu

source arm_universe/activate.sh
run ./scripts/clear.sh

./scripts/get/100_libfuse.sh
./scripts/get/150_zlib.sh
./scripts/get/170_openssl.sh
./scripts/get/200_openssh.sh
./scripts/get/210_libffi.sh
./scripts/get/250_glib.sh
./scripts/get/300_sshfs.sh

run ./scripts/build/100_libfuse.sh
run ./scripts/build/150_zlib.sh
run ./scripts/build/170_openssl.sh
run ./scripts/build/200_openssh.sh
run ./scripts/build/210_libffi.sh
run ./scripts/build/250_glib.sh
run ./scripts/build/300_sshfs.sh
