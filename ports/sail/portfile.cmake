vcpkg_fail_port_install(ON_TARGET "UWP")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO HappySeaFox/sail
    REF v0.9.0-pre17
    SHA512 aeec7bbd491f57819688ddaf2e9509fd382024e8e66a5145a892067cb517e526515e580ba72ba9ee1b9f2eacbd2b7a850c80f989cbb23eb57c61082cf42532ce
    HEAD_REF master
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static" SAIL_STATIC)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"

    OPTIONS
        -DSAIL_STATIC=${SAIL_STATIC}
        -DSAIL_COMBINE_CODECS=ON
        -DSAIL_BUILD_EXAMPLES=OFF
        -DSAIL_BUILD_TESTS=OFF
)

vcpkg_cmake_install()

vcpkg_copy_pdbs()

# Remove duplicate files
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include
                    ${CURRENT_PACKAGES_DIR}/debug/share)

# Move cmake configs
vcpkg_cmake_config_fixup(PACKAGE_NAME sail       CONFIG_PATH lib/cmake/sail       DO_NOT_DELETE_PARENT_CONFIG_PATH)
vcpkg_cmake_config_fixup(PACKAGE_NAME sailcodecs CONFIG_PATH lib/cmake/sailcodecs DO_NOT_DELETE_PARENT_CONFIG_PATH)
vcpkg_cmake_config_fixup(PACKAGE_NAME sailcommon CONFIG_PATH lib/cmake/sailcommon DO_NOT_DELETE_PARENT_CONFIG_PATH)
vcpkg_cmake_config_fixup(PACKAGE_NAME sailc++    CONFIG_PATH lib/cmake/sailc++    DO_NOT_DELETE_PARENT_CONFIG_PATH)
vcpkg_cmake_config_fixup(PACKAGE_NAME sailmanip  CONFIG_PATH lib/cmake/sailmanip  DO_NOT_DELETE_PARENT_CONFIG_PATH)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib/cmake"
                    "${CURRENT_PACKAGES_DIR}/debug/lib/cmake")


# Fix pkg-config files
vcpkg_fixup_pkgconfig()

# Handle usage
file(COPY "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")


# Handle copyright
file(INSTALL "${SOURCE_PATH}/LICENSE.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
