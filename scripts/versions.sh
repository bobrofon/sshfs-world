#! /bin/bash

set -eu

ABSOLUTE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p ${ABSOLUTE_PATH}/../prefix
echo > ${ABSOLUTE_PATH}/../prefix/versions.txt

for PACKAGE in ${ABSOLUTE_PATH}/../src/*
do
	cd ${PACKAGE}
	echo $(basename ${PWD}) $(git config --get remote.origin.url) $(git rev-parse HEAD) >> ${ABSOLUTE_PATH}/../prefix/versions.tmp
done
column -t < ${ABSOLUTE_PATH}/../prefix/versions.tmp > ${ABSOLUTE_PATH}/../prefix/versions.txt
rm ${ABSOLUTE_PATH}/../prefix/versions.tmp
