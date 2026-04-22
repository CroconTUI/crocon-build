@echo off
echo.
if NOT DEFINED CROCON_CC_TARGET (
	echo You run a script designed to build the Crocon framework with demo application 
	echo samples on Windows.
	echo.
	echo Before starting the build, you need to configure the build.
	echo Currently, two target versions of Microsoft Visual C++ are supported:
	echo.
	echo [vc2] Microsoft Visual C++  2.0 - 2005
	echo [vc8] Microsoft Visual C++ 2005 - 2026
	echo.
	set /P "CROCON_CC_TARGET=Choose your MSVC target version [vc2, vc8]: "
)

if NOT DEFINED CROCON_CC_TARGET (set CROCON_CC_TARGET=vc2)


if NOT DEFINED CROCON_DEBUG (
	set /P "CROCON_DEBUG=Include debug symbols before building? [y, n]: "
)

if DEFINED CROCON_DEBUG IF "%CROCON_DEBUG%"=="y" (
	set DEBUG=1
) else (
	set DEBUG=
)

echo.
echo [1/2] Building Crocon TUI framework from source...

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