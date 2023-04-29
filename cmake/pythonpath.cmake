cmake_minimum_required(VERSION 3.19)

set(sep ":")
if(CMAKE_HOST_WIN32)
  set(sep ";")
endif()

if(DEFINED ENV{PYTHONPATH} AND ENV{PYTHONPATH})
  set(path "$ENV{PYTHONPATH}${sep}${path}")
endif()

set(ENV{PYTHONPATH} "${path}")

execute_process(COMMAND ${command} COMMAND_ERROR_IS_FATAL ANY)
