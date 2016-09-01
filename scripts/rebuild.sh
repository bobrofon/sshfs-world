#! /bin/bash
set -eu

source arm_universe/activate.sh
run ./scripts/clear.sh
./scripts/get.sh
run ./scripts/build.sh
