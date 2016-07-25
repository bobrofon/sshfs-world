#! /bin/sh

source arm_universe/activate.sh
run ./scripts/clear.sh

./scripts/get/100_libfuse.sh
./scripts/get/150_zlib.sh

run ./scripts/build/100_libfuse.sh
run ./scripts/build/150_zlib.sh
