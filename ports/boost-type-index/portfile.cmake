# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/type_index
    REF boost-1.82.0
    SHA512 28b71480a83f57cfb816042e2d56f21afa870f61f617367c82753e57485ca502817dd5cb3f194a163f3b648e38be8fee4d2f80f2df9a534cc76d24791ade2580
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
