Common CMake modules
====================
Several handy CMake modules for common routines often done across the projects.

## AddCleanTargetSubdirectory
#### Functions:
* **`add_clean_target_subdirectory`** Adds a subdirectory with several certain building control variables cleared. At the moment it clears up `BUILD_EXAMPLES`, `BUILD_TESTS` and `BUILD_DOCUMENTATION`. Otherwise it's equal to `add_subdirectory()` CMake command.
Optional `ALL` parameter can be used to disable `EXCLUDE_FROM_ALL` option to `add_subdirectory`, which seems to be expected default behaviour when including CMake subproject with the command.

## AddUninstallTarget
#### Functions:
* **`add_uninstall_target`** (run implicitly on including the module) As uninstallation is not supported in CMake by default for conceptual reasons, adds `uninstall` target to the CMake project as per [officially suggested code snippet](https://gitlab.kitware.com/cmake/community/wikis/FAQ#can-i-do-make-uninstall-with-cmake).

## GeneratePcFile
#### Functions:
* **`generate_pc_file`** Generates `pkg-config`'s `*.pc` file for the project. Automatically applies installation directories using `GNUInstallDirs` CMake module and scans library dependencies of main project target (uses `PROJECT_TARGET_NAME` and `PROJECT_NAME` variables for the target name).

## GitVersion
#### Functions:
* **`git_version`** Tries to guess project version out of current tag title printed by `git describe`.

* **`git_commit_version`** Tries to guess project version analysing the output of `git describe`, with latest commit hash included together with tag title (like `1.0.1-a1b2c3d4`).

## NewTest
#### Functions:
* **`new_test`** Adds new test cases for CTest the easy way, i.e. executable, linking and test at once. Optional second and next parameters may include the library dependencies.

* **`new_compilation_fail_test`** Adds test, that checks, that the compilation fails for certain test case file (in other words, if compilation fails, test passes, otherwise it fails).

## PrefixSuffix
#### Functions:
* **`prefixsuffix`** Adds prefix and suffix specified in the parameter list to each item of the list, replacing the original content of the list.
* **`prefix`** Adds prefix specified in the parameter list to each item of the list, replacing the original content of the list.
* **`suffix`** Adds suffix specified in the parameter list to each item of the list, replacing the original content of the list.

## VersionRoutines
#### Macros:
* **`three_part_version_to_vars`** parses compiled version with dotted notation (usually stored in `PROJECT_VERSION` variable) to major, minor and patch parts separately.
