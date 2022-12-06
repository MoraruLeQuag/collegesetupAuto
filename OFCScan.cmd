@echo off
CHCP 65001
title College Setup

reg query HKU\S-1-5-19 1>nul 2>nul || (echo Erreur&goto :Admin)
Reg.exe add HKLM /F >nul 2>&1
if %errorlevel% neq 0 start "" /wait /I /min powershell -NoProfile -Command start -verb runas "'%~s0'" && exit /b
 

cls
if exist "C:\Users\%username%\Desktop\SetupCollege" (
  cd "C:\Users\%username%\Desktop\SetupCollege"
  ) else (
  mkdir "C:\Users\%username%\Desktop\SetupCollege"
  cd "C:\Users\%username%\Desktop\SetupCollege"
  rem installation des dépendances
  powershell wget -outf C:\Users\%username%\Desktop\SetupCollege\iaca.txt https://raw.githubusercontent.com/MoraruLeQuag/CollegeSetup/main/iaca.txt
)
cls
netsh exec C:\Users\%UserName%\Desktop\SetupCollege\iaca.txt
echo Découverte Réseau activée !
rem powershell start "\\192.168.224.3\OFC SCAN\autopcp.exe"
start C:\Users\%UserName%\Desktop\SetupCollege\iaca.txt

echo apres installation complete, l'ordinateur va redémarrer...
powershell wget -outf C:\Users\%username%\Desktop\SetupCollege\Iaca.cmd https://github.com/MoraruLeQuag/collegesetupAuto/raw/main/Iaca.cmd
pause
(C:\ProgramData\Microsoft\Windows\"Start Menu"\Programs\Startup)
powershell Restart-Computer -Force

:Admin
rem Return si lancé sans droits admin
echo Ce script doit être lance en Administrateur.
pause >nul