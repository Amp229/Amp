#Every update requires an update of these hashes and the version within the control file of each of the 32 ports. 
#So it is probably better to have a central location for these hashes and let the ports update via a script
set(QT_MAJOR_MINOR_VER 5.12)
set(QT_PATCH_VER 5)
set(QT_UPDATE_VERSION 1)

set(QT_PORT_LIST base 3d activeqt charts connectivity datavis3d declarative gamepad graphicaleffects imageformats location macextras mqtt multimedia networkauth
                 purchasing quickcontrols quickcontrols2 remoteobjects script scxml sensors serialport speech svg tools virtualkeyboard webchannel websockets
                 webview winextras xmlpatterns)

set(QT_HASH_qt5-base                9a95060318cadfcd6dace6b28353fa868a8dcfe9def0bd884edf7d9f72606bae625de0269323a94b81d594a6c398106c266304106329b79c7dae4e5b88269660)
set(QT_HASH_qt5-3d                  aa93d3661d092dc020e7903242964b7daba1e42882deb0d5fd45abff3c11e971f49a497ae5a1b7420fd497e6986daca4da0a217c94821ef8432cc3d8c617d291)
set(QT_HASH_qt5-activeqt            1a1560424ed8f6075ffe371efaff63ae9aa52377aa84f806a39d7e995960a7d7eeb1eb575470b13569293d2623c5e247204397d8b6698c1ce2ff9f206850a912)
set(QT_HASH_qt5-charts              d9c46f59d15377098427647cbd3c3fc2d7ff33fb9940581360db3be5e895b50bee0fe23a41c0af6b157e905b04b1bc13666c1736b047a405b21aab3a2bdbe60b)
set(QT_HASH_qt5-connectivity        e1076c5883f29cb394d9929a52c3bfce97952cef11b1f82d1fcca59440354d1a29ab19d628f6359ca02f3318fb526b3ca78d691af6dc0f4c06741b2306c8e571)
set(QT_HASH_qt5-datavis3d           e5041e4b666fa4e7ce8b12fd522be3ace144b43bf68fa2d45add67dfc6afc6e5788c5fac5eed81e9fa631cf6d372ce0aed8287fa139488406612322e5fd7e550)
set(QT_HASH_qt5-declarative         953b0dac76b73a7a21b393ab88718da12d77dfc688dc07c55c96ea1658bc14acd9097bef60df4a95d2923d3fb1e02b46499c032aa53844d4fd344b0037514671)
set(QT_HASH_qt5-gamepad             e84e637e3b2ced01e92ceb2b54b829a1e2346a4c96b15044f59bcc9764a24c91df6fcd0165f454143cfad87c05471b7d84567d9c6ea8fd3b4c753e5e771e8947)
set(QT_HASH_qt5-graphicaleffects    fe78cb01cfbe00226709a7faa2e754abb8e41bd677d15611221fbb9e53bf876e60d244eb6660b6b03403d31be2d9155a763ad34e4c4d2d1490fa6810f54bad0c)
set(QT_HASH_qt5-imageformats        e9adab3b7e1f5a0679e1924eb08718f2c6c53073f83018c9243886f7e1b084940bb9a642f46d76fae21552c4a76c655482536ae873cd4cfead4876a3561ebe8f)
set(QT_HASH_qt5-location            b03380feb2e6767dabb0a75f9234c52a9adc580d53b692c356b04293195f6cdd49d9c7e8eb91404b5a7e4c7507498078dd8f41de014330d35f0e99e034b8cf3a)
set(QT_HASH_qt5-macextras           813b26a95e0ab7119e3f6341052d08d6b401713cc914fd9a8a43675be21d87135f3ed7538edceec68d16e6cb3eb0042351083b545624e18ea217c23a105185e4)
set(QT_HASH_qt5-mqtt                f2c254947d767e30a8ba683ef8f4c14e6aad911cd887e675abadf0f315771b62adababab3831d7712e09a953d9b7e95df6db0f3fc82cb7bb5aad988bdfa127b5)
set(QT_HASH_qt5-multimedia          28eaaf4a704649616cd77ae5560ddd6298c82e525f59fa4d5a0178826fe2d6c9b77dcb067f2b5b56e88da7d6043a3f8e34b5c810d12751c74fdc65e5440586fa)
set(QT_HASH_qt5-networkauth         0f36530393abe5315154bf95d0cae1330a8af1af8af5a525d20336d4227f11aa9133b7e3258f651be6f212593ad7e0d2d5d15536fab3c07392a94f2954afe7c8)
set(QT_HASH_qt5-purchasing          06124d275dcb9c969ccebccd9847c9819eb460ec00b73ab442533dafa8df875c8729148d714555f301da1c273488f8e41ac0b176f11cfadba4e121e3230579da)
set(QT_HASH_qt5-quickcontrols       315f711d856a4f2882c4e60435bd5fc77623b4ba3bd10fea8e8d052e0a183556c4b5342236b18fade0bbae3a45df8b1426a26a87b1d7b071bb3e5846585775f6)
set(QT_HASH_qt5-quickcontrols2      41e44ee733ef3ac5021543407b472750c7b8d61bdeb6960d043477f0c5604699cafb5cca4f755a26ce3cfef1f948e85bb85623ecd21e70c876bd5a8c1f5547bf)
set(QT_HASH_qt5-remoteobjects       6297af20b6d73cafb29a3c9d000be51b7b4a668163c0d2796cd51d8d292759a9ea0a8beeff4ace6590a22b94eea51350142510d52a8b4ca73594508c204e4b58)
set(QT_HASH_qt5-script              6d3b802c7cdfb270318b9210df4ad9dbd2d29f485d9194051dbf278a48c25cc5c6311adeaf56b4fe2a7746dbc10234544e75e61a2e9c86f653aed0a92e07e717)
set(QT_HASH_qt5-scxml               45bf18c1bece80120b2a8f81357afda86584ad5455a49b0db0658b4dd7f0a4ef53c7cc7ef8fff26842f476661b162752db7e8a48ed3566342ad0c1537d4ac8f9)
set(QT_HASH_qt5-sensors             39bc6b2a435dd54d574f6c19ccc15698f8ade3f2b64170baa3e0d0bd24f64bc16a9088620a6be41a61ed170bd84d4795bf2819b40a188c5c2255a54d0e466035)
set(QT_HASH_qt5-serialport          c51fa5eca92a16c41678eef37c3e33c6ea7f61ad881dd309548b83bafa3fedf191afc324437863dcf1a35dafc512363e7588f65136c07ad8f0d51c6854da178f)
set(QT_HASH_qt5-speech              85f77f32d2a3fc28262fa0af2dc1ff13c572835bff8fef3a79b4af0efdee0fc325754e1803d98ce25042fd717de28f3ecb3cc916de729cbb267c14be136007a9)
set(QT_HASH_qt5-svg                 40d7dc82e0acde52e1258e1b1753cc93609c31cf69057c52dc2dd30dc59f2d7d434e20fa4f7f27db3fa300fd3c8f23a8fb03cc26b27cc1c02cc3bf6d97383503)
set(QT_HASH_qt5-tools               072d09315fc73ec610d2e0d9a1380e5539a79fa1d73104a801e0f8b9afe489b735fefcc46d7c9e519ee8c1b14975386260239be24183933281dead2fec00f466)
set(QT_HASH_qt5-virtualkeyboard     04960c475a01f65901279fdab352742e4dc77753a306c7bd9996cf32be4a63524e7be034d60b398c6862c0099b02eedcef89f28fd09b1c7fa3075f89adba5a7a)
set(QT_HASH_qt5-webchannel          956c57c019623a2ccc4b4a7fc8ca2404a04862b7a3fdb8d1317dfd0d24d00f73db4698df22a9758667256646129163ea1b3a588435aa01f28e72e35300637458)
set(QT_HASH_qt5-websockets          b5abd39664f07afe08805876980bc3850a83a032462a7b73e9d5c5458a2f195df85ec903e8a16bf93bde6089ec90ab9b930ea6b1ebb0d99d0955ad36de0613dd)
set(QT_HASH_qt5-webview             c7d5b5225a7edcf642249eb68f0db52ec56cd071f1e17e1f846a210f48229e71c649d99323dc70e9d3bcdca925b0ae1d9c56282d6b31398478ef024b22835fc7)
set(QT_HASH_qt5-winextras           4d972884bce7736d2a6e6b8d61291647cdf54a175cb6d0fca102e389074084e0f3d25dec35b2b8df2188760ebeee4b2b7f0158ebc37a0c6c1e208d7b10d2a778)
set(QT_HASH_qt5-xmlpatterns         769fb26b1b72bbe3a1fc0c13dee6f12c4bc5280824954194e676331082af91aacecd2c295aa2e566365f4679f19732b1caa3da18825e3560b402b86568b3ac4e)

if(QT_UPDATE_VERSION)
    message(STATUS "Running Qt in automatic version port update mode!")
    set(_VCPKG_INTERNAL_NO_HASH_CHECK 1)
    if(${PORT} MATCHES "qt5-base")
    foreach(_current_qt_port ${QT_PORT_LIST})
        set(_current_control "${VCPKG_ROOT_DIR}/ports/qt5-${_current_qt_port}/CONTROL")
        file(READ ${_current_control} _control_contents)
        string(REGEX REPLACE "Version: [0-9]\.[0-9]+\.[0-9]?[0-9]*[^a-zA-z]$" "Version: ${QT_MAJOR_MINOR_VER}.${QT_PATCH_VER}" _control_contents "${_control_contents}")
        file(WRITE ${_current_control} "${_control_contents}")
    endforeach()
endif()