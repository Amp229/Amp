# Automatically generated by boost-vcpkg-helpers/generate-ports.ps1

include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/lockfree
    REF boost-1.71.0
    SHA512 b7385d67291dcc2a9dc8b98e2ed31f43a203b74c3d2a8a9247b4c1c18545285a04abc17fd3204e6189f1629932da028ac81c263b4a283451cefec85821c9708e
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
