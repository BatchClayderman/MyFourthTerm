@ECHO OFF
SET NAME=%1
REM IF /I %NAME:~-4%==".asm" (SET NAME=%NAME:~0,-4%)
REM IF %NAME%=="" (ECHO Please specify a file&EXIT)

:CLEAR
ECHO CLEAR: %NAME%.OBJ %NAME%.EXE
DEL %NAME%.OBJ
DEL %NAME%.EXE
ECHO.
ECHO.

:MASM
ECHO ASM: %NAME%.ASM
MASM /T %NAME%.ASM;
ECHO.
ECHO.

:OBJ
ECHO OBJ: %NAME%.OBJ
LINK %NAME%.OBJ;
ECHO.
ECHO.
GOTO RUN

:DEBUG
ECHO DEBUG: %NAME%.EXE
DEBUG %NAME%.EXE
ECHO.
ECHO.

:RUN
ECHO RUN: %NAME%.EXE
%NAME%.EXE
ECHO.
ECHO.
ECHO TERMINATED: %NAME%.EXE