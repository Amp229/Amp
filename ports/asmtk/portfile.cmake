vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO asmjit/asmtk
  REF 425b108d3afe510f8b94ca5523cd31ae29381422 # accessed on 2022-11-06
  SHA512 d825f488c66dca9ca4c3279992e4ea36a4d1b7ad65fa3e0c70b151ce0d2b1f9b5ad053ff1d447da38475bf843fe3b130706e3c9916a64f76560add9c8d796a5b
  HEAD_REF master
)

set(ASMJIT_EXTERNAL ON)
set(ASMTK_EMBED OFF)
string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static" ASMTK_STATIC)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DASMTK_STATIC=${ASMTK_STATIC}
		-DASMJIT_EXTERNAL=${ASMJIT_EXTERNAL}
		-DASMTK_EMBED=${ASMTK_EMBED}
 )

vcpkg_cmake_install()
vcpkg_copy_pdbs()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/asmtk)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(INSTALL "${SOURCE_PATH}/LICENSE.md" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
