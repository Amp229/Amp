# Automatically generated by boost-vcpkg-helpers/generate-ports.ps1

include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/xpressive
    REF boost-1.71.0
    SHA512 a92b4718fcbc34e347f94c4b020acd077049cf1157b71f936ae7bc5848a0125ec9f53c3f2fef52168543a3b0b28a5fb0b4373f9c97d14be2cf9f119316be3110
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
