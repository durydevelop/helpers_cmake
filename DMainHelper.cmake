######
# Initial stuffs
set(DSTATUS ">> ")
message(${DSTATUS} "CMake version: ${CMAKE_VERSION}")
message(${DSTATUS} "gcc c++ version: ${CMAKE_CXX_COMPILER_VERSION}")

# CMake helper scripts
include(DPrintHelpers)

# set everything up for c++ 17 features
set(CMAKE_CXX_STANDARD 17)
if(MSVC)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /std:c++17")
endif(MSVC)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if(NOT ${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    # Disable console popup
    if(WIN32)
        set(GUI_TYPE WIN32)
        message(${DSTATUS} "Set WIN32 gui")
    elseif(APPLE)
        set(GUI_TYPE MACOSX_BUNDLE)
        message(${DSTATUS} "Set APPLE gui")
    endif()
endif()
