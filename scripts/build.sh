#! /bin/bash

set -eu

ABSOLUTE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for SCRIPT in ${ABSOLUTE_PATH}/build/*
do
	${SCRIPT}
done
