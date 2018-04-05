cmake_minimum_required(VERSION 3.0.0)
project(libffi LANGUAGES NONE)

set(ROOT "${CMAKE_CURRENT_SOURCE_DIR}/../..")
if (NOT DEFINED PREFIX)
	set(PREFIX ${CMAKE_CURRENT_BINARY_DIR}/prefix)
endif()
set(TRASH ${CMAKE_CURRENT_BINARY_DIR}/trash)

file(GLOB_RECURSE SRC "${ROOT}/src/libffi/*")

add_custom_command(OUTPUT ${PROJECT_NAME}-dir COMMAND mkdir -p ${PROJECT_NAME}-dir)

add_custom_command(
	OUTPUT ${PROJECT_NAME}.stamp
	DEPENDS ${SRC} ${PROJECT_NAME}-dir

	COMMAND mkdir -p ${PREFIX}
	COMMAND mkdir -p ${TRASH}

	COMMAND
	${ROOT}/src/libffi/configure
		CC=gcc-static
		--prefix=${TRASH}
		--libdir=${PREFIX}/lib
		--includedir=${PREFIX}/include
		--host=$ENV{HOST}
		--enable-static
		--disable-shared
		--enable-portable-binary
		--disable-docs
		--with-pic

	COMMAND make
	COMMAND make install

	COMMAND cmake -E touch ../${PROJECT_NAME}.stamp
	WORKING_DIRECTORY ${PROJECT_NAME}-dir
	VERBATIM
	)

add_custom_target(
	${PROJECT_NAME} ALL
	DEPENDS ${PROJECT_NAME}.stamp)
