find_package(PkgConfig REQUIRED)
if(CHANNEL_URBDRC)
    pkg_check_modules(vcpkg_libusb REQUIRED libusb-1.0)
    set(LIBUSB_1_INCLUDE_DIRS "${vcpkg_libusb_INCLUDE_DIRS}")
    set(LIBUSB_1_LIBRARIES "${vcpkg_libusb_LINK_LIBRARIES}")
endif()
