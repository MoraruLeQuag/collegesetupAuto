@echo off
CHCP 65001
title College Setup

reg query HKU\S-1-5-19 1>nul 2>nul || (echo Erreur&goto :Admin)
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "0" /f
 

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
powershell New-Item -ItemType SymbolicLink -Path "C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" -Name "IACA.lnk" -Value "C:\Users\%username%\Desktop\SetupCollege\IACA.cmd"
pause

powershell Restart-Computer -Force

:Admin
rem Return si lancé sans droits admin
echo Ce script doit être lance en Administrateur.
pause >nul