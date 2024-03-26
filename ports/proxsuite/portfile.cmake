set(VCPKG_BUILD_TYPE release) # header-only

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Simple-Robotics/proxsuite
    REF "v${VERSION}"
    SHA512 471f6ce375904e8ae6d4d78586461e01ea74d24329270b19d6c0c9c20554cba0e84bfdbd28dca4353c55ab10235159a02f3e8c4ffd584b82f6f681b688c524e8
    HEAD_REF main
)

vcpkg_from_github(
    OUT_SOURCE_PATH MODULES_SOURCE_PATH
    REPO jrl-umi3218/jrl-cmakemodules
    REF e1a71520cd2f0e6f2a611e1a70df4d8edf4d5a65
    SHA512 471f6ce375904e8ae6d4d78586461e01ea74d24329270b19d6c0c9c20554cba0e84bfdbd28dca4353c55ab10235159a02f3e8c4ffd584b82f6f681b688c524e8
    HEAD_REF master
)
file(REMOVE_RECURSE "${SOURCE_PATH}/cmake-module")
file(RENAME "${MODULES_SOURCE_PATH}" "${SOURCE_PATH}/cmake-module")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TESTING=OFF
        -DBUILD_WITH_VECTORIZATION_SUPPORT=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/${PORT}")
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
