@echo off
title Mantenimiento PC v2
color 0A

:: ==============================
:: LOG DE INICIO
:: ==============================
echo ===== INICIO MANTENIMIENTO ===== >> log.txt
date /t >> log.txt
time /t >> log.txt
echo. >> log.txt


:menu
cls
echo ======================================
echo        MANTENIMIENTO DEL PC
echo ======================================
echo.
echo 1. Limpiar archivos temporales
echo 2. Scanner del sistema (SFC)
echo 3. Reparar red (ipconfig)
echo 4. Ver conexiones activas (netstat)
echo 5. Salir
echo.
echo ======================================

set /p op=Elige una opcion: 


:: ==============================
:: OPCION 1 - LIMPIEZA TEMPORALES
:: ==============================
if "%op%"=="1" (
    echo Limpieza de temporales ejecutada >> log.txt

    echo.
    echo Limpiando archivos temporales...
    del /q /f /s %temp%\*.* > nul

    echo Limpieza completada.
    pause
    goto menu
)


:: ==============================
:: OPCION 2 - SCANNER
:: ==============================
if "%op%"=="2" (
    echo Scanner SFC ejecutado >> log.txt

    echo.
    echo Ejecutando verificacion del sistema...
    call Scanner.bat

    goto menu
)


:: ==============================
:: OPCION 3 - RED
:: ==============================
if "%op%"=="3" (
    echo Reparacion de red ejecutada >> log.txt

    echo.
    echo Reparando red...
    ipconfig /flushdns
    ipconfig /release
    ipconfig /renew

    echo Red reparada.
    pause
    goto menu
)


:: ==============================
:: OPCION 4 - NETSTAT
:: ==============================
if "%op%"=="4" (
    echo Netstat ejecutado >> log.txt

    echo.
    echo Analizando conexiones...
    netstat -ano > conexiones.txt

    echo Conexiones guardadas en conexiones.txt
    pause
    goto menu
)


:: ==============================
:: OPCION 5 - SALIR
:: ==============================
if "%op%"=="5" (
    echo ===== FIN DEL PROGRAMA ===== >> log.txt
    echo.
    echo Cerrando programa...
    exit
)


:: ==============================
:: OPCION INVALIDA
:: ==============================
echo.
echo Opcion no valida.
pause
goto menu
