# - Generate PkgConfig .pc module file
#
# It tries to guess all the necessary variables to fill fields
# and writes the name of the generated file to its argument.
#
# .pc file template is expected to be located at
# <project_root>/cmake/PcTemplate.pc.in.
#
# These variables are used to fill the corresponding fields:
#
# CMAKE_INSTALL_PREFIX -  'prefix'
# CMAKE_INSTALL_BINDIR -  'exec_prefix'
# CMAKE_INSTALL_LIBDIR -  'libdir'
# CMAKE_INSTALL_INCLUDEDIR - 'includedir'
# CMAKE_PROJECT_NAME - 'Name'
# PROJECT_DESCRIPTION - 'Description'
# PROJECT_VERSION - 'Version'
# PROJECT_URL - 'URL'
# PROJECT_REQUIRES - 'Requires'
# PROJECT_CONFICTS - 'Conficts'
# PROJECT_TARGET_NAME (optional) - part of 'Libs'
# PROJECT_DEPENDENCY_LIBRARIES (optional) - part of 'Libs'
#
#=============================================================================
# This is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Lesser Public License version 3.
#
# This software is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this software.  If not, see <http://www.gnu.org/licenses/>.
#
# Copyright 2014 Alexey Chernov <4ernov@gmail.com>
#=============================================================================

set(THIS_IS_MY_DIR ${CMAKE_CURRENT_LIST_DIR})

function(generate_pc_file PC_FILENAME)
	set(INTERNAL_PC_FILENAME "${CMAKE_PROJECT_NAME}.pc")

	include(GNUInstallDirs)
	if (NOT DEFINED PROJECT_INSTALL_BINDIR)
		set(PROJECT_INSTALL_BINDIR "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_BINDIR}")
	endif()

	if (NOT DEFINED PROJECT_INSTALL_LIBDIR)
		set(PROJECT_INSTALL_LIBDIR "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}")
	endif()

	if (NOT DEFINED PROJECT_INSTALL_INCLUDEDIR)
		set(PROJECT_INSTALL_INCLUDEDIR "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR}")
	endif()

	if (NOT DEFINED PROJECT_VERSION)
		set(PROJECT_VERSION "0.0.0")
	endif()

	if (NOT DEFINED PROJECT_TARGET_NAME)
		set(PROJECT_TARGET_NAME ${PROJECT_NAME})
	endif()

	string(REGEX REPLACE "^lib" "" PROJECT_TARGET_NAME ${PROJECT_TARGET_NAME})

	foreach (it ${PROJECT_DEPENDENCY_LIBRARIES})
		if (NOT it MATCHES "^-L.*$")
			get_filename_component(lib ${it} NAME_WE)
			string(REGEX REPLACE "^lib" "-l" lib ${lib})
			if (NOT lib MATCHES "^-l")
				set(lib "-l${lib}")
			endif()
		else()
			if (NOT it MATCHES "^-L${PROJECT_INSTALL_LIBDIR}")
				set(lib ${it})
			endif()
		endif()
		list(APPEND PARSED_DEPENDENCY_LIBRARIES ${lib})
	endforeach(it)
	string(REPLACE ";" " " PROJECT_DEPENDENCY_LIBRARIES "${PARSED_DEPENDENCY_LIBRARIES}")

	configure_file(${THIS_IS_MY_DIR}/PcTemplate.pc.in ${CMAKE_BINARY_DIR}/${INTERNAL_PC_FILENAME} @ONLY)
	set(${PC_FILENAME} ${INTERNAL_PC_FILENAME} PARENT_SCOPE)
endfunction(generate_pc_file)
