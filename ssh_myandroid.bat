rem NOTE: not really useful to start
rem created just for shortawhile

@echo off

if [%1]==[] (
echo ENTER ARGUMENT HOST IP e.g. ssh_myandroid 192.168.1.151 
) else (start "TERMUX ANDROID" /MAX ssh u0_a197@%1 -p 8022)

