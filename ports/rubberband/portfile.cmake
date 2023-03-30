vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO breakfastquay/rubberband
    REF "v${VERSION}"
    SHA512 953d705e4a69ed40732644b8039dae02ddf596216e484ce8625fdde796e0de35fe6ac6c4f180eabc457c98b63c3fba212afa74b731eac570bea1902b667f506f
    HEAD_REF default
)


if("cli" IN_LIST FEATURES)
    set(CLI_FEATURE enabled)
else()    
    set(CLI_FEATURE disabled)
endif()

vcpkg_configure_meson(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -Dfft=fftw                 # 'auto', 'builtin', 'kissfft', 'fftw', sleef', 'vdsp', 'ipp' 'FFT library to use. The default (auto) will use vDSP if available, the builtin implementation otherwise.')
        -Dresampler=libsamplerate  # 'auto', 'builtin', 'libsamplerate', 'speex', 'libspeexdsp', 'ipp' 'Resampler library to use. The default (auto) simply uses the builtin implementation.'
        -Dipp_path=                # 'Path to Intel IPP libraries, if selected for any of the other options.'
        -Dextra_include_dirs=      # 'Additional local header directories to search for dependencies.'
        -Dextra_lib_dirs=          # 'Additional local library directories to search for dependencies.'
        -Djni=disabled             # 'auto', 'disabled', 'enabled'
        -Dladspa=disabled          # 'auto', 'disabled', 'enabled'
        -Dlv2=disabled             # 'auto', 'disabled', 'enabled' lv2 feature is not yet supported yet because vcpkg can't isntall to 
                                   # %APPDATA%\LV2 or %COMMONPROGRAMFILES%\LV2 but also complains about dlls in "${CURRENT_PACKAGES_DIR}/lib/lv2"
        -Dvamp=disabled           # 'auto', 'disabled', 'enabled'
        -Dcmdline=${CLI_FEATURE}   # 'auto', 'disabled', 'enabled'
        -Dtests=disabled           # 'auto', 'disabled', 'enabled'
    )

vcpkg_install_meson()

vcpkg_fixup_pkgconfig()
vcpkg_copy_pdbs()

if(EXISTS "${CURRENT_PACKAGES_DIR}/bin/rubberband-program${VCPKG_TARGET_EXECUTABLE_SUFFIX}")
  # Rubberband uses a different executable name when compiled with msvc
  # Just looking for that file is faster than detecting msvc builds
  set(RUBBERBAND_PROGRAM_NAMES rubberband-program rubberband-program-r3)
else()
  set(RUBBERBAND_PROGRAM_NAMES rubberband rubberband-r3)
endif()

# Remove them when not enabled.
if("cli" IN_LIST FEATURES)
  vcpkg_copy_tools(TOOL_NAMES ${RUBBERBAND_PROGRAM_NAMES} AUTO_CLEAN)
endif()

file(
  INSTALL "${SOURCE_PATH}/COPYING"
  DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
  RENAME copyright
)
