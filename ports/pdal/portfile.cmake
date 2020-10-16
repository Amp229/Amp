set(PDAL_VERSION_STR "2.2.0")

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/PDAL/PDAL/releases/download/${PDAL_VERSION_STR}/PDAL-${PDAL_VERSION_STR}-src.tar.gz"
    FILENAME "PDAL-${PDAL_VERSION_STR}-src.tar.gz"
    SHA512 c54770973de714473bf6cfe6a69e2c880d516abcf71cce755495304093acb41471b4264cb84f11973a482f3de80a8922d7d8b54994fb91c6b012a6894a8bdac5
)

vcpkg_extract_source_archive_ex(
    ARCHIVE ${ARCHIVE}
    OUT_SOURCE_PATH SOURCE_PATH
    PATCHES
        reimplement-patch-172-in-220.patch
        fix-CPL_DLL.patch
)

# file(REMOVE "${SOURCE_PATH}/pdal/gitsha.h")

# Deploy custom CMake modules to enforce expected dependencies look-up
foreach(_module IN ITEMS FindGDAL FindGeoTIFF FindCurl)  # Outdated; Supplied by CMake
    file(REMOVE "${SOURCE_PATH}/cmake/modules/${_module}.cmake")
endforeach()

if(VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
  set(VCPKG_BUILD_SHARED_LIBS ON)
  set(VCPKG_BUILD_STATIC_LIBS OFF)
else()
  set(VCPKG_BUILD_SHARED_LIBS OFF)
  set(VCPKG_BUILD_STATIC_LIBS ON)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DPDAL_BUILD_STATIC:BOOL=${VCPKG_BUILD_STATIC_LIBS}
        -DWITH_TESTS:BOOL=OFF
        -DWITH_COMPLETION:BOOL=OFF
)

vcpkg_install_cmake(ADD_BIN_TO_PATH)
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/pdal)
vcpkg_copy_pdbs()

# Install PDAL executable
file(GLOB _pdal_apps ${CURRENT_PACKAGES_DIR}/bin/*.exe)
file(COPY ${_pdal_apps} DESTINATION ${CURRENT_PACKAGES_DIR}/tools/pdal)
file(REMOVE ${_pdal_apps})
vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/${PORT})

# Post-install clean-up
file(REMOVE_RECURSE
    ${CURRENT_PACKAGES_DIR}/lib/pdal
    ${CURRENT_PACKAGES_DIR}/debug/lib/pdal
    ${CURRENT_PACKAGES_DIR}/debug/include
    ${CURRENT_PACKAGES_DIR}/debug/share

    # These are intentionally? empty
    ${CURRENT_PACKAGES_DIR}/include/pdal/filters/private/csf
    ${CURRENT_PACKAGES_DIR}/include/pdal/filters/private/miniball
)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/a/dir" "${CURRENT_PACKAGES_DIR}/some/other/dir")

if(VCPKG_LIBRARY_LINKAGE STREQUAL static)
    file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/bin)
else()
    file(GLOB _pdal_bats ${CURRENT_PACKAGES_DIR}/bin/*.bat)
    file(REMOVE ${_pdal_bats})
    file(GLOB _pdal_bats ${CURRENT_PACKAGES_DIR}/debug/bin/*.bat)
    file(REMOVE ${_pdal_bats})
    file(GLOB _pdal_apps ${CURRENT_PACKAGES_DIR}/debug/bin/*.exe)
    file(REMOVE ${_pdal_apps})
endif()

file(INSTALL ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
