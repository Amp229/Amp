# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/static_string
    REF boost-1.75.0
    SHA512 d3d0326250743783434c57d9c5c9f60c195978be862fa9bf377952385b06ce44f236f63c1423c5267b093ba28ac3aef74a4fd8e012bfb2f30620afc5e16cafbd
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
