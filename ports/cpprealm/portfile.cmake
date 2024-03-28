vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO realm/realm-cpp
        REF "v${VERSION}"
        SHA512 059c5e39e5204e5ebcdd727c74b4001be44040df6804804fbba73455c36a7547fb2d07e035d8b694299b4d35fae29cc42305811f24160447810c6eaa2c6397ad
        HEAD_REF main
)

vcpkg_from_github(
        OUT_SOURCE_PATH REALM_CORE_SOURCE_PATH
        REPO realm/realm-core
        REF ffb40c857c6d666a8023d8384125c19841aa773d
        SHA512 7cc3a4ebb8ab77fbf0f349b876122ebdb84c96dfa360cc5d82750064959e4d663f17fdd3d9bde62162087d7aecedd59713fd044a3c791112260bfe97dd74e305
        HEAD_REF lm/msvc-arm
)

vcpkg_from_github(
        OUT_SOURCE_PATH CATCH2_SOURCE_PATH
        REPO catchorg/Catch2
        REF v3.5.3
        SHA512 57c996f679cbad212cb0fde39e506bade37bd559c0e93e20f407f2a2f029e98b78661e10257f9c8e4cb5fd7d52d0ea1eae3d4a1f989c6d66fcb281e32e1688f6
        HEAD_REF master
)

file(COPY ${REALM_CORE_SOURCE_PATH}/ DESTINATION ${SOURCE_PATH}/realm-core)
file(COPY ${CATCH2_SOURCE_PATH}/ DESTINATION ${SOURCE_PATH}/realm-core/external/catch)

if (NOT APPLE)
        vcpkg_from_github(
                OUT_SOURCE_PATH SHA1_SOURCE_PATH
                REPO clibs/sha1
                REF d9ae30f34095107ece9dceb224839f0dc2f9c1c7
                SHA512 2ed0ad05a6afb34dab4d21fada57369718e3a48113eea3e55e291ecaea36604c428ba9d2b702e9d01a8703eb06aa5d42895b8d197959ca8df18605ec52b1745e
                HEAD_REF master
        )
        file(COPY ${SHA1_SOURCE_PATH}/ DESTINATION ${SOURCE_PATH}/realm-core/src/external/sha-1)

        vcpkg_from_github(
                OUT_SOURCE_PATH SHA2_SOURCE_PATH
                REPO kalven/sha-2
                REF 0e9aebf34101c6aa89355fd76ac9cd886735dee1
                SHA512 0546188ad898fdd5b8f038a3e248e4d42c60c52a9d65939475352d5d45ca42444ee6efeb9eeca2deaf026d7b707db1cbe73ac0409700fbbebd01e90a8d02ecd9
                HEAD_REF master
        )
        file(COPY ${SHA2_SOURCE_PATH}/ DESTINATION ${SOURCE_PATH}/realm-core/src/external/sha-2)
endif()

set(CPPREALM_CMAKE_OPTIONS -DREALM_CPP_NO_TESTS=ON -DREALM_CORE_SUBMODULE_BUILD=OFF)

if (ANDROID OR WIN32 OR CMAKE_SYSTEM_NAME STREQUAL "Linux")
    list(APPEND CPPREALM_CMAKE_OPTIONS -DREALM_USE_SYSTEM_OPENSSL=ON)
endif()

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    DISABLE_PARALLEL_CONFIGURE
    OPTIONS
        ${CPPREALM_CMAKE_OPTIONS}
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(PACKAGE_NAME "cpprealm" CONFIG_PATH "cmake")
vcpkg_cmake_config_fixup(PACKAGE_NAME "realm" CONFIG_PATH "share/cmake/Realm")

file(READ ${CURRENT_PACKAGES_DIR}/debug/include/cpprealm/internal/bridge/bridge_types.hpp DEBUG_TYPE_HEADER_CONTENTS)
set(REGEX_PATTERN "\\{([^()]*)\\}")
string(REGEX MATCHALL "${REGEX_PATTERN}" MATCHED_CONTENT "${DEBUG_TYPE_HEADER_CONTENTS}")
set(MATCHED_DEBUG_TYPE_HEADER_CONTENTS "${CMAKE_MATCH_1}")

file(READ ${CURRENT_PACKAGES_DIR}/include/cpprealm/internal/bridge/bridge_types.hpp RELEASE_TYPE_HEADER_CONTENTS)
set(REGEX_PATTERN "\\{([^()]*)\\}")
string(REGEX MATCHALL "${REGEX_PATTERN}" MATCHED_CONTENT "${RELEASE_TYPE_HEADER_CONTENTS}")
set(MATCHED_RELEASE_TYPE_HEADER_CONTENTS "${CMAKE_MATCH_1}")

string(REGEX REPLACE "\\{([^()]*)\\}" "
{
        #ifdef REALM_DEBUG
        ${MATCHED_DEBUG_TYPE_HEADER_CONTENTS}
        #else
        ${MATCHED_RELEASE_TYPE_HEADER_CONTENTS}
        #endif
}
    " MODIFIED_HEADER "${DEBUG_TYPE_HEADER_CONTENTS}")

file(WRITE ${CURRENT_PACKAGES_DIR}/include/cpprealm/internal/bridge/bridge_types.hpp "${MODIFIED_HEADER}")

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
    "${CURRENT_PACKAGES_DIR}/debug/doc"
    "${CURRENT_PACKAGES_DIR}/doc"
)

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
