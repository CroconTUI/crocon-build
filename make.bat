@echo off
echo.
if NOT DEFINED CROCON_CC_TARGET (
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
echo [2/2] Building demos...

cd demos\barebns1\proj\msvc
nmake -nologo -f %CROCON_CC_TARGET%.mak CROCON_ROOT=..\..\..\..
echo.
echo Done!

cd ..\..\..\..\build

set DEBUG=
set CROCON_DEBUG=

echo.

pause