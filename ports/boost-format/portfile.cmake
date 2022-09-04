# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/format
    REF boost-1.80.0
    SHA512 89dc4daf80d7663472839f66455c747c0944b336302a09be6bdf3e186956a703fe136e7e9c4d27b11cde7baf517f46b289ffaa6a1dd762e5c5810eb1470cf2c8
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
