cmake_minimum_required(VERSION 3.5)
project(zlib LANGUAGES C)

include(ExternalProject)

ExternalProject_Add(${PROJECT_NAME}
	SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../../src/${PROJECT_NAME}"
	CONFIGURE_COMMAND
		CC=${CMAKE_C_COMPILER}
		"<SOURCE_DIR>/configure"
			--prefix="<TMP_DIR>"
			--sharedlibdir="<TMP_DIR>"
			--libdir="<INSTALL_DIR>/lib"
			--includedir="<INSTALL_DIR>/include"
			--const
			--static
	BUILD_COMMAND make
	INSTALL_COMMAND make install
)
