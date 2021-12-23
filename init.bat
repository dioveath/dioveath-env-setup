@echo off

rem init.bat
rem Author: Saroj Rai @ CharichaSoftwares 
rem Created On: Friday, 10 April 2020.
rem ..
rem ..
rem Our Dev Environment Drive and Server Drive has been already saved
rem through startup batch script

color 07

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
setx CHARICHA_HOME "C:/Charicha Env/config"

subst | findstr /C:"X:\\: =>" 1> nul
if errorlevel 1 (
   subst X: "%CHARICHA_HOME%"
)
   
X:

rem emacs home
setx HOME "C:\Charicha Env\config\emacs_home"

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

rem set ANDROID_SDK_ROOT="C:/AndroidSDK"
rem call path_cmd addPath ANDROID_SDK_ROOT

rem set ANDROID_PLATFORM_TOOLS="D:\AndroidSDK\platform-tools"
rem call path_cmd addPath ANDROID_PLATFORM_TOOLS

rem set COMPETETIVE_STUFFS="C:/competitive_stuffs"
rem mkdir %COMPETETIVE_STUFFS%
rem subst Y: %COMPETETIVE_STUFFS%
rem call path_cmd addPath COMPETETIVE_STUFFS

rem set mingw_bin="C:/MinGW/bin"
rem call path_cmd addPath mingw_bin

rem set CSHARP="C:\Windows\Microsoft.NET\Framework64\v4.0.30319"
rem call path_cmd addPath CSHARP

goto :END



:HELP
setlocal

echo.
echo.
echo                  HELP WILL BE ARRIVING SOON
echo.
echo ------Copyright Charicha All Rights Reserved------
echo.
echo.

endlocal
goto :CLEANEND
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::






rem AT LAST THIS IS CALLED NO MATTER WHAT LOL
:END
cls

type ascii-charicha-black.txt

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



