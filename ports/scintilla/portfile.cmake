vcpkg_fail_port_install(ON_TARGET "Linux" "OSX" "UWP")

vcpkg_download_distfile(ARCHIVE
  URLS "http://www.scintilla.org/scintilla423.zip"
  FILENAME "scintilla423.zip"
  SHA512 82a595782119ce5bb48c39f4cb9b29605c4cdc276f605ebd3e3b3ecae003ef2132102e21be8943c8b36ec40957e2e50f4ebc0086a5096901fa0e8e5e178db750
)
vcpkg_extract_source_archive_ex(
  OUT_SOURCE_PATH SOURCE_PATH
  ARCHIVE ${ARCHIVE}
  REF 4.2.3
)

if (VCPKG_LIBRARY_LINKAGE STREQUAL static)
  vcpkg_apply_patches(
    SOURCE_PATH ${SOURCE_PATH}
    PATCHES
      ${CMAKE_CURRENT_LIST_DIR}/0001-static-build.patch
  )
endif()

vcpkg_install_msbuild(
  SOURCE_PATH ${SOURCE_PATH}
  PROJECT_SUBPATH Win32/SciLexer.vcxproj
  INCLUDES_SUBPATH include
  LICENSE_SUBPATH License.txt
  ALLOW_ROOT_INCLUDES
)

vcpkg_copy_pdbs()