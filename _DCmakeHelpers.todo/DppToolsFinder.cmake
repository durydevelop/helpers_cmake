######
# dpptools
##[[ Sorgenti in locale
## usa dpptools_ROOT
message_c(${BOLD_MAGENTA} "Finding dpptools...")
if (NOT ${dpptools_ROOT} STREQUAL "")
    message_c(${BOLD_MAGENTA} "dpptools_ROOT set to ${dpptools_ROOT}")
endif()

if (NOT EXISTS ${dpptools_ROOT})
    message(FATAL_ERROR "dpptools_ROOT not found. Please set correct dpptools_ROOT path")
endif()
##]]

#[[ Sorgenti da git
include(FetchContent)
set(FETCHCONTENT_QUIET OFF)
set(FETCHCONTENT_UPDATES_DISCONNECTED OFF)
set(FETCHCONTENT_BASE_DIR deps)
FetchContent_Declare(
    dpptools
    GIT_REPOSITORY https://dury:CFg3BdZs3Wt8zeVobxCc@gitlab.com/durydevelop/cpp/lib/dpptools.git
    #GIT_PROGRESS TRUE
)
# Check if population has already been performed
FetchContent_GetProperties(dpptools)
if(NOT dpptools_POPULATED)
    message(${DSTATUS} "Not populated")
    FetchContent_Populate(dpptools)
endif()
FetchContent_MakeAvailable(dpptools)

add_subdirectory(${dpptools_ROOT} deps/dpptools)
include_directories(${dpptools_ROOT}/include)
target_link_libraries(${PROJECT_NAME} PRIVATE dpptools)
#]]

add_subdirectory(${dpptools_ROOT} deps/dpptools)
include_directories(${PROJECT_NAME} PUBLIC ${dpptools_ROOT}/include)
get_target_property(dpptools_SOURCES dpptools SOURCES)
target_sources(${PROJECT_NAME} PUBLIC ${dpptools_SOURCES})

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
