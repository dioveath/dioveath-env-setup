@echo off

SET str1=string1
SET str2=string2

rem set /p project_test="Prompt for var:"
rem setx PROJECT_TEST=

rem if defined PROJECT_PATH echo %str2%

subst | findstr /C:"Z:\\: => S:\\" 1>nul 
if errorlevel 1 (
echo "not mapped"
) else (
echo "already mapped")
)

rem FINDSTR will set %ERRORLEVEL% as follows:

rem 0 (False) a match is found in at least one line of at least one file.
rem 1 (True) if a match is not found in any line of any file, (or if the file is not found at all).
rem 2 Wrong syntax 
rem An invalid switch will only print an error message in error stream.

SET testdir=C:\xampp\htdocs

echo %ERRORLEVEL%
subst | findstr /C:"Z:\\: =>" 
if errorlevel 0 (
echo "Mapped ERRORLEVEL 0"
) else (
echo "NotMapped"
)
echo THIS ERRROR LEVE = %ERRORLEVEL%



rem pause
