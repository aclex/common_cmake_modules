function(add_clean_target_subdirectory SUBDIR)
	set(BUILD_EXAMPLES FALSE)
	set(BUILD_TESTS FALSE)
	set(BUILD_DOCUMENTATION FALSE)

	set(ALL ${ARGV1})

	if (NOT ALL)
		add_subdirectory(${SUBDIR} EXCLUDE_FROM_ALL)
	else()
		add_subdirectory(${SUBDIR})
	endif()
endfunction()
