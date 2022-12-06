Reg.exe add HKLM /F >nul 2>&1
if %errorlevel% neq 0 start "" /wait /I /min powershell -NoProfile -Command start -verb runas "'%~s0'" && exit /b
rem installation des dépendances
if not exist "C:\Users\%username%\Desktop\SetupCollege" GOTO Install-Folder

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
pause>nul


:Admin
rem Return si lancé sans droits admin
echo Ce script doit être lance en Administrateur.
pause >nul