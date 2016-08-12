#! /bin/sh
set -eu

source arm_universe/activate.sh
run ./scripts/clear.sh

./scripts/get/100_libfuse.sh
./scripts/get/150_zlib.sh
./scripts/get/170_openssl.sh
./scripts/get/200_openssh.sh

run ./scripts/build/100_libfuse.sh
run ./scripts/build/150_zlib.sh
run ./scripts/build/170_openssl.sh
run ./scripts/build/200_openssh.sh
