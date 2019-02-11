cmake_minimum_required(VERSION 3.0.0)
project(sshfs-world LANGUAGES NONE)

set(STABLE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/stable)

file(GLOB_RECURSE SRC ${CMAKE_CURRENT_SOURCE_DIR}/src/*)
file(GLOB_RECURSE UNIVERSE ${CMAKE_CURRENT_SOURCE_DIR}/build-universe/*)
file(GLOB_RECURSE BUILD_FILES ${CMAKE_CURRENT_SOURCE_DIR}/sshfs-all/*)

set(RUN ${CMAKE_CURRENT_SOURCE_DIR}/build-universe/run.sh)
set(ARM arm-unknown-linux-gnueabi)
set(AARCH64 aarch64-unknown-linux-gnueabi)
set(I686 i686-unknown-linux-gnu)
set(X86_64 x86_64-unknown-linux-gnu)

add_custom_command(OUTPUT arm-dir COMMAND mkdir -p arm-dir)
add_custom_command(OUTPUT aarch64-dir COMMAND mkdir -p aarch64-dir)
add_custom_command(OUTPUT i686-dir COMMAND mkdir -p i686-dir)
add_custom_command(OUTPUT x86_64-dir COMMAND mkdir -p x86_64-dir)
add_custom_command(
	OUTPUT arm-container.stamp
	COMMAND ./build.sh arm
	COMMAND cmake -E touch ${CMAKE_CURRENT_BINARY_DIR}/arm-container.stamp
	WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/build-universe
	)
add_custom_command(
	OUTPUT aarch64-container.stamp
	COMMAND ./build.sh aarch64
	COMMAND cmake -E touch ${CMAKE_CURRENT_BINARY_DIR}/aarch64-container.stamp
	WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/build-universe
	)
add_custom_command(
	OUTPUT i686-container.stamp
	COMMAND ./build.sh i686
	COMMAND cmake -E touch ${CMAKE_CURRENT_BINARY_DIR}/i686-container.stamp
	WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/build-universe
	)
add_custom_command(
	OUTPUT x86_64-container.stamp
	COMMAND ./build.sh x86_64
	COMMAND cmake -E touch ${CMAKE_CURRENT_BINARY_DIR}/x86_64-container.stamp
	WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/build-universe
	)

add_custom_command(
	OUTPUT ${STABLE_DIR}/arm/ssh ${STABLE_DIR}/arm/sshfs
	DEPENDS ${SRC} ${UNIVERSE} ${BUILD_FILES} arm-dir arm-container.stamp

	COMMAND ${RUN} ${ARM} cmake ${CMAKE_CURRENT_SOURCE_DIR}/sshfs-all
	COMMAND ${RUN} ${ARM} make
	COMMAND cp prefix/bin/ssh prefix/bin/sshfs ${STABLE_DIR}/arm/

	WORKING_DIRECTORY arm-dir
	VERBATIM
	)
add_custom_command(
	OUTPUT ${STABLE_DIR}/aarch64/ssh ${STABLE_DIR}/aarch64/sshfs
	DEPENDS ${SRC} ${UNIVERSE} ${BUILD_FILES} aarch64-dir aarch64-container.stamp

	COMMAND ${RUN} ${AARCH64} cmake ${CMAKE_CURRENT_SOURCE_DIR}/sshfs-all
	COMMAND ${RUN} ${AARCH64} make
	COMMAND cp prefix/bin/ssh prefix/bin/sshfs ${STABLE_DIR}/aarch64/

	WORKING_DIRECTORY aarch64-dir
	VERBATIM
	)
add_custom_command(
	OUTPUT ${STABLE_DIR}/i686/ssh ${STABLE_DIR}/i686/sshfs
	DEPENDS ${SRC} ${UNIVERSE} ${BUILD_FILES} i686-dir i686-container.stamp

	COMMAND ${RUN} ${I686} cmake ${CMAKE_CURRENT_SOURCE_DIR}/sshfs-all
	COMMAND ${RUN} ${I686} make
	COMMAND cp prefix/bin/ssh prefix/bin/sshfs ${STABLE_DIR}/i686/

	WORKING_DIRECTORY i686-dir
	VERBATIM
	)
add_custom_command(
	OUTPUT ${STABLE_DIR}/x86_64/ssh ${STABLE_DIR}/x86_64/sshfs
	DEPENDS ${SRC} ${UNIVERSE} ${BUILD_FILES} x86_64-dir x86_64-container.stamp

	COMMAND ${RUN} ${X86_64} cmake ${CMAKE_CURRENT_SOURCE_DIR}/sshfs-all
	COMMAND ${RUN} ${X86_64} make
	COMMAND cp prefix/bin/ssh prefix/bin/sshfs ${STABLE_DIR}/x86_64/

	WORKING_DIRECTORY x86_64-dir
	VERBATIM
	)

add_custom_target(
	${PROJECT_NAME} ALL
	DEPENDS
		${STABLE_DIR}/arm/ssh ${STABLE_DIR}/arm/sshfs
		${STABLE_DIR}/aarch64/ssh ${STABLE_DIR}/aarch64/sshfs
		${STABLE_DIR}/i686/ssh ${STABLE_DIR}/i686/sshfs
		${STABLE_DIR}/x86_64/ssh ${STABLE_DIR}/x86_64/sshfs
	)
