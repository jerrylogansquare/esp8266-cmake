set(ESP8266_SDK_BASE ${ESP8266_OPEN_SDK_BASE}/sdk CACHE PATH "Path to the ESP8266 SDK")
if (ESP8266_FLASH_SIZE MATCHES "512K")
    set(ESP8266_LINKER_SCRIPT "eagle.app.v6.ld")
    set(FW_ADDR_1 0x00000 PARENT_SCOPE)
    set(FW_ADDR_2 0x40000 PARENT_SCOPE)
elseif (ESP8266_FLASH_SIZE MATCHES "1M")
    set(ESP8266_LINKER_SCRIPT "eagle.app.v6.new.1024.app1.ld")
    set(FW_ADDR_1 0x00000 PARENT_SCOPE)
    set(FW_ADDR_2 0x01010 PARENT_SCOPE)
else()
    message(FATAL_ERROR "Unsupported flash size")
endif()
set_property(TARGET ESP8266_SDK
    PROPERTY INTERFACE_INCLUDE_DIRECTORIES
    ${ESP8266_SDK_BASE}/include
    ${ESP8266_SDK_BASE}/include/json
)
set(ESP8266_LINKER_SCRIPT_PATH ${ESP8266_SDK_BASE}/ld/${ESP8266_LINKER_SCRIPT})
set_property(TARGET ESP8266_SDK
    PROPERTY INTERFACE_LINK_LIBRARIES
    gcc
    hal
    pp
    phy
    net80211
    lwip
    wpa
    main
    crypto
    -T${ESP8266_LINKER_SCRIPT_PATH} 
)

