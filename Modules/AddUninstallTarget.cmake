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

add_uninstall_target()
