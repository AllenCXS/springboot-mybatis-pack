@echo off
setlocal

rem
rem Copyright (c) 1999, 2018 Tanuki Software, Ltd.
rem http://www.tanukisoftware.com
rem All rights reserved.
rem
rem This software is the proprietary information of Tanuki Software.
rem You shall use it only in accordance with the terms of the
rem license agreement you entered into with Tanuki Software.
rem http://wrapper.tanukisoftware.com/doc/english/licenseOverview.html
rem
rem Java Service Wrapper script - Install as an NT service.
rem

rem -----------------------------------------------------------------------------
rem These settings can be modified to fit the needs of your application
rem Optimized for use with version 3.5.37 of the Wrapper.

rem The base name for the Wrapper binary.
set _WRAPPER_BASE=wrapper

rem The directory where the Wrapper binary (.exe) file is located. It can be
rem  either an absolute or a relative path. If the path contains any special 
rem  characters, please make sure to quote the variable. 
set _WRAPPER_DIR=

rem The name and location of the Wrapper configuration file. This will be used
rem  if the user does not specify a configuration file as the first parameter to
rem  this script.
rem If a relative path is specified, please note that the location is based on the 
rem location of the Wrapper executable.
set _WRAPPER_CONF_DEFAULT="../config/%_WRAPPER_BASE%.conf"

rem Makes it possible to override the Wrapper configuration file by specifying it
rem  as the first parameter.
rem set _WRAPPER_CONF_OVERRIDE=true

rem _PASS_THROUGH tells the script to pass all parameters through to the JVM
rem  as is.  
rem  If _WRAPPER_CONF_OVERRIDE is specified then all parameters will be passed.
rem  If not set then all parameters starting with the second will be passed.
set _PASS_THROUGH=true

rem Do not modify anything beyond this point
rem -----------------------------------------------------------------------------

rem
rem Resolve the real path of the wrapper.exe
rem  For non NT systems, the _REALPATH and _WRAPPER_CONF values
rem  can be hard-coded below and the following test removed.
rem
if "%OS%"=="Windows_NT" goto nt
echo This script only works with NT-based versions of Windows.
goto :eof

:nt
rem Find the application home.
rem if no path path specified do the default action
IF not DEFINED _WRAPPER_DIR goto dir_undefined
set _WRAPPER_DIR_QUOTED="%_WRAPPER_DIR:"=%"
if not "%_WRAPPER_DIR:~-2,1%" == "\" set _WRAPPER_DIR_QUOTED="%_WRAPPER_DIR_QUOTED:"=%\"
rem check if absolute path
if "%_WRAPPER_DIR_QUOTED:~2,1%" == ":" goto absolute_path
if "%_WRAPPER_DIR_QUOTED:~1,1%" == "\" goto absolute_path
rem everythig else means relative path
set _REALPATH="%~dp0%_WRAPPER_DIR_QUOTED:"=%"
goto pathfound

:dir_undefined
rem Use a relative path to the wrapper %~dp0 is location of current script under NT
set _REALPATH="%~dp0"
goto pathfound
:absolute_path
rem Use an absolute path to the wrapper
set _REALPATH="%_WRAPPER_DIR_QUOTED:"=%"

:pathfound
rem
rem Decide on the specific Wrapper binary to use (See delta-pack)
rem
if "%PROCESSOR_ARCHITEW6432%"=="AMD64" goto amd64
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" goto amd64
if "%PROCESSOR_ARCHITECTURE%"=="IA64" goto ia64
:x86_32
set _WRAPPER_L_EXE="%_REALPATH:"=%%_WRAPPER_BASE%-windows-x86-32.exe"
set _BIN_BITS="32"
goto search
:amd64
set _WRAPPER_L_EXE="%_REALPATH:"=%%_WRAPPER_BASE%-windows-x86-64.exe"
set _BIN_BITS="64"
goto search
:ia64
set _WRAPPER_L_EXE="%_REALPATH:"=%%_WRAPPER_BASE%-windows-ia-64.exe"
set _BIN_BITS="64"
goto search
:search
set _WRAPPER_EXE="%_WRAPPER_L_EXE:"=%"
if exist %_WRAPPER_EXE% goto check_lic_bits
set _WRAPPER_EXE="%_REALPATH:"=%%_WRAPPER_BASE%.exe"
if exist %_WRAPPER_EXE% goto conf
if %_BIN_BITS%=="64" goto x86_32
echo Unable to locate a Wrapper executable using any of the following names:
echo %_WRAPPER_L_EXE%
echo %_WRAPPER_EXE%
pause
goto :eof

:check_lic_bits
if %_BIN_BITS%=="64" (
    set _CHECK_LIC_BITS=true
)

rem
rem Find the wrapper.conf
rem
:conf
if [%_WRAPPER_CONF_OVERRIDE%]==[true] (
    set _WRAPPER_CONF="%~f1"
    if not [%_WRAPPER_CONF%]==[""] (
        shift
        goto :startup
    )
)
set _WRAPPER_CONF="%_WRAPPER_CONF_DEFAULT:"=%"

rem The command should not be called inside a IF, else errorlevel would be 0
if not [%_CHECK_LIC_BITS%]==[true] goto startup
%_WRAPPER_EXE% --request_delta_binary_bits %_WRAPPER_CONF% > nul 2>&1
if %errorlevel% equ 32 (
    set _LIC32_OS64=true
    set _CHECK_LIC_BITS=false
    goto x86_32
)

rem
rem Start the Wrapper
rem
:startup
if not [%_PASS_THROUGH%]==[true] (
    if not [%1]==[] (
        echo WARNING: Extra arguments will be ignored. Please check usage in the batch file.
    )
)

rem Collect the application parameters
:parameters
set _PARAMETERS=%_PARAMETERS% %1
shift
if not [%1]==[] goto :parameters

if not [%_PASS_THROUGH%]==[true] (
    %_WRAPPER_EXE% -i %_WRAPPER_CONF%
) else (
    %_WRAPPER_EXE% -i %_WRAPPER_CONF% -- %_PARAMETERS%
)
if not errorlevel 1 goto :eof
pause