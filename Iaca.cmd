@echo off
CHCP 65001
title College Setup

reg query HKU\S-1-5-19 1>nul 2>nul || (echo Erreur&goto :Admin)
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "0" /f

rem installation IACA
:LABEL-3
if exist "C:\Users\%username%\Desktop\SetupCollege\iaca.txt" (
  cd "C:\Users\%username%\Desktop\SetupCollege"
  ) else (
  mkdir "C:\Users\%username%\Desktop\SetupCollege"
  rem installation des dépendances
  powershell wget -outf C:\Users\%username%\Desktop\SetupCollege\iaca.txt https://raw.githubusercontent.com/MoraruLeQuag/CollegeSetup/main/iaca.txt
  )
cls
netsh exec C:\Users\%username%\Desktop\SetupCollege\iaca.txt
echo Découverte Réseau activée !
powershell start "\\0511038A-DC1\Netlogon\Client.exe"
echo Un redemarrage est necessaire afin de continuer...
powershell Remove-Item -Path "C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Iaca.ink"
powershell wget -outf C:\Users\%username%\Desktop\SetupCollege\Applications.cmd {chemin github}
powershell New-Item -ItemType SymbolicLink -Path "C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" -Name "applications.lnk" -Value "C:\Users\%username%\Desktop\SetupCollege\applications.cmd"
pause 
powershell Restart-Computer -Force

:Admin
rem Return si lancé sans droits admin
echo Ce script doit être lance en Administrateur.
pause >nul