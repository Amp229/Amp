vcpkg_check_linkage(ONLY_STATIC_LIBRARY)
vcpkg_minimum_required(VERSION 2022-10-12) # for ${VERSION}

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO mohabouje/WinToast
  REF "v${VERSION}"
  SHA512 b9e34595049851754dafe506681af494f59edf94a4324c20aaeadea25b9ed0abac87e93384d2080c327dbbdd22441800e9af7c5ce6728d7cc1464796a83cffbd
  HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DWINTOASTLIB_BUILD_EXAMPLES=OFF
        -DWINTOASTLIB_QT_ENABLED=OFF
)

vcpkg_cmake_build(TARGET WinToast)

# WinToast does not support CMake-based install; copy headers and libraries manually.
file(INSTALL "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/WinToast.lib" DESTINATION "${CURRENT_PACKAGES_DIR}/debug/lib")
file(INSTALL "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/WinToast.lib" DESTINATION "${CURRENT_PACKAGES_DIR}/lib")
file(INSTALL "${SOURCE_PATH}/include/wintoastlib.h" DESTINATION "${CURRENT_PACKAGES_DIR}/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")