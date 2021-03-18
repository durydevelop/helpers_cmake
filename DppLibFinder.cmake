######
# DPPLIB
##[[ Sorgenti in locale
## usa DPPLIB_DIR
message(${DSTATUS} "Finding libdpp...")
if (NOT EXISTS ${DPPLIB_DIR})
    message(FATAL_ERROR "DPPLIB_DIR not found. Please set correct DPPLIB_DIR var.")
endif()
message(${DSTATUS}  "in " ${DPPLIB_DIR})
add_subdirectory(${DPPLIB_DIR} deps/libdpp)
include_directories(${DPPLIB_DIR}/include)
get_target_property(DPPLIB_SOURCES DPPLIB SOURCES)
target_sources(${PROJECT_NAME} PRIVATE ${DPPLIB_SOURCES})
##]]

#[[ Sorgenti da git
include(FetchContent)
set(FETCHCONTENT_QUIET OFF)
set(FETCHCONTENT_UPDATES_DISCONNECTED OFF)
set(FETCHCONTENT_BASE_DIR deps)
FetchContent_Declare(
    libdpp
    GIT_REPOSITORY https://dury:CFg3BdZs3Wt8zeVobxCc@gitlab.com/durydevelop/cpp/lib/libdpp.git
    #GIT_PROGRESS TRUE
)
# Check if population has already been performed
FetchContent_GetProperties(libdpp)
if(NOT libdpp_POPULATED)
    message(${DSTATUS} "Not populated")
    FetchContent_Populate(libdpp)
endif()
FetchContent_MakeAvailable(libdpp)

add_subdirectory(${libdpp_SOURCE_DIR} deps/libdpp)
include_directories(${libdpp_SOURCE_DIR}/include)
target_link_libraries(${PROJECT_NAME} PRIVATE DPPLIB)
#]]