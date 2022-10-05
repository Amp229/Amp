set(SCRIPT_PATH "${CURRENT_INSTALLED_DIR}/share/qtbase")
include("${SCRIPT_PATH}/qt_install_submodule.cmake")

set(${PORT}_PATCHES
                    remove_unistd.patch
                    remove_export_macro.patch
)

#Maybe TODO: ALSA + PulseAudio? (Missing Ports) -> check ALSA since it was added

# qt_find_package(ALSA PROVIDED_TARGETS ALSA::ALSA MODULE_NAME multimedia QMAKE_LIB alsa)
# qt_find_package(AVFoundation PROVIDED_TARGETS AVFoundation::AVFoundation MODULE_NAME multimedia QMAKE_LIB avfoundation)
# qt_find_package(WrapPulseAudio PROVIDED_TARGETS WrapPulseAudio::WrapPulseAudio MODULE_NAME multimedia QMAKE_LIB pulseaudio)
# qt_find_package(WMF PROVIDED_TARGETS WMF::WMF MODULE_NAME multimedia QMAKE_LIB wmf)

# qt_configure_add_summary_section(NAME "Qt Multimedia")
# qt_configure_add_summary_entry(ARGS "alsa")
# qt_configure_add_summary_entry(ARGS "gstreamer_1_0")
# qt_configure_add_summary_entry(ARGS "linux_v4l")
# qt_configure_add_summary_entry(ARGS "pulseaudio")
# qt_configure_add_summary_entry(ARGS "mmrenderer")
# qt_configure_add_summary_entry(ARGS "avfoundation")
# qt_configure_add_summary_entry(ARGS "wmf")

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
FEATURES
    "qml"           CMAKE_REQUIRE_FIND_PACKAGE_Qt6Quick
    "widgets"       CMAKE_REQUIRE_FIND_PACKAGE_Qt6Widgets
INVERTED_FEATURES
    "qml"           CMAKE_DISABLE_FIND_PACKAGE_Qt6Quick
    "widgets"       CMAKE_DISABLE_FIND_PACKAGE_Qt6Widgets
    "gstreamer"     CMAKE_DISABLE_FIND_PACKAGE_GStreamer
    "ffmpeg"        CMAKE_DISABLE_FIND_PACKAGE_FFmpeg
    # Features not yet added in the manifest:
    "avfoundation"  CMAKE_DISABLE_FIND_PACKAGE_AVFoundation # not in vcpkg
    "vaapi"         CMAKE_DISABLE_FIND_PACKAGE_VAAPI # not in vpckg
)

if("gstreamer" IN_LIST FEATURES)
    list(APPEND FEATURE_OPTIONS "-DINPUT_gstreamer='yes'")
else()
    list(APPEND FEATURE_OPTIONS "-DINPUT_gstreamer='no'")
endif()

if("ffmpeg" IN_LIST FEATURES)
    # Note: Requires pulsadio on linux and wmfsdk on windows
    list(APPEND FEATURE_OPTIONS "-DINPUT_ffmpeg='yes'")
    if(VCPKG_TARGET_IS_WINDOWS)
        list(APPEND FEATURE_OPTIONS "-DFEATURE_wmf=ON")
        list(APPEND FEATURE_OPTIONS "-DINPUT_pulseaudio='no'")
    else()
        list(APPEND FEATURE_OPTIONS "-DINPUT_pulseaudio='yes'")
    endif()
else()
    list(APPEND FEATURE_OPTIONS "-DINPUT_ffmpeg='no'")
    list(APPEND FEATURE_OPTIONS "-DINPUT_pulseaudio='no'")
    list(APPEND FEATURE_OPTIONS "-DFEATURE_wmf=OFF")
endif()

# alsa is not ready
list(APPEND FEATURE_OPTIONS "-DFEATURE_alsa=OFF")

qt_install_submodule(PATCHES    ${${PORT}_PATCHES}
                     CONFIGURE_OPTIONS ${FEATURE_OPTIONS}
                                       -DCMAKE_FIND_PACKAGE_TARGETS_GLOBAL=ON
                     CONFIGURE_OPTIONS_RELEASE
                     CONFIGURE_OPTIONS_DEBUG
                    )
