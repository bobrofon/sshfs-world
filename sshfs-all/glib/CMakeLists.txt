cmake_minimum_required(VERSION 3.0.0)
project(glib LANGUAGES NONE)

set(ROOT "${CMAKE_CURRENT_SOURCE_DIR}/../..")
if (NOT DEFINED PREFIX)
	set(PREFIX ${CMAKE_CURRENT_BINARY_DIR}/prefix)
endif()
set(TRASH ${CMAKE_CURRENT_BINARY_DIR}/trash)

file(GLOB_RECURSE SRC "${ROOT}/src/glib/*")
file(GLOB MAIN_DIR "${ROOT}/src/glib/*")

add_custom_command(OUTPUT ${PROJECT_NAME}-dir COMMAND mkdir -p ${PROJECT_NAME}-dir)

add_custom_command(
	OUTPUT ${PROJECT_NAME}.stamp
	DEPENDS ${SRC} ${PROJECT_NAME}-dir

	COMMAND mkdir -p ${PREFIX}
	COMMAND mkdir -p ${TRASH}
	COMMAND cp -rf ${MAIN_DIR} .
	COMMAND NOCONFIGURE=1 ./autogen.sh

	COMMAND
	PKG_CONFIG_PATH=${PREFIX}/lib/pkgconfig
	./configure
		CC=gcc-static
		--prefix=${TRASH}
		--libdir=${PREFIX}/lib
		--includedir=${PREFIX}/include
		--host=$ENV{HOST}
		--enable-static
		--disable-shared
		--disable-man
		--disable-systemtap
		--with-pic
		--with-pcre=internal
		--disable-libmount

	COMMAND make
	COMMAND make install

	COMMAND cmake -E touch ../${PROJECT_NAME}.stamp
	WORKING_DIRECTORY ${PROJECT_NAME}-dir
	VERBATIM
	)

add_custom_target(
	${PROJECT_NAME} ALL
	DEPENDS ${PROJECT_NAME}.stamp)
