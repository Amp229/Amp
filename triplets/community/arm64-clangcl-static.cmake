set(VCPKG_TARGET_ARCHITECTURE arm64)
set(VCPKG_CRT_LINKAGE dynamic)
set(VCPKG_LIBRARY_LINKAGE static)
set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/../../scripts/toolchains/clangcl.cmake")
set(VCPKG_LOAD_VCVARS_ENV ON)

