cmake_minimum_required(VERSION 3.0.0)
project(zlib LANGUAGES NONE)

set(ROOT "${CMAKE_CURRENT_SOURCE_DIR}/../..")
if (NOT DEFINED PREFIX)
	set(PREFIX ${CMAKE_CURRENT_BINARY_DIR}/prefix)
endif()
set(TRASH ${CMAKE_CURRENT_BINARY_DIR}/trash)

file(GLOB_RECURSE SRC "${ROOT}/src/zlib/*")

add_custom_command(OUTPUT ${PROJECT_NAME}-dir COMMAND mkdir -p ${PROJECT_NAME}-dir)

add_custom_command(
	OUTPUT ${PROJECT_NAME}.stamp
	DEPENDS ${SRC} ${PROJECT_NAME}-dir

	COMMAND mkdir -p ${PREFIX}
	COMMAND mkdir -p ${TRASH}

	COMMAND
	CC=gcc-static
	${ROOT}/src/zlib/configure
		--prefix=${TRASH}
		--sharedlibdir=${TRASH}
		--libdir=${PREFIX}/lib
		--includedir=${PREFIX}/include
		--const
		--static

	COMMAND make
	COMMAND make install

	COMMAND cmake -E touch ../${PROJECT_NAME}.stamp
	WORKING_DIRECTORY ${PROJECT_NAME}-dir
	VERBATIM
	)

add_custom_target(
	${PROJECT_NAME} ALL
	DEPENDS ${PROJECT_NAME}.stamp)
