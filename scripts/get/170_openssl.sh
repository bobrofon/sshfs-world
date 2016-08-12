#! /bin/sh
set -eu

mkdir -p src
git clone https://github.com/openssl/openssl.git -b OpenSSL_1_0_2-stable src/openssl
