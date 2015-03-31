# - Functions to prepend or append something to list of strings
#
# Adds specified string as prefix or suffix to each of strings in
# the specified list
#
#
#=============================================================================
# Public domain.
#
# Inspired by script of Marc Weber
# (http://www.cmake.org/pipermail/cmake/2010-May/036786.html)
#
# Copyright 2015 Alexey Chernov <4ernov@gmail.com>
#=============================================================================

function(prefixsuffix list_name prefix suffix)
	# create empty list - necessary?
	set(${list_name}_TMP)

	# prefix and suffix elements
	foreach(l IN LISTS ${list_name})
		list(APPEND ${list_name}_TMP ${prefix}${l}${suffix})
	endforeach()

	# replace list by tmp list
	set(${list_name} "${${list_name}_TMP}" PARENT_SCOPE)
endfunction(prefixsuffix)

function(prefix list_name prefix)
	set(${list_name}_TMP "${${list_name}}")
	prefixsuffix(${list_name}_TMP ${prefix} "")
	set(${list_name} "${${list_name}_TMP}" PARENT_SCOPE)
endfunction(prefix)

function(suffix list_name suffix)
	set(${list_name}_TMP "${list_name}")
	prefixsuffix(${list_name}_TMP "" ${suffix})
	set(${list_name} "${${list_name}_TMP}" PARENT_SCOPE)
endfunction(suffix)
