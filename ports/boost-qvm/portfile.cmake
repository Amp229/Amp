# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/qvm
    REF boost-1.78.0
    SHA512 904a640ca479b94ae5da1d57bd40f6845e281f5a47b26a884c51b9fa3fff7d385fe89104a53cf2e4a59b0190fea83d89a895293609b41481dc38df26d8bee9c4
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
