@echo off
setlocal enabledelayedexpansion
title MINI JUEGOS BAT - PRO EDITION
color 0B

:: ============================
:: CONFIGURACION INICIAL
:: ============================
set "saldo=1000"
set "apuesta=0"

:menu
color 0B
cls
echo =================================================
echo.
echo          $$$  MINI JUEGOS PRO  $$$
echo.
echo        Tu Saldo Actual: $%saldo%
echo.
echo =================================================
echo.
echo  1. Piedra Papel Tijera  (x2 Tu apuesta)
echo  2. Adivina el numero    (x5 Tu apuesta)
echo  3. Dados                (x2 Tu apuesta)
echo  4. Cara o Cruz          (x2 Tu apuesta)
echo  5. BlackJack            (x2 Tu apuesta)
echo  6. Salir
echo.
echo =================================================
set "opcion="
set /p "opcion=> Elige un juego: "

if not defined opcion goto menu
if "%opcion%"=="1" call :apostar & goto ppt
if "%opcion%"=="2" call :apostar & goto adivina
if "%opcion%"=="3" call :apostar & goto dados
if "%opcion%"=="4" call :apostar & goto caracruz
if "%opcion%"=="5" call :apostar & goto blackjack
if "%opcion%"=="6" goto salir

echo.
echo [!] Opcion no valida.
timeout /t 2 >nul
goto menu

:: ============================
:: SISTEMA DE APUESTAS
:: ============================
:apostar
cls
echo ============================
echo      H A G A   S U   A P U E S T A
echo ============================
echo.
echo  Saldo disponible: $%saldo%
echo.
set "apuesta="
set /p "apuesta=> Cuanto quieres apostar? "

:: Validacion basica de numero
set /a "test_num=%apuesta%"
if "%test_num%"=="0" (
    echo.
    echo [!] Debes apostar una cantidad valida mayor a 0.
    timeout /t 2 >nul
    goto apostar
)

if %apuesta% GTR %saldo% (
    echo.
    echo [!] No tienes suficiente saldo!
    timeout /t 2 >nul
    goto apostar
)

:: Restamos la apuesta temporalmente (se devuelve si gana)
set /a saldo-=%apuesta%
exit /b

:: ============================
:: GESTION DE RESULTADOS
:: ============================
:ganar
:: %1 = Multiplicador
set /a "ganancia=%apuesta% * %1"
set /a saldo+=%ganancia%
color 0A
echo.
echo ============================
echo      ! G A N A S T E !
echo ============================
echo  + $%ganancia% agragados a tu cuenta.
echo.
pause
goto menu

:perder
color 0C
echo.
echo ============================
echo      ! P E R D I S T E !
echo ============================
echo  - $%apuesta% perdidos.
echo.
pause
goto menu

:empate
set /a saldo+=%apuesta%
color 0E
echo.
echo ============================
echo        ! E M P A T E !
echo ============================
echo  Recuperas tu apuesta.
echo.
pause
goto menu

:: ============================
:: 1. PIEDRA PAPEL TIJERA
:: ============================
:ppt
cls
echo ============================
echo    PIEDRA PAPEL TIJERA
echo ============================
echo.
echo 1. Piedra
echo 2. Papel
echo 3. Tijera
echo.
set "jugador="
set /p "jugador=> Elige (1-3): "

if not defined jugador goto ppt
if "%jugador%" neq "1" if "%jugador%" neq "2" if "%jugador%" neq "3" goto ppt

set /a cpu=%random% %% 3 + 1

:: Mapeo de nombres
if "%cpu%"=="1" set cpuTxt=Piedra
if "%cpu%"=="2" set cpuTxt=Papel
if "%cpu%"=="3" set cpuTxt=Tijera

if "%jugador%"=="1" set jugTxt=Piedra
if "%jugador%"=="2" set jugTxt=Papel
if "%jugador%"=="3" set jugTxt=Tijera

cls
echo.
echo  Tu:  %jugTxt%
echo  CPU: %cpuTxt%
echo.

if "%jugador%"=="%cpu%" goto empate

:: 1 gana a 3, 2 gana a 1, 3 gana a 2
if "%jugador%"=="1" if "%cpu%"=="3" call :ganar 2
if "%jugador%"=="2" if "%cpu%"=="1" call :ganar 2
if "%jugador%"=="3" if "%cpu%"=="2" call :ganar 2

:: Si no es empate ni ganaste, perdiste
goto perder

:: ============================
:: 2. ADIVINA EL NUMERO
:: ============================
:adivina
cls
echo ============================
echo     ADIVINA EL NUMERO
echo ============================
echo.
echo Estoy pensando un numero entre 1 y 10.
echo Tienes 4 intentos.
echo.

set /a numero=%random% %% 10 + 1
set /a intentos=0
set /a max_intentos=4

:loop_adivina
set /a intentos+=1
echo.
set /p "guess=> Intento %intentos%/%max_intentos%: "

if "%guess%"=="%numero%" (
    call :ganar 5
)

if %intentos% GEQ %max_intentos% (
    echo.
    echo Se acabaron los intentos! El numero era %numero%.
    goto perder
)

if %guess% LSS %numero% echo  [!] Mas ALTO
if %guess% GTR %numero% echo  [!] Mas BAJO

goto loop_adivina

:: ============================
:: 3. DADOS
:: ============================
:dados
cls
echo ============================
echo           DADOS
echo ============================
echo.
echo Lanzando los dados...
timeout /t 1 >nul
echo.

set /a jugador=%random% %% 6 + 1
set /a cpu=%random% %% 6 + 1

echo  Tu dado:   [%jugador%]
echo  Dado CPU:  [%cpu%]
echo.

if %jugador% GTR %cpu% call :ganar 2
if %jugador% LSS %cpu% goto perder
goto empate

:: ============================
:: 4. CARA O CRUZ
:: ============================
:caracruz
cls
echo ============================
echo       CARA O CRUZ
echo ============================
echo.
echo 1. Cara
echo 2. Cruz
echo.
set "eleccion="
set /p "eleccion=> Elige: "

if "%eleccion%" neq "1" if "%eleccion%" neq "2" goto caracruz

set /a moneda=%random% %% 2 + 1
if "%moneda%"=="1" set resultado=Cara
if "%moneda%"=="2" set resultado=Cruz

echo.
echo Moneda girando...
timeout /t 1 >nul
echo.
echo  SALIO: %resultado%
echo.

if "%eleccion%"=="%moneda%" call :ganar 2
goto perder

:: ============================
:: 5. BLACKJACK
:: ============================
:blackjack
cls
set /a mis_puntos=%random% %% 10 + 1
set /a mis_puntos+=%random% %% 10 + 1
set /a cpu_puntos=%random% %% 10 + 1

:bj_stat_loop
cls
echo ============================
echo       B L A C K J A C K
echo ============================
echo.
echo  Tus puntos: %mis_puntos%
echo  CPU visible: %cpu_puntos% + ?
echo.
echo 1. Pedir Carta
echo 2. Plantarse
echo.
set "bj_op="
set /p "bj_op=> Decision: "

if "%bj_op%"=="1" (
    set /a carta=%random% %% 10 + 1
    echo.
    echo  Robaste un !carta!
    set /a mis_puntos+=!carta!
    timeout /t 1 >nul
)

if %mis_puntos% GTR 21 (
    echo.
    echo  ! Te pasaste (%mis_puntos%) !
    timeout /t 2 >nul
    goto perder
)

if "%bj_op%"=="2" goto bj_dealer_turn

goto bj_stat_loop

:bj_dealer_turn
cls
echo ============================
echo       TURNO DE LA CPU
echo ============================
echo.
echo  Tu final: %mis_puntos%
echo.

:dealer_ai
echo  CPU tiene %cpu_puntos%...
timeout /t 1 >nul
if %cpu_puntos% LSS 17 (
    set /a carta_cpu=%random% %% 10 + 1
    set /a cpu_puntos+=!carta_cpu!
    echo  CPU roba !carta_cpu!
    goto dealer_ai
)

echo.
echo  CPU se planta en %cpu_puntos%.
echo.

if %cpu_puntos% GTR 21 (
    echo  CPU se paso! Ganas.
    call :ganar 2
)

if %mis_puntos% GTR %cpu_puntos% call :ganar 2
if %mis_puntos% LSS %cpu_puntos% goto perder
goto empate

:salir
echo.
echo Gracias por jugar. Saldo final: $%saldo%
timeout /t 3 >nul
exit
