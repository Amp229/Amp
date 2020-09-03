include(FindPackageHandleStandardArgs)
include(SelectLibraryConfigurations)


find_path(PCRE_INCLUDE_DIR pcre.h)
find_library(PCRE_LIBRARY_DEBUG NAMES pcred NAMES_PER_DIR PATH_SUFFIXES lib PATHS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug" NO_DEFAULT_PATH REQUIRED)
find_library(PCRE_LIBRARY_RELEASE NAMES pcre NAMES_PER_DIR PATH_SUFFIXES lib PATHS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}" NO_DEFAULT_PATH REQUIRED)

select_library_configurations(PCRE)

set(PCRE_INCLUDE_DIRS ${PCRE_INCLUDE_DIR})
set(PCRE_LIBRARIES ${PCRE_LIBRARY})
