vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO mm2/Little-CMS
    REF "lcms${VERSION}"
    SHA512 c0d857123a0168cb76b5944a20c9e3de1cbe74e2b509fb72a54f74543e9c173474f09d50c495b0a0a295a3c2b47c5fa54a330d057e1a59b5a7e36d3f5a7f81b2
    HEAD_REF master
)

vcpkg_configure_meson(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_install_meson()

vcpkg_copy_pdbs()
vcpkg_fixup_pkgconfig()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
