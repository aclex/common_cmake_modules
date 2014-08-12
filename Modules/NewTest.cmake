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

function(new_test srcs libraries)
	list(GET srcs 0 name)
	string(REGEX REPLACE "(\\.cpp|\\.hpp|\\.c|\\.h)" "" name ${name})
	add_executable(${name} ${srcs})
	target_link_libraries(${name} ${libraries})
	add_test(${name} ${RUNTIME_OUTPUT_DIRECTORY}/${name})
endfunction()
