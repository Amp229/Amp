vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

if("public-preview" IN_LIST FEATURES)
    vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO Azure/azure-umqtt-c
        REF 7557db6de094b67818d3c410dc95a3cf07cd86a6
        SHA512 f2577379f711e2576fdd6dfecbc4d8a0b26c7670a77bc468238e8dd5fa43f208db85eddd06dd570fde4219ba19304338c712f671c059c6cc10abb4892d58ae40
        HEAD_REF master
    )
else()
    vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO Azure/azure-umqtt-c
        REF 28a3dd75f52c20621d21b77dc616469f9381edaf
        SHA512 b1dae1ac5ef5f125704773ad9a5c9a692ba0dab758fbdb39d95fea5e76fef715e413aa899b417a2d6a26fce6e98858c986ce466cde47acc326aadc8dcdcfeb9c
        HEAD_REF master
    )
endif()

file(COPY ${CURRENT_INSTALLED_DIR}/share/azure-c-shared-utility/azure_iot_build_rules.cmake DESTINATION ${SOURCE_PATH}/deps/c-utility/configs/)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -Dskip_samples=ON
        -Duse_installed_dependencies=ON
        -Dbuild_as_dynamic=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH cmake TARGET_PATH share/umqtt)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include ${CURRENT_PACKAGES_DIR}/debug/share)

configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)

vcpkg_copy_pdbs()
