cmake_minimum_required(VERSION 3.8)

project(libdpp
        VERSION 0.2.1.2
        DESCRIPTION "Cpp extension library for boost, beast, asio"
        LANGUAGES CXX
)

# Use this snippet *after* PROJECT(xxx):
#if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
#  set(CMAKE_INSTALL_PREFIX <path> CACHE PATH <comment> FORCE)
#endif(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)

message(">> CMake version: ${CMAKE_VERSION}")
message(">> gcc c++ version: ${CMAKE_CXX_COMPILER_VERSION}")
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake")
include(DPrintHelpers)

# set everything up for c++ 17 features
set(CMAKE_CXX_STANDARD 17)
if(MSVC)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /std:c++17")
endif(MSVC)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

## Setup Boost lib
message(">> Finding boost library...")
if (CMAKE_SYSTEM_NAME STREQUAL "Windows")
    message(">> \tfor Windows")
    set(BOOST_ROOT "../../../lib/cpp/boost")
    if (BOOST_ROOT)
        message(">> \tFound BOOST_ROOT=" ${BOOST_ROOT})
    endif()
    find_package(Boost)
elseif (CMAKE_SYSTEM_NAME STREQUAL "Linux")
    message(">> \tFor Linux")
    find_package(Boost)
endif()

if (Boost_FOUND)
    include_directories(${Boost_INCLUDE_DIR})
    message(">> \tFound ${Boost_VERSION_STRING}")
    message(">> \tBoost include dir: ${Boost_INCLUDE_DIR}")
    if (Boost_LIBRARY_DIR)
        message(">> \tBoost lib: ${Boost_LIBRARY_DIR}")
        #string(APPEND ADDED_LINK_LIBRARIES ${Boost_LIBRARY_DIR})
    endif()
else()
    message(FATAL_ERROR ">> Boost not found")
endif()

#add_subdirectory(include)
include_directories(${${PROJECT_NAME}_SOURCE_DIR}/src ${${PROJECT_NAME}_SOURCE_DIR}/include)
add_subdirectory(lib)
#add_subdirectory(example)

install(DIRECTORY include DESTINATION ".")

#if (${CMAKE_CXX_COMPILER_ID} MATCHES GNU AND ${CMAKE_SYSTEM_NAME} MATCHES "Windows")
#  target_link_libraries(${PROJECT_NAME} ws2_32 wsock32 stdc++fs)
#endif()

# Testing
if (BUILD_TESTS)
  message(">> Configuring tests")
  enable_testing()
  #find_package(GTest REQUIRED)
  #include_directories(${GTEST_INCLUDE_DIR})
  #add_subdirectory(deps/googletest)
  #add_subdirectory(test)
  # FetchContent added in CMake 3.11, downloads during the configure step
  # FetchContent_MakeAvailable was not added until CMake 3.14
  include(FetchContent)

  FetchContent_Declare(
    googletest
    GIT_REPOSITORY https://github.com/google/googletest.git
    )
  FetchContent_MakeAvailable(googletest)

  FetchContent_GetProperties(googletest)
  if(NOT googletest_POPULATED)
    FetchContent_Populate(googletest)
    add_subdirectory(${googletest_SOURCE_DIR} ${googletest_BINARY_DIR})
  endif()
endif()

#include(cmake/install.cmake)
message(">>>> CMAKE_CURRENT_SOURCE_DIR " ${CMAKE_CURRENT_SOURCE_DIR})
message(">>>> CMAKE_SOURCE_DIR " ${CMAKE_SOURCE_DIR})

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

set(INCLUDE_INSTALL_DIR include/)
set(LIBRARY_INSTALL_DIR lib/)
set(SYSCONFIG_INSTALL_DIR etc/${PROJECT_NAME}/)

message(">>>> INCLUDE_INSTALL_DIR " ${INCLUDE_INSTALL_DIR})
message(">>>> LIBRARY_INSTALL_DIR " ${LIBRARY_INSTALL_DIR})
message(">>>> SYSCONFIG_INSTALL_DIR " ${SYSCONFIG_INSTALL_DIR})

configure_package_config_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake/Config.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
    INSTALL_DESTINATION
        cmake
    PATH_VARS
        INCLUDE_INSTALL_DIR
        SYSCONFIG_INSTALL_DIR
)

write_basic_package_version_file(
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake
    VERSION
        ${PROJECT_VERSION}
    COMPATIBILITY
        SameMajorVersion
)
install(
    FILES
        ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
        ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake
    DESTINATION
        cmake
)
