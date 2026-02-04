@echo off
title Scanner del Sistema
color 0B

echo ===== SCANNER INICIADO ===== >> log.txt

echo.
echo Ejecutando comprobacion de archivos del sistema...
echo Esto puede tardar varios minutos...
echo.

sfc /scannow

echo.
echo ===== SCANNER FINALIZADO ===== >> log.txt
echo Proceso terminado.
pause
