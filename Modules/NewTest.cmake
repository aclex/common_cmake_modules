# Function with all the necessary stuff to add new test to a project
#
# Test name is generated based on first source file name with its extension removed.
# Dependencies are libraries that used to link test target executable.
#
# Example:
# new_test(my_new_test.cpp)
#
# Creates new test "my_new_test".
#

set(THIS_IS_MY_DIR ${CMAKE_CURRENT_LIST_DIR})
set(FAILTEST_CMAKELISTS_FILENAME "failcompile_cmakelists.txt.in")

function(new_test srcs libraries)
	list(GET srcs 0 name)
	string(REGEX REPLACE "(\\.cpp|\\.hpp|\\.c|\\.h)" "" name ${name})
	add_executable(${name} ${srcs})
	target_link_libraries(${name} ${libraries})
	add_test(${name} ${RUNTIME_OUTPUT_DIRECTORY}/${name})
endfunction()

function(new_compilation_fail_test srcs libraries)
	get_property(TEST_INCLUDE_DIRECTORIES DIRECTORY PROPERTY INCLUDE_DIRECTORIES)
	get_property(TEST_COMPILE_DEFINITIONS DIRECTORY PROPERTY DEFINITIONS)

	string(REPLACE ";" "\;" TEST_INCLUDE_DIRECTORIES "${TEST_INCLUDE_DIRECTORIES}")

	set(TEST_LINK_LIBRARIES ${libraries})

	set(TEST_SOURCES "")

	foreach(f ${srcs})
		list(APPEND TEST_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/${f}")
	endforeach(f)

	list(GET srcs 0 name)
	string(REGEX REPLACE "(\\.cpp|\\.hpp|\\.c|\\.h)" "" name ${name})
	set(test_local_dir ${name})

	configure_file(
		${THIS_IS_MY_DIR}/${FAILTEST_CMAKELISTS_FILENAME}
		"${CMAKE_CURRENT_BINARY_DIR}/${test_local_dir}/CMakeLists.txt"
		IMMEDIATE @ONLY)

	add_test(${name} ${CMAKE_CTEST_COMMAND}
		--build-and-test
		"${CMAKE_CURRENT_BINARY_DIR}/${test_local_dir}"
		"${CMAKE_CURRENT_BINARY_DIR}/${test_local_dir}"
		--build-generator ${CMAKE_GENERATOR}
		--build-makeprogram ${CMAKE_MAKE_PROGRAM}
)
endfunction()
