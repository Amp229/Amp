# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/regex
    REF boost-1.82.0
    SHA512 f4bd05b47fa26c13dbb235f1ce937a4cd07fd39c3fed4cda5d86f13b528f6bb2345569294578ee2d58929f94d37c24ac4e766cd4049b532b2609ea60d045a4a4
    HEAD_REF master
    PATCHES 
        compat.diff
)

set(FEATURE_OPTIONS "")
boost_configure_and_install(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS ${FEATURE_OPTIONS}
)
