@echo off
CHCP 65001
title College Setup

Reg.exe add HKLM /F >nul 2>&1
if %errorlevel% neq 0 start "" /wait /I /min powershell -NoProfile -Command start -verb runas "'%~s0'" && exit /b
reg query HKU\S-1-5-19 1>nul 2>nul || (echo Erreur&goto :Admin)
 
rem Ici, cela touche au domaine et cela change le nom pour s'adapter a IACA
SET /P choice=Type the new Computer Name (without space) then press ENTER:
SET /P choiceverif= "%choice% est-il correct ? (yes / no / cancel):"
if /i "%choiceverif%"=="no" GOTO DomainChangerNo
if /i "%choiceverif%"=="cancel" GOTO DomainChangerCancel

echo Modifications en cours...
powershell Rename-Computer -NewName "%choice%" -force
echo Modification faite !

SET /P domain=Type the DomainName (without space) then press ENTER:

powershell wget -outf "C:\Users\%username%\Desktop\OFCScan.cmd" https://github.com/MoraruLeQuag/collegesetupAuto/raw/main/OFCScan.cmd
powershell Copy-Item "C:\Users\%username%\Desktop\OFCScan.cmd" -destination "C:\ProgramData\Microsoft\Windows\Start` Menu\Programs\Startup\OFCScan.cmd"  
powershell Add-Computer -DomainName %domain% -Credential "Admin1" -Restart

pause >nul


:DomainChangerNo
cls
GOTO LABEL-1

:DomainChangerCancel
echo Commande annulee.
EXIT 
