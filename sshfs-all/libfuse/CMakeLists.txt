cmake_minimum_required(VERSION 3.0.0)
project(libfuse LANGUAGES NONE)

set(ROOT "${CMAKE_CURRENT_SOURCE_DIR}/../..")
if (NOT DEFINED PREFIX)
	set(PREFIX ${CMAKE_CURRENT_BINARY_DIR}/prefix)
endif()

file(GLOB_RECURSE SRC "${ROOT}/src/fuse/*")

add_custom_command(OUTPUT ${PROJECT_NAME}-dir COMMAND mkdir -p ${PROJECT_NAME}-dir)

add_custom_command(
	OUTPUT ${PROJECT_NAME}.stamp
	DEPENDS ${SRC} ${PROJECT_NAME}-dir

	COMMAND mkdir -p ${PREFIX}

	COMMAND
	CC=gcc-static
	meson
		--prefix=${PREFIX}
		--backend ninja
		--buildtype release
		--default-library static
		-D disable-mtab=true
		-D udevrulesdir=${ROOT}/src/fuse/util/udev.rules
		${ROOT}/src/fuse

	COMMAND ninja
	COMMAND cmake -E copy ${ROOT}/src/fuse/util/install_helper.sh install_helper.sh
	COMMAND echo "#! /bin/sh" > ${ROOT}/src/fuse/util/install_helper.sh
	COMMAND ninja install
	COMMAND cmake -E copy install_helper.sh ${ROOT}/src/fuse/util/install_helper.sh
	COMMAND cmake -E touch ../${PROJECT_NAME}.stamp
	WORKING_DIRECTORY ${PROJECT_NAME}-dir
	VERBATIM
	)

add_custom_target(
	${PROJECT_NAME} ALL
	DEPENDS ${PROJECT_NAME}.stamp)
