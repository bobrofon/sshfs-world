#! /bin/sh

source arm_universe/activate.sh
source scripts/arm.sh
run ./scripts/clear.sh
./scripts/get/100_libfuse.sh
run ./scripts/build/100_libfuse.sh
