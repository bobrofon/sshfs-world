cmake_minimum_required(VERSION 3.0.0)
project(openssl LANGUAGES NONE)

set(ROOT "${CMAKE_CURRENT_SOURCE_DIR}/../..")
if (NOT DEFINED PREFIX)
	set(PREFIX ${CMAKE_CURRENT_BINARY_DIR}/prefix)
endif()
set(TRASH ${CMAKE_CURRENT_BINARY_DIR}/trash)

file(GLOB_RECURSE SRC "${ROOT}/src/openssl/*")
file(GLOB MAIN_DIR "${ROOT}/src/openssl/*")

add_custom_command(OUTPUT ${PROJECT_NAME}-dir COMMAND mkdir -p ${PROJECT_NAME}-dir)

add_custom_command(
	OUTPUT ${PROJECT_NAME}.stamp
	DEPENDS ${SRC} ${PROJECT_NAME}-dir

	COMMAND cp -Rf ${MAIN_DIR} .
	COMMAND mkdir -p ${PREFIX}
	COMMAND mkdir -p ${TRASH}

	COMMAND
	./Configure
		no-shared
		--prefix=${TRASH}
		"$ENV{OS_COMPILER}"

	COMMAND make
	COMMAND make install_sw
	COMMAND mkdir -p ${PREFIX}/include
	COMMAND cp -Rf ${TRASH}/include/openssl ${PREFIX}/include

	COMMAND cmake -E touch ../${PROJECT_NAME}.stamp
	WORKING_DIRECTORY ${PROJECT_NAME}-dir
	VERBATIM
	)

add_custom_target(
	${PROJECT_NAME} ALL
	DEPENDS ${PROJECT_NAME}.stamp)
