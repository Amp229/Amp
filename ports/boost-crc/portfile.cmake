# Automatically generated by boost-vcpkg-helpers/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/crc
    REF boost-1.73.0
    SHA512 7928d1541d2a7e19bde89e0351d7b0bb952faa40de0a744856bfe867e8830799b5e835d3278b064356dcf3930f749880110935348aafd0a5248926991ceb4307
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
