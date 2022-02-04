@echo off
if "%CPMTOOLS%"=="" goto BEGIN
goto END
:BEGIN
set CPMTOOLS=\cpmtools
set PATH=%CPMTOOLS%;%PATH%
:END