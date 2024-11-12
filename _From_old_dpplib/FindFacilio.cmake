if (NOT facilio_FOUND)
    include(FetchContent)
    FetchContent_Declare(
        facilio
        GIT_REPOSITORY https://github.com/boazsegev/facil.io.git
        #GIT_TAG 3.6
    )
	# Check if population has already been performed
	FetchContent_GetProperties(facilio)
	if(NOT raygui_POPULATED)
		FetchContent_Populate(facilio)
		
	endif()
	FetchContent_MakeAvailable(facilio)
	#add_subdirectory(${facilio_SOURCE_DIR} ${facilio_BINARY_DIR})
endif()

#include_directories(${PROJECT_NAME} ${facilio_SOURCE_DIR})