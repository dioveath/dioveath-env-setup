@echo off

rem init.bat
rem Author: Saroj Rai @ CharichaSoftwares 
rem Created On: Friday, 10 April 2020.
rem ..
rem ..
rem Our Dev Environment Drive and Server Drive has been already saved
rem through startup batch script

color 07

subst | findstr /C:"X:\\: =>" 1> nul
if errorlevel 1 (
   subst X: "%CHARICHA_HOME%"
)
   
cd /d %CHARICHA_HOME%


if [%1]==[] (goto :NOARG)
if [%1]==[new] (goto :NEW) 
if [%1]==[help] (goto :HELP)

if [%1]==[addtopath] (
set newpathvar=%2
call path_cmd addPath newpathvar
) else (goto :CLEANEND)


goto :END


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:NOARG

call path_cmd addPath CHARICHA_HOME

rem set android_platform_tools="A:\AndriodDev\AndroidSDK\platform-tools"
rem call path_cmd addPath android_platform_tools

rem set charicha_database="C:/xampp/mysql/bin"
rem call path_cmd addPath charicha_database

rem set flutter_path="C:/src/flutter/bin"
rem call path_cmd addPath flutter_path

rem set node_js_path="C:\Program Files\nodejs"
rem call path_cmd addPath node_js_path

rem set npm_modules_path="C:\Users\Charicha Soft\AppData\Roaming\npm"
rem call path_cmd addPath npm_modules_path

set ANDROID_SDK_ROOT="C:/AndroidSDK"
call path_cmd addPath ANDROID_SDK_ROOT

set ANDROID_PLATFORM_TOOLS="D:\AndroidSDK\platform-tools"
call path_cmd addPath ANDROID_PLATFORM_TOOLS

set COMPETETIVE_STUFFS="C:/competitive_stuffs"
mkdir %COMPETETIVE_STUFFS%
subst Y: %COMPETETIVE_STUFFS%
call path_cmd addPath COMPETETIVE_STUFFS

rem set mingw_bin="C:/MinGW/bin"
rem call path_cmd addPath mingw_bin

set CSHARP="C:\Windows\Microsoft.NET\Framework64\v4.0.30319"
call path_cmd addPath CSHARP


goto :END



::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:NEW
rem setlocal
::initializes for a new project
echo.
echo ---------------------------------------------------------------------------
echo SETTING UP YOUR NEW PROJECT
echo.
echo Fill up the details of your new project..
echo.
set /p project_name="New Project Name:"
setx PROJECT_NAME "%project_name%"


Setlocal EnableDelayedExpansion
set /p project_path="Project Path:"
set Project_Path=!project_path:/=\!
setx PROJECT_PATH "%project_path%"
Endlocal


set /p project_details="Project Summary:"
setx PROJECT_DESC "%project_details%"

echo.
echo.
echo Restart your CMD 'CTRL' + 'ALT' + '+'
echo.
echo.

pause
exit
rem NOTE: In Future PROJECT_DESC should be kind of readme file. So, developer can
rem change the description/summary on the go

rem endlocal
goto :END



::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

rem if %project_name%==doko (goto :PROJECT_DOKO) else (goto :END)
rem :PROJECT_DOKO
rem goto :END
rem ------------------------------------------------------------

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::



:HELP
setlocal

echo.
echo.
echo                  HELP WILL BE ARRIVING SOON
echo.
echo ------Copyright Charicha Softwares All Rights Reserved------
echo.
echo.

endlocal
goto :CLEANEND


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::



rem: TODO: SOMETHING I NEED TO DIG DEEPER IN FUTURE
rem :ADDTOPATH
rem setlocal
:: inpath checks if path is already in PATH(environment) or not
:: to include it only if it is not already
:: see inpath.bat for more details

rem if exist %~1 (

rem set path_par=%~1
rem echo %path_par%
rem call path_cmd addPath path_par
rem echo %ERRORLEVEL%
rem if errorlevel 0 (echo ERROR 0) else (echo ERROR NO 0)
rem echo %ERRORLEVEL%
rem if errorlevel 1 (echo ERROR 1) else (echo ERROR NO 1)
rem echo %ERRORLEVEL%
rem if errorlevel 2 (echo ERROR 2) else (echo ERROR NO 2)


rem ) else (
rem echo Directory doesn't exist!
rem )

rem endlocal
rem goto :CLEANEND



::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


rem AT LAST THIS IS CALLED NO MATTER WHAT LOL
:END
rem X:
rem to set it to config only if it's at X: drive to avoid unnecessary errors 
rem if %cd%==X:\ (
rem cd config
rem ) else (
rem cd X:\config
rem )
rem echo on

cls

type ascii-charicha-black.txt
cd ..

echo           Current Project : %PROJECT_NAME%
echo           Project Path : %PROJECT_PATH%
echo           Summary: %PROJECT_DESC%

rem echo on

subst | findstr /C:"Z:\\: => %PROJECT_PATH%" 1> nul
rem if findstr couldn't find the string returning 1
if errorlevel 1 (

   subst | findstr /C:"Z:\\: =>" 1> nul

   if not errorlevel 1 (
      echo. 
      echo --------- Removing old SUBSTed Z: drive --------------------------------
      subst Z: /D
   )  

   if defined project_path (
      echo.
      echo --------- Mapping the project path to Z: Drive -------------------------
      subst Z: "%PROJECT_PATH%"
   )
)

echo.
echo.
echo              Copyrights CharichaSoftwares All Rights Reserved
echo _________________________________________________________________________
echo.
echo _________________________________________________________________________
echo.
echo.

subst | findstr /C:"Z:\\: =>" 1> nul
if errorlevel 1 (
echo           Let's create a new project,
echo           Type 'init new'
echo           Let's create something ridiculus
echo.
echo.
) else (
  Z:
)




:CLEANEND



