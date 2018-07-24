cmake_minimum_required(VERSION 3.0.0)
project(openssh LANGUAGES NONE)

set(ROOT "${CMAKE_CURRENT_SOURCE_DIR}/../..")
if (NOT DEFINED PREFIX)
	set(PREFIX ${CMAKE_CURRENT_BINARY_DIR}/prefix)
endif()
set(TRASH ${CMAKE_CURRENT_BINARY_DIR}/trash)

file(GLOB_RECURSE SRC "${ROOT}/src/openssh/*")
file(GLOB MAIN_DIR "${ROOT}/src/openssh/*")

add_custom_command(OUTPUT ${PROJECT_NAME}-dir COMMAND mkdir -p ${PROJECT_NAME}-dir)

add_custom_command(
	OUTPUT ${PROJECT_NAME}.stamp
	DEPENDS ${SRC} ${PROJECT_NAME}-dir

	COMMAND mkdir -p ${PREFIX}
	COMMAND mkdir -p ${TRASH}
	COMMAND cp -rf ${MAIN_DIR} .
	COMMAND autoreconf -i

	COMMAND
	./configure
		CC=gcc-static
		--prefix=${TRASH}
		--bindir=${PREFIX}/bin
		--host=$ENV{HOST}
		--enable-largefile
		--disable-etc-default-login
		--disable-lastlog
		--disable-utmp
		--disable-utmpx
		--disable-wtmp
		--disable-wtmpx
		--disable-libutil
		--disable-pututline
		--disable-pututxline
		--without-rpath
		--without-solaris-contracts
		--without-solaris-projects
		--without-solaris-privs
		--without-osfsia
		--with-zlib=${PREFIX}
		--without-libedit
		--without-pie
		--without-pam
		--without-kerberos5
		--with-4in6
		--without-bsd-auth
		--with-cppflags=-DANDROID

	COMMAND make ssh
	COMMAND mkdir -p ${PREFIX}/bin/
	COMMAND cp ssh ${PREFIX}/bin/

	COMMAND cmake -E touch ../${PROJECT_NAME}.stamp
	WORKING_DIRECTORY ${PROJECT_NAME}-dir
	VERBATIM
	)

add_custom_target(
	${PROJECT_NAME} ALL
	DEPENDS ${PROJECT_NAME}.stamp)
