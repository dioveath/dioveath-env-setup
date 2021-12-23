

@echo off
rem why is it here?? should be in init.bat
set home=C:\Charicha Env\config\emacs_home

rem if argument not given, open emacs normally 
rem if %1.==. (goto WITHOUTARG) else (goto WITHARG)
rem -l to load .emacs file

rem call "C:\Emacs\x86_64\bin\runemacs.exe" --debug-init -name Charicha %* 
rem call "C:\Emacs\x86_64\bin\runemacs.exe" --debug-init -name DEBUG -q --load "~/.emacs"

call "C:\Emacs\x86_64\bin\emacsclientw.exe" -c -n -a "" %*
