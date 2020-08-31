set(THIS_IS_MY_DIR ${CMAKE_CURRENT_LIST_DIR})

function(add_uninstall_target)
	if (NOT TARGET uninstall)
		set(UNINSTALL_CMAKE_FILENAME "cmake_uninstall.cmake")
		configure_file(
			"${THIS_IS_MY_DIR}/${UNINSTALL_CMAKE_FILENAME}.in"
			"${CMAKE_BINARY_DIR}/${UNINSTALL_CMAKE_FILENAME}"
			IMMEDIATE @ONLY)

		add_custom_target(uninstall COMMAND ${CMAKE_COMMAND} -P ${CMAKE_BINARY_DIR}/${UNINSTALL_CMAKE_FILENAME})
	endif ()
endfunction(add_uninstall_target)

get_directory_property(EXCLUDE_FROM_ALL DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} EXCLUDE_FROM_ALL)

if (NOT EXCLUDE_FROM_ALL)
	add_uninstall_target()
endif()
