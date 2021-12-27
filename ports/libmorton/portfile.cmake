vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Forceflow/libmorton
    REF v0.2.8
    SHA512 7497203573965337F1216DB729D3F6806278B8DDFF539E8D01EF83FB3EAB50D5FF90C965CF5EA3A76464CF6F279C000434D2111B37D3D368834F7EF20959E790
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS 
        -DBUILD_TESTING=OFF
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH share/cmake/libmorton)
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)