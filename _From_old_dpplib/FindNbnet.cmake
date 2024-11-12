set(FETCHCONTENT_UPDATES_DISCONNECTED OFF)
if (NOT nbnet_FOUND)
    include(FetchContent)
    FetchContent_Declare(
        nbnet
        GIT_REPOSITORY https://github.com/nathhB/nbnet.git
    )
	# Check if population has already been performed
	FetchContent_GetProperties(nbnet)
	if (NOT nbnet_POPULATED)
		set(FETCHCONTENT_QUIET OFF)
		FetchContent_Populate(nbnet)
		
	endif()
	FetchContent_MakeAvailable(nbnet)
	
endif()

include_directories(${PROJECT_NAME} ${nbnet_SOURCE_DIR})