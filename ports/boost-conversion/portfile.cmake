# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/conversion
    REF boost-1.78.0
    SHA512 0a3d649eccf90d3a2327139f236498dd11e49e308f30b559e7c91d955685eb859a76bb92d9cec6aa066dd898a35dc1c4cbfa60751db75331261f381bee1cc600
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
