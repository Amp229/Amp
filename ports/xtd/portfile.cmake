vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO gammasoft71/xtd
    REF 83f33454e496755076d13442ef9a2fe3323e7830
    SHA512 bf3b9ee8c429339304e0f8e80e8bbd85dd33686b5f0c1f655933de8f42a4ff5f695ba43fe0feb97edbd2518a17415b799ca425d99c30e8cfb7c7f6a3316ecd31
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DXTD_BUILD_TOOL_GUIDGEN_COMMAND_LINE=OFF
        -DXTD_BUILD_TOOL_GUIDGEN_GUI=OFF
        -DXTD_BUILD_TOOL_KEYCODES=OFF
        -DXTD_BUILD_TOOL_SLEEPFOR_COMMAND_LINE=OFF
        -DXTD_BUILD_TOOL_SET_PATH=OFF
        -DXTD_BUILD_TOOL_XTDC_COMMAND_LINE=OFF
        -DXTD_BUILD_TOOL_XTDC_GUI=OFF
        -DXTD_INSTALL_EXAMPLES=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "cmake")

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.md")
