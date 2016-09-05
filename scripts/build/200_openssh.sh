#! /bin/sh
set -eu

ROOT=$PWD

mkdir -p build/openssh
mkdir -p prefix
mkdir -p trash
cd build/openssh

$ROOT/src/openssh/configure \
	CC=gcc-static \
	--prefix=$ROOT/trash \
	--bindir=$ROOT/prefix/bin \
	--host=$HOST \
	--enable-largefile \
	--disable-pkcs11 \
	--disable-etc-default-login \
	--disable-lastlog \
	--disable-utmp \
	--disable-utmpx \
	--disable-wtmp \
	--disable-wtmpx \
	--disable-libutil \
	--disable-pututline \
	--disable-pututxline \
	--without-openssl \
	--without-ssh1 \
	--without-rpath \
	--without-solaris-contracts \
	--without-solaris-projects \
	--without-solaris-privs \
	--without-osfsia \
	--with-zlib=$ROOT/prefix \
	--without-skey \
	--without-ldns \
	--without-libedit \
	--without-pie \
	--without-ssl-engine \
	--without-pam \
	--without-selinux \
	--without-kerberos5 \
	--without-md5-passwords \
	--with-4in6 \
	--without-bsd-auth \
	--with-cppflags="-DANDROID"

make ssh
mkdir -p $ROOT/prefix/bin/
cp $ROOT/build/openssh/ssh $ROOT/prefix/bin/
