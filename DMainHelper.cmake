######
## Common usefull stuffs

######
# Colors defines
include(DCMakeColors)

# Set DSTATUS prefix for messages
if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
    # Stand-alone project
    set(DSTATUS ">> ")
else()
    # Part of other project
    set(DSTATUS ">>>> ")
    message_c(${BOLD_MAGENTA} "Library ${PROJECT_NAME} included as external project <<<<")
endif()

message_c(${BOLD_GREEN} "CMake version: ${CMAKE_VERSION}")
message_c(${BOLD_GREEN} "gcc c++ version: ${CMAKE_CXX_COMPILER_VERSION}")

# CMake helper scripts
include(DPrintHelpers)
include(generate_product_version)

# set everything up for c++ 17 features
set(CMAKE_CXX_STANDARD 17)
if(MSVC)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /std:c++17")
endif(MSVC)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Disable console popup
if(WIN32)
    set(GUI_TYPE WIN32)
    message(${DSTATUS} "Set WIN32 gui")
elseif(APPLE)
    set(GUI_TYPE MACOSX_BUNDLE)
    message(${DSTATUS} "Set APPLE gui")
endif()
