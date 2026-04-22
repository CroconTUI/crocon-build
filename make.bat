@echo off

set /P CROCON_CC_TARGET=Choose your MSVC target version [vc2, vc8]: 

echo [1/2] Building Crocon TUI framework from source...

cd ..\library\proj\msvc
nmake -f %CROCON_CC_TARGET%.mak

cd ..\..\..

echo [2/2] Building demos...

cd demos\barebns1\proj\msvc
nmake -f %CROCON_CC_TARGET%.mak CROCON_ROOT=..\..\..\..

echo Done!

cd ..\..\..\..\build

pause