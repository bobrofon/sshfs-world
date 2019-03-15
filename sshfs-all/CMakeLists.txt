cmake_minimum_required(VERSION 3.0.0)
project(sshfs-all LANGUAGES NONE)

if (NOT DEFINED PREFIX)
	set(PREFIX ${CMAKE_CURRENT_BINARY_DIR}/prefix)
endif()

set(CMAKE_C_COMPILER gcc-static)

# TODO rewrite as packages
add_subdirectory(openssh)
add_subdirectory(sshfs)
add_subdirectory(glib)
add_subdirectory(zlib)
add_subdirectory(libffi)
add_subdirectory(openssl)
add_subdirectory(libfuse)

add_custom_target(
	${PROJECT_NAME} ALL
	DEPENDS
	${PREFIX}/bin/ssh
	${PREFIX}/bin/sshfs)

add_dependencies(${PROJECT_NAME} openssh sshfs)
add_dependencies(glib zlib libffi)
add_dependencies(openssh zlib openssl)
add_dependencies(sshfs libfuse glib)
