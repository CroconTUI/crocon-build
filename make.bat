@echo off

if "%CROCON_CC_TARGET%"=="" IF "%1"=="" (
	echo.

	echo You run a script designed to build the Crocon framework with demo application 
	echo samples on Windows.
	echo.
	echo Before starting the build, you need to configure the build.
	echo Currently, two target versions of Microsoft Visual C++ are supported:
	echo.
	echo [ vc2] Microsoft Visual C++  2.0 - 2003
	echo [ vc8] Microsoft Visual C++ 2005 - 2013
	echo [vc14] Microsoft Visual C++ 2015 - 2026
	echo.
	set /P CROCON_CC_TARGET=Choose your MSVC target version [vc2, vc8, vc14]: 
) else (
	echo.
)

if "%CROCON_CC_TARGET%"=="" (
set CROCON_CC_TARGET=vc2
echo  Microsoft Visual C++ 2.0 - 2003 was selected as the default target. 
echo.
echo. You can change the default value by setting the CROCON_CC_TARGET variable.
echo.
pause
)


if "%CROCON_DEBUG%"=="" IF "%2"=="" (
	set /P CROCON_DEBUG=Include debug symbols before building? [y, n]: 
)

if NOT "%CROCON_DEBUG%"=="" (
	set DEBUG=1
) else (
	set DEBUG=
)

if NOT "%2"=="" (
	set DEBUG=1
) else (
	set DEBUG=
)
echo.

if "%CROCON_DEBUG%"=="" IF "%2"=="" (
	echo [1/2] Building Crocon TUI framework from source...
) else (
	echo [1/2] Building Crocon TUI framework with debug symbols from source...
)

cd ..\library\proj\msvc
nmake -nologo -f %CROCON_CC_TARGET%.mak

cd ..\..\..

echo.
echo [2/2] Building Crocon Demos...

cd demos\barebns1\proj\msvc
nmake -nologo -f %CROCON_CC_TARGET%.mak CROCON_ROOT=..\..\..\..
echo.
echo Done!

cd ..\..\..\..\build

set DEBUG=
set CROCON_DEBUG=

echo.

pause