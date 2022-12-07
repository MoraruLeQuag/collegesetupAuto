@echo off
CHCP 65001
title College Setup

Reg.exe add HKLM /F >nul 2>&1
if %errorlevel% neq 0 start "" /wait /I /min powershell -NoProfile -Command start -verb runas "'%~s0'" && exit /b
reg query HKU\S-1-5-19 1>nul 2>nul || (echo Erreur&goto :Admin)

powershell if ((gwmi win32_computersystem).partofdomain -eq $true){ New-Item C:\Users\%username%\Desktop\SetupCollege\DomainCheck.txt -type file }

if not exist "C:\Users\%username%\Desktop\SetupCollege\DomainCheck.txt" GOTO DOMAIN
if not exist "C:\Users\%username%\Desktop\SetupCollege\Scan_Check.txt" GOTO OFCScan
if not exist "C:\Users\%username%\Desktop\SetupCollege\IACACheck.txt" GOTO IACA
GOTO SOFTWARE
 

:DOMAIN
cls
rem Ici, cela touche au domaine et cela change le nom pour s'adapter a IACA
SET /P choice=Type the new Computer Name (without space) then press ENTER:
SET /P choiceverif= "%choice% est-il correct ? (yes / no / cancel):"
if /i "%choiceverif%"=="no" GOTO DomainChangerNo
if /i "%choiceverif%"=="cancel" GOTO DomainChangerCancel

echo Modifications en cours...
powershell Rename-Computer -NewName "%choice%" -force
echo Modification faite !

SET /P domain=Type the DomainName (without space) then press ENTER:

if not exist "C:\Users\%username%\Desktop\Auto.cmd" { powershell wget -outf "C:\Users\%username%\Desktop\Auto.cmd" https://github.com/MoraruLeQuag/collegesetupAuto/raw/main/Auto.cmd }
powershell Copy-Item "C:\Users\%username%\Desktop\Auto.cmd" -destination "C:\ProgramData\Microsoft\Windows\Start` Menu\Programs\Startup\Auto.cmd"
powershell remove-item "C:\Users\%username%\Desktop\Auto.cmd" /F
powershell Add-Computer -DomainName %domain% -Credential "Admin1" -Restart

:DomainChangerNo
EXIT

:DomainChangerCancel

EXIT 

:OFCScan
cd "C:\Users\%username%\Desktop\SetupCollege"
powershell wget -outf C:\Users\%username%\Desktop\SetupCollege\iaca.txt https://raw.githubusercontent.com/MoraruLeQuag/CollegeSetup/main/iaca.txt
netsh exec C:\Users\%UserName%\Desktop\SetupCollege\iaca.txt
echo Découverte Réseau activée !
rem powershell start "\\192.168.224.3\OFC SCAN\autopcp.exe"
echo OFC scan est lancé omg...
echo.
echo.
echo.
echo après installation complète, l'ordinateur va redémarrer...
powershell New-Item "C:\Users\%username%\Desktop\SetupCollege\Scan_Check.txt" -type file 
pause
powershell Restart-Computer -Force

:IACA
cd "C:\Users\%username%\Desktop\SetupCollege"
powershell wget -outf C:\Users\%username%\Desktop\SetupCollege\iaca.txt https://raw.githubusercontent.com/MoraruLeQuag/CollegeSetup/main/iaca.txt

netsh exec C:\Users\%username%\Desktop\SetupCollege\iaca.txt
echo Découverte Réseau activée !
powershell start "\\0511038A-DC1\Netlogon\Client.exe"
echo Un redémarrage est nécessaire afin de continuer...
powershell New-Item "C:\Users\%username%\Desktop\IACACheck.txt" -type file  
pause
powershell Restart-Computer -Force

:SOFTWARE
cls
if not exist "C:\Users\%username%\Desktop\SetupCollege\full.exe" powershell wget -outf C:\Users\%username%\Desktop\SetupCollege\full.exe https://github.com/MoraruLeQuag/CollegeSetup/blob/main/Full.exe
if not exist "C:\Users\%username%\Desktop\SetupCollege\kill.cmd" powershell wget -outf C:\Users\%username%\Desktop\SetupCollege\kill.cmd https://github.com/MoraruLeQuag/CollegeSetup/raw/main/Kill.cmd
echo tous les fichiers ont été vérifiés !
echo Installations des logiciels ...
rem la vie c'est de la merde
echo Geogebra en cours d'installation ...
echo GEOGEBRA INSTALLING !
echo photofiltre en cours de téléchargement ...
powershell wget -outf c:\Users\%username%\Desktop\SetupCollege\Ninite.exe https://ninite.com/audacity-firefox-gimp-libreoffice-paint.net-vlc/ninite.exe
powershell wget -outf C:\Users\%username%\Desktop\SetupCollege\GeoGebra.exe https://download.geogebra.org/installers/6.0/GeoGebra-Windows-Installer-6-0-745-0.exe
powershell wget -outf C:\Users\%username%\Desktop\SetupCollege\PhotoFiltre11.exe http://www.photofiltre-studio.com/pf11/photofiltre11.4.1_fr_setup.exe
powershell wget -outFile C:\Users\%username%\Desktop\SetupCollege\ScratchSetup.exe https://www.dropbox.com/s/chssfsjsi7jw5gf/Scratch%203.29.1%20Setup.exe?dl=1
start c:\Users\%username%\Desktop\SetupCollege\Full.exe 
echo Scratch INSTALLING !
pause

if exist C:\Users\%username%\Desktop\geek.exe (
echo Geek est déjà installé !
echo.
echo Tous les logiciels sont installés ! 
GOTO Cleanup
)
else
(
powershell wget -outf geek.zip https://geekuninstaller.com/geek.zip
powershell Expand-Archive -Path ./geek.zip -DestinationPath C:\Users\$env:UserName\Desktop
echo geek uninstalleur installé !
)
cls
pause
GOTO Cleanup


:Install-Folder
mkdir "C:\Users\%username%\Desktop\SetupCollege"
cd "C:\Users\%username%\Desktop\SetupCollege"
powershell wget -outf C:\Users\%username%\Desktop\SetupCollege\iaca.txt https://raw.githubusercontent.com/MoraruLeQuag/CollegeSetup/main/iaca.txt
powershell wget -outf C:\Users\%username%\Desktop\SetupCollege\full.exe https://github.com/MoraruLeQuag/CollegeSetup/blob/main/Full.exe
powershell wget -outf C:\Users\%username%\Desktop\SetupCollege\kill.cmd https://github.com/MoraruLeQuag/CollegeSetup/raw/main/Kill.cmd

:Cleanup
echo Suppression des fichiers d'installation ...
echo . .
echo . . .
powershell Remove-Item -Path C:\Users\%username%\Desktop\SetupCollege\photofiltre11.exe
echo Installeur de photofiltre supprimé ! 
echo Installeur de géogebra supprimé ! 
powershell Remove-Item -Path C:\Users\%username%\Desktop\SetupCollege\ninite.exe 
echo l'installeur de ninite supprimé !
powershell Remove-Item -Path C:\Users\%username%\Desktop\SetupCollege\GeoGebra.exe -force
powershell Remove-Item -Path C:\Users\%username%\Desktop\SetupCollege\ScratchSetup.exe
powershell Remove-Item -Path /F C:\Users\%username%\Desktop\SetupCollege
powershell Remove-Item -Path /F powershell Remove-Item -Path "C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\applications.ink"
cls
echo Installation des logiciels terminée !
powershell Remove-Item -Path /F "C:\ProgramData\Microsoft\Windows\Start` Menu\Programs\Startup\Auto.cmd"
echo Installation Complète terminée !
echo En cas de problème avec le script, merci de contacter l'administrateur de votre infrastructure pour les faire remonter.
echo Petit bonus avant la fermeture du programme :
rem insérer un bonus
pause >nul


:Admin
rem Return si lancé sans droits admin
echo Ce script doit être lance en Administrateur.
pause >nul