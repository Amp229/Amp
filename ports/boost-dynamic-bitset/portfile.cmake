# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/dynamic_bitset
    REF boost-1.77.0
    SHA512 dcabd09d66003a7ff306d26f37399281bb2516021f76a1bc1960ef3bbfcf89767d1638fe69b237108aab165d45887468c5a34bb1016852f7277397ca965b6a3b
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
