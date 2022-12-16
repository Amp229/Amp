IF (NOT VCPKG_CMAKE_SYSTEM_NAME)
    SET(EXEC_ENV "Windows")
ELSE ()
    SET(EXEC_ENV "${VCPKG_CMAKE_SYSTEM_NAME}")
ENDIF ()

IF (NOT VCPKG_TARGET_IS_LINUX)
    MESSAGE(FATAL_ERROR "Intel(R) Multi-Buffer Crypto for IPsec Library currently only supports Linux/Windows platforms")
    MESSAGE(STATUS "Well, it is not true, but I didnt manage to get it working on Windows")
ENDIF ()

IF (VCPKG_TARGET_ARCHITECTURE STREQUAL "x86" OR VCPKG_TARGET_ARCHITECTURE STREQUAL "arm")
    MESSAGE(FATAL_ERROR "Intel(R) Multi-Buffer Crypto for IPsec Library currently only supports x64 architecture")
ELSEIF (NOT VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
    MESSAGE(FATAL_ERROR "Unsupported architecture: ${VCPKG_TARGET_ARCHITECTURE}")
ENDIF ()

VCPKG_FROM_GITHUB(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO spdk/intel-ipsec-mb
    REF spdk
    SHA512 037fc382d9aa87b6645309f29cb761a584ed855c583638c9e27b5b7200ceb2ae21ad5adcc7c92b2b1d1387186a7fd2b5ae22f337a8f52dea3f6c35d8f90b42bd
    HEAD_REF master
)

VCPKG_FIND_ACQUIRE_PROGRAM(NASM)

execute_process(
    COMMAND "${NASM}" -v
    OUTPUT_VARIABLE NASM_OUTPUT
    ERROR_VARIABLE NASM_OUTPUT
)
STRING(REGEX REPLACE "NASM version ([0-9]+\\.[0-9]+\\.[0-9]+).*" "\\1" NASM_VERSION "${NASM_OUTPUT}")
IF (NASM_VERSION VERSION_LESS 2.13.03)
    MESSAGE(FATAL_ERROR "NASM version 2.13.03 (or newer) is required to build this package")
ENDIF ()

GET_FILENAME_COMPONENT(NASM_PATH ${NASM} DIRECTORY)
vcpkg_add_to_path("${NASM_PATH}")

VCPKG_CMAKE_CONFIGURE(
    SOURCE_PATH ${CMAKE_CURRENT_LIST_DIR}
    OPTIONS
        -DSOURCE_PATH=${SOURCE_PATH}
        -DEXEC_ENV=${VCPKG_CMAKE_SYSTEM_NAME}
)

VCPKG_CMAKE_INSTALL()

FILE(INSTALL ${SOURCE_PATH}/Release/lib/ DESTINATION ${CURRENT_PACKAGES_DIR}/lib/spdk)
if(NOT VCPKG_BUILD_TYPE)
    FILE(INSTALL ${SOURCE_PATH}/Debug/lib/ DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib/spdk)
endif()
FILE(INSTALL ${SOURCE_PATH}/Release/include/ DESTINATION ${CURRENT_PACKAGES_DIR}/include/${PORT})
FILE(INSTALL ${CMAKE_CURRENT_LIST_DIR}/spdk-ipsecConfig.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
FILE(INSTALL ${CMAKE_CURRENT_LIST_DIR}/usage DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
FILE(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
