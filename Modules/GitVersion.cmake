# Function that determines current project version based on last git tag and commit hash
#
# Example:
# git_version(VER)
#
# Writes current project version into variable 'VER'
#

include(VersionRoutines)

function(git_version VER)
	execute_process(COMMAND git describe --tags
					COMMAND sed s/^v//
					OUTPUT_VARIABLE TEMP_VER
					ERROR_QUIET)
	if(TEMP_VER)
		string(REGEX REPLACE "(\r?\n)+$" "" TEMP_VER "${TEMP_VER}")
		string(REGEX REPLACE "\-.*$" "" TEMP_VER "${TEMP_VER}")
		set(${VER} ${TEMP_VER} PARENT_SCOPE)
	else()
		set(${VER} "0.0.0" PARENT_SCOPE)
	endif()
endfunction()

function(git_commit_version VER)
	execute_process(COMMAND git describe --tags --long
					COMMAND sed s/^v//
					OUTPUT_VARIABLE TEMP_VER
					ERROR_QUIET)
	if(TEMP_VER)
		string(REGEX REPLACE "(\r?\n)+$" "" TEMP_VER "${TEMP_VER}")
		string(REGEX REPLACE "\-.*$" "" TEMP_VER "${TEMP_VER}")
		set(${VER} ${TEMP_VER} PARENT_SCOPE)
	else()
		set(${VER} "0.0.0" PARENT_SCOPE)
	endif()
endfunction()

function(set_project_version_from_git_tag)
	find_program(GIT_CMD git)
	find_program(SED_CMD sed)

	if (NOT GIT_CMD OR NOT SED_CMD)
		return()
	endif()

	execute_process(COMMAND git describe --tags
					COMMAND sed s/^v//
					OUTPUT_VARIABLE TEMP_VER
					ERROR_QUIET)
	if(TEMP_VER)
		string(REGEX REPLACE "(\r?\n)+$" "" TEMP_VER "${TEMP_VER}")
		string(REGEX REPLACE "\-.*$" "" TEMP_VER "${TEMP_VER}")
		set(PROJECT_VERSION ${TEMP_VER} PARENT_SCOPE)
		split_version_string(${TEMP_VER} PROJECT_VERSION)

		if (NOT CMAKE_PROJECT_VERSION)
			set(CMAKE_PROJECT_VERSION ${TEMP_VER} PARENT_SCOPE)
			split_version_string(${TEMP_VER} CMAKE_PROJECT_VERSION)
		endif()
	endif()
endfunction()
