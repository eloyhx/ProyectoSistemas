@echo off
chcp 65001 > nul
title Mantenimiento del PC - Menú Interactivo
color 0D
mode con: cols=80 lines=25

:: ======================
:: MENÚ PRINCIPAL
:: ======================
:inicio
cls
color 0D
title Mantenimiento del PC - Menú Interactivo
echo ====================================
echo         MANTENIMIENTO DEL PC        
echo ====================================
echo 1. Limpiar archivos temporales
echo 2. Liberar caché DNS
echo 3. Desfragmentar disco duro
echo 4. Generar informe del sistema
echo 5. Buscar y eliminar malware
echo 6. Vaciar la papelera de reciclaje 🗑️
echo 7. Copia de seguridad
echo 8. Reparar disco
echo 9. Reparar archivos (SFC)
echo 10. Mantenimiento DISM
echo 12. Scanner de seguridad
echo 13. Netstat / Red
echo 14. Salir
echo ====================================
set /p opcion="Selecciona una opción (1-14): "

if "%opcion%"=="1" goto limpiar_temporales
if "%opcion%"=="2" goto liberar_dns
if "%opcion%"=="3" goto desfragmentar
if "%opcion%"=="4" goto generar_informe
if "%opcion%"=="5" goto buscar_malware
if "%opcion%"=="6" goto vaciar_papelera
if "%opcion%"=="7" goto copia_seguridad
if "%opcion%"=="8" goto reparar_disco
if "%opcion%"=="9" goto menu_sfc
if "%opcion%"=="10" goto dism
if "%opcion%"=="12" goto scanner
if "%opcion%"=="13" goto netstat_menu
if "%opcion%"=="14" exit

goto inicio


:: ======================
:: FUNCIONES PRINCIPALES
:: ======================
:limpiar_temporales
cls
cleanmgr /sagerun:1
pause
goto inicio

:liberar_dns
cls
ipconfig /flushdns
pause
goto inicio

:desfragmentar
cls
set /p confirmar="¿Deseas desfragmentar el disco C:? (s/n): "
if /I "%confirmar%"=="s" defrag C:
pause
goto inicio

:generar_informe
cls
systeminfo > C:\informe_sistema.txt
echo Informe generado en C:\informe_sistema.txt
pause
goto inicio

:buscar_malware
cls
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 2
pause
goto inicio

:vaciar_papelera
cls
rd /s /q %systemdrive%\$Recycle.Bin
pause
goto inicio

:copia_seguridad
cls
set /p origen="Ruta de origen: "
set /p destino="Ruta de destino: "
xcopy "%origen%" "%destino%" /E /H /C /I
pause
goto inicio

:reparar_disco
cls
set /p unidad="Letra de unidad (ej: C): "
chkdsk %unidad%: /F /R
pause
goto inicio


:: ======================
:: SUBMENÚ SFC
:: ======================
:menu_sfc
cls
color 0E
echo ====================================
echo     REPARACIÓN DE ARCHIVOS (SFC)
echo ====================================
echo 1. Verificar archivos
echo 2. Reparar archivos
echo 3. Volver
echo ====================================
set /p opcion="Selecciona una opción (1-3): "

if "%opcion%"=="1" goto sfc_verificar
if "%opcion%"=="2" goto sfc_corregir
if "%opcion%"=="3" goto inicio
goto menu_sfc

:sfc_verificar
cls
sfc /verifyonly
pause
goto menu_sfc

:sfc_corregir
cls
sfc /scannow
pause
goto menu_sfc


:: ======================
:: DISM
:: ======================
:dism
cls
color 0B
echo ================================
echo     MANTENIMIENTO CON DISM
echo ================================
pause
DISM /Online /Cleanup-Image /CheckHealth
DISM /Online /Cleanup-Image /ScanHealth
DISM /Online /Cleanup-Image /RestoreHealth
sfc /scannow
pause
goto inicio


:: ======================
:: SCANNER DE SEGURIDAD
:: ======================
:scanner
cls
color 0C
echo ================================
echo        SCANNER DE SEGURIDAD
echo ================================
echo 1. Escaneo rapido (Defender)
echo 2. Escaneo completo (Defender)
echo 3. Volver
echo ================================
set /p opcion="Selecciona una opción (1-3): "

if "%opcion%"=="1" goto scan_rapido
if "%opcion%"=="2" goto scan_completo
if "%opcion%"=="3" goto inicio
goto scanner

:scan_rapido
cls
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 1
pause
goto scanner

:scan_completo
cls
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 2
pause
goto scanner


:: ======================
:: NETSTAT / RED
:: ======================
:netstat_menu
cls
color 09
echo ================================
echo        NETSTAT / RED
echo ================================
echo 1. Ver conexiones activas
echo 2. Ver puertos en escucha
echo 3. Guardar informe en TXT
echo 4. Volver
echo ================================
set /p opcion="Selecciona una opción (1-4): "

if "%opcion%"=="1" goto netstat_activo
if "%opcion%"=="2" goto netstat_puertos
if "%opcion%"=="3" goto netstat_log
if "%opcion%"=="4" goto inicio
goto netstat_menu

:netstat_activo
cls
netstat -ano
pause
goto netstat_menu

:netstat_puertos
cls
netstat -an | find "LISTEN"
pause
goto netstat_menu

:netstat_log
cls
netstat -ano > C:\netstat_reporte.txt
echo Informe guardado en C:\netstat_reporte.txt
pause
goto netstat_menu
