include(GenerateExportHeader)
cmake_minimum_required (VERSION 2.6)
project (gamepad)
include_directories(gamepad/source)

set(files gamepad/source/gamepad/Gamepad_private.c)

if (WIN32)
  set(files gamepad/source/gamepad/Gamepad_windows_dinput.c ${files})
elseif (APPLE)
  set(files gamepad/source/gamepad/Gamepad_macosx.c ${files})
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -framework IOKit -framework CoreFoundation")
elseif (UNIX)
  set(files gamepad/source/gamepad/Gamepad_linux.c ${files})
endif()

add_library(gamepad SHARED ${files})

target_link_libraries(gamepad)
