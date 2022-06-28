# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/assert
    REF boost-1.79.0
    SHA512 fc7f97ca1d58fc5e7ef8ebe45239cdbec6b239afe7cb137aed629051a59c356d9bd82c2a9e0e6ce4c0e9b779cac8c68f1969910ca4b936ce15770083182e34d8
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
