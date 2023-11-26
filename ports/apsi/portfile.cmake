vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO microsoft/APSI
    REF "v${VERSION}"
    SHA512 ad49e169970921175728705c6f5fe8062e74900a601ea25e9f836840a221175bfbb3169717787b1ca7e2e1a0b26630690dcef9bc91c0123877b856ea927e9e68
    HEAD_REF main
    PATCHES
        fix-find-seal.patch
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        log4cplus APSI_USE_LOG4CPLUS
        zeromq APSI_USE_ZMQ
)

set(CROSSCOMP_OPTIONS "")
if (VCPKG_CROSSCOMPILING)
    if (VCPKG_TARGET_ARCHITECTURE STREQUAL "arm64")
        set(CROSSCOMP_OPTIONS -DAPSI_FOURQ_ARM64_EXITCODE=0 -DAPSI_FOURQ_ARM64_EXITCODE__TRYRUN_OUTPUT='')
    endif()
    if (VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
        set(CROSSCOMP_OPTIONS -DAPSI_FOURQ_AMD64_EXITCODE=0 -DHAVE_AVX_EXTENSIONS_EXITCODE=0 -DHAVE_AVX2_EXTENSIONS_EXITCODE=1)
    endif() 
endif()

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DCMAKE_FIND_PACKAGE_PREFER_CONFIG=ON
        -DAPSI_BUILD_TESTS=OFF
        -DAPSI_BUILD_CLI=OFF
        ${FEATURE_OPTIONS}
        ${CROSSCOMP_OPTIONS}
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/APSI-0.11")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
