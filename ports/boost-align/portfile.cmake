# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/align
    REF boost-${VERSION}
    SHA512 53774a2411f856112845469ce89a4b34bee6e7d13796764d1e6d397526747e4a7c798abd755f2eed5a48fe3c792e7bc8e0cc2418e8c6ee7f992fa98d73fc86c6
    HEAD_REF master
)

set(FEATURE_OPTIONS "")
boost_configure_and_install(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS ${FEATURE_OPTIONS}
)
