vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO "christophercrouzet/rexo"
    REF "v0.2.1"
    SHA512 "746072d691adade7fa69a7ee35becd812164a4698048b06824ca801c175801f78dda3c4b986d68c4ff060636603c353f90ee10eb58e8ea53ac5467c87b65e593"
    HEAD_REF "main"
)

vcpkg_configure_cmake(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DREXO_BUILD_TESTS=OFF
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/Rexo)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")
configure_file("${SOURCE_PATH}/UNLICENSE" "${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright" COPYONLY)
