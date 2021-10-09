# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/variant
    REF boost-1.77.0
    SHA512 60c5f185c183a9d186ffa00d9809aed79ef60d5d2731ad36275a0e9a0a239b682878d3c00ba9760621eb817601c0ca848794c7f2c4f34bced4a4bbcf9e71c95c
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
