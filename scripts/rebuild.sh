#! /bin/bash
set -eu

source arm_universe/activate.sh
./scripts/clear.sh
./scripts/get.sh
./scripts/versions.sh
run ./scripts/build.sh
