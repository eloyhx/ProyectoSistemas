@echo off
title Mantenimiento PC v2
color 0A

:menu
cls
echo ==========================
echo   MANTENIMIENTO DEL PC
echo ==========================
echo 1. Limpiar temporales
echo 2. Scanner del sistema
echo 3. Red (ipconfig)
echo 4. Ver conexiones (netstat)
echo 5. Salir
echo ==========================

set /p op=Elige una opcion:

if "%op%"=="1" (
    del /q /f /s %temp%\*.* > nul
    echo Limpieza completada
    pause
)

if "%op%"=="2" call Scanner.bat

if "%op%"=="3" (
    ipconfig /flushdns
    ipconfig /release
    ipconfig /renew
    pause
)

if "%op%"=="4" (
    netstat -ano > conexiones.txt
    echo Conexiones guardadas en conexiones.txt
    pause
)

if "%op%"=="5" exit

goto menu
