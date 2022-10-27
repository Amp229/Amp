IF (NOT VCPKG_CMAKE_SYSTEM_NAME OR NOT VCPKG_CMAKE_SYSTEM_NAME STREQUAL "Linux")
    MESSAGE(FATAL_ERROR "Intel dpdk currently only supports Linux/BSD platforms")
ENDIF ()

VCPKG_FROM_GITHUB(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO spdk/dpdk
        REF spdk-18.11
        SHA512 9c069bb0e445f8287ee056452fa32263746f78e27377e8fd75809b9ebf7f25c2395ee13ae4804d8c464e5bc7db7335692759ab3202748dd0c82243aad35e5e7c
        HEAD_REF master
)

VCPKG_CONFIGURE_CMAKE(
        SOURCE_PATH ${CMAKE_CURRENT_LIST_DIR}
        PREFER_NINJA
        OPTIONS
        -DSOURCE_PATH=${SOURCE_PATH}
)

VCPKG_INSTALL_CMAKE()

# Headers are symbolic links here, gather all, resolve and copy real files
FILE(GLOB_RECURSE HEADERS FOLLOW_SYMLINKS "${SOURCE_PATH}/build/include/*")
SET(REAL_FILES "")
FOREACH (HEADER ${HEADERS})
    GET_FILENAME_COMPONENT(REAL_FILE "${HEADER}" REALPATH)
    LIST(APPEND REAL_FILES "${REAL_FILE}")
ENDFOREACH ()

FILE(INSTALL ${SOURCE_PATH}/Release/lib/ DESTINATION ${CURRENT_PACKAGES_DIR}/lib/spdk)
FILE(INSTALL ${SOURCE_PATH}/Debug/lib/ DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib/spdk)
FILE(INSTALL ${REAL_FILES} DESTINATION ${CURRENT_PACKAGES_DIR}/include/${PORT})
FILE(INSTALL ${CMAKE_CURRENT_LIST_DIR}/spdk-dpdkConfig.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
FILE(INSTALL ${CMAKE_CURRENT_LIST_DIR}/usage DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
FILE(INSTALL ${SOURCE_PATH}/license/README DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
