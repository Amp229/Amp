# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/type_traits
    REF boost-1.77.0
    SHA512 3509a752e476ebcd19a7f17d3f7b709df82459659ab91976e5979fdfa14726d2840e7e59a50d47b3b489f86fb44153def13e0e009bfa0db33c1f6ed4e952f1b5
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
