vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO harfbuzz/harfbuzz
    REF 3.2.0
    SHA512 5d8c629416c0bc557b83e8d9d731d41b9e8ee3abc74590e65ed6ca67d74d3a440d038134313f17a7b1b14ef0fc1ecf8bb87113fdcf5f0c8d3dc3d2eeb9b08c18
    HEAD_REF master
    PATCHES
        # This patch is a workaround that is needed until the following issues are resolved upstream:
        # - https://github.com/mesonbuild/meson/issues/8375
        # - https://github.com/harfbuzz/harfbuzz/issues/2870
        # Details: https://github.com/microsoft/vcpkg/issues/16262
        0001-circumvent-samefile-error.patch
        0002-fix-uwp-build.patch
        fix-macos-build.diff # fixes https://github.com/harfbuzz/harfbuzz/issues/3484
)

if("icu" IN_LIST FEATURES)
    list(APPEND FEATURE_OPTIONS -Dicu=enabled) # Enable ICU library unicode functions
else()
    list(APPEND FEATURE_OPTIONS -Dicu=disabled)
endif()
if("graphite2" IN_LIST FEATURES)
    list(APPEND FEATURE_OPTIONS -Dgraphite=enabled) #Enable Graphite2 complementary shaper
else()
    list(APPEND FEATURE_OPTIONS -Dgraphite=disabled)
endif()
if("coretext" IN_LIST FEATURES)
    list(APPEND FEATURE_OPTIONS -Dcoretext=enabled) # Enable CoreText shaper backend on macOS
    if(NOT VCPKG_TARGET_IS_OSX)
        message(FATAL_ERROR "Feature 'coretext' os only available on OSX")
    endif()
else()
    list(APPEND FEATURE_OPTIONS -Dcoretext=disabled)
endif()
if("glib" IN_LIST FEATURES)
    list(APPEND FEATURE_OPTIONS -Dglib=enabled) # Enable GLib unicode functions
    list(APPEND FEATURE_OPTIONS -Dgobject=enabled) #Enable GObject bindings
else()
    list(APPEND FEATURE_OPTIONS -Dglib=disabled)
    list(APPEND FEATURE_OPTIONS -Dgobject=disabled)
endif()
list(APPEND FEATURE_OPTIONS -Dfreetype=enabled) #Enable freetype interop helpers
#if(VCPKG_TARGET_IS_WINDOWS)
    #link errors in qt5-base. probably requires changes to the pc files generated by meson
    #list(APPEND FEATURE_OPTIONS -Dgdi=enabled) # enable gdi helpers and uniscribe shaper backend (windows only)
#endif()


vcpkg_configure_meson(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS ${FEATURE_OPTIONS}
        -Dcairo=disabled # Use Cairo graphics library
        -Dintrospection=disabled # Generate gobject-introspection bindings (.gir/.typelib files)
        -Ddocs=disabled          # Generate documentation with gtk-doc
        -Dtests=disabled
        -Dbenchmark=disabled
    ADDITIONAL_NATIVE_BINARIES  glib-genmarshal='${CURRENT_HOST_INSTALLED_DIR}/tools/glib/glib-genmarshal'
                                glib-mkenums='${CURRENT_HOST_INSTALLED_DIR}/tools/glib/glib-mkenums'
    ADDITIONAL_CROSS_BINARIES   glib-genmarshal='${CURRENT_HOST_INSTALLED_DIR}/tools/glib/glib-genmarshal'
                                glib-mkenums='${CURRENT_HOST_INSTALLED_DIR}/tools/glib/glib-mkenums'
)

vcpkg_install_meson()
vcpkg_copy_pdbs()
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/lib/cmake")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib/cmake")
configure_file("${CMAKE_CURRENT_LIST_DIR}/harfbuzzConfig.cmake.in"
        "${CURRENT_PACKAGES_DIR}/share/${PORT}/harfbuzzConfig.cmake" @ONLY)

# Handle copyright
file(INSTALL "${SOURCE_PATH}/COPYING" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)

if("glib" IN_LIST FEATURES)
    list(APPEND TOOL_NAMES hb-subset hb-shape hb-ot-shape-closure)
endif()
if(TOOL_NAMES)
    vcpkg_copy_tools(TOOL_NAMES ${TOOL_NAMES} AUTO_CLEAN)
endif()

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin" "${CURRENT_PACKAGES_DIR}/debug/bin")
endif()
