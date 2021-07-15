vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO CrowCpp/crow
    REF 6a1623b69c5f788b1ea248f0046634fa1e7b0e03 #0.3+1
    SHA512 6c3e1e89e0f0ea9dcbe9206071189ad692c34400b1a3e101002e9bd97729851db94a40ce45b8fc9aa747df409cfdbdbdf09af806361d1e7df6f515f4c50e7a80
    HEAD_REF master
)

file(INSTALL ${SOURCE_PATH}/include/ DESTINATION ${CURRENT_PACKAGES_DIR}/include)
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
