######
# dpplib
##[[ Sorgenti in locale
## usa dpplib_ROOT
message_c(${BOLD_MAGENTA} "Finding dpplib...")
if (NOT ${dpplib_ROOT} STREQUAL "")
    message_c(${BOLD_MAGENTA} "dpplib_ROOT set to ${dpplib_ROOT}")
endif()

if (NOT EXISTS ${dpplib_ROOT})
    message(FATAL_ERROR "dpplib_ROOT not found. Please set correct dpplib_ROOT path")
endif()
##]]

#[[ Sorgenti da git
include(FetchContent)
set(FETCHCONTENT_QUIET OFF)
set(FETCHCONTENT_UPDATES_DISCONNECTED OFF)
set(FETCHCONTENT_BASE_DIR deps)
FetchContent_Declare(
    dpplib
    GIT_REPOSITORY https://dury:CFg3BdZs3Wt8zeVobxCc@gitlab.com/durydevelop/cpp/lib/dpplib.git
    #GIT_PROGRESS TRUE
)
# Check if population has already been performed
FetchContent_GetProperties(dpplib)
if(NOT dpplib_POPULATED)
    message(${DSTATUS} "Not populated")
    FetchContent_Populate(dpplib)
endif()
FetchContent_MakeAvailable(dpplib)

add_subdirectory(${dpplib_ROOT} deps/dpplib)
include_directories(${dpplib_ROOT}/include)
target_link_libraries(${PROJECT_NAME} PRIVATE dpplib)
#]]

add_subdirectory(${dpplib_ROOT} deps/dpplib)
include_directories(${PROJECT_NAME} PUBLIC ${dpplib_ROOT}/include)
get_target_property(dpplib_SOURCES dpplib SOURCES)
target_sources(${PROJECT_NAME} PUBLIC ${dpplib_SOURCES})

include_directories(${PROJECT_NAME} PUBLIC ${Boost_INCLUDE_DIR})

# std::filesystem
#target_link_libraries(${PROJECT_NAME}
#    PUBLIC
#        stdc++fs
#        pthread
#)

# winsock
if (CMAKE_SYSTEM_NAME STREQUAL "Windows")
    message_c("Linking Winsock2 for " ${PROJECT_NAME})
    target_link_libraries(${PROJECT_NAME} PUBLIC ws2_32 wsock32)
endif()
