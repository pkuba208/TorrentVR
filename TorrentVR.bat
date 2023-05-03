@echo off
setlocal enabledelayedexpansion
echo The downloads use torrents, so you will have to get a magnet link from sites like rutracker.org
pause
:menu
echo.
echo 1. PCVR
echo 2. Quest Standalone
echo 3. Exit
echo 4. Disable auto updates(if ur still on v50). Keep in mind, that you need to redo this on every reboot of the quest
echo 5. Re-enable auto updates if you've done nr.4 and want to enable updates again
set /p choice=Enter your choice: 

if "%choice%"=="1" (
    goto pcvr
)

if "%choice%"=="2" (
    echo You chose option 2
    goto torrenter
)

if "%choice%"=="3" (
    exit
)
if "%choice%"=="4" (
    goto disableupdates
)
)
if "%choice%"=="5" (
    goto enableautoupdates
)
REM had to use goto, beacuse somehow the variable is empty no matter what I do when I execute it inside the if statement
:disableupdates
REM Running both the commands to make sure that at least one of them works(they both do the same thing)
adb shell pm disable-user com.oculus.updater
adb shell pm disable-user --user 0 com.oculus.updater
echo DONE
echo Click any button to return to the menu
pause
goto menu
:enableautoupdates
adb shell pm enable com.oculus.updater
echo DONE
echo Click any button to return to the menu
goto menu
:pcvr
echo To search for games, I recommend sites like rutracker
echo Also, please don't download from IGG. They're very shady
echo This is still a beta, so some bugs may exist.
echo If you notice any, please report them by posting on r/torrenter or DM'ing me on reddit
echo Made By pkuba208 under GPL v3
echo FOSS projects used to make this:
echo aria2c
echo 7zip
pause
set /p magnet=Enter the name of the torrent file:
mkdir "downloads/%gamename%"
aria2c --seed-time=0 -d "downloads/%gamename%" %magnet%
REM why the fuck do I need to do this? Idk but it works. Don't touch it
xcopy 7z.exe "downloads/%gamename%"
cd /d "downloads/%gamename%"
REM extracts game files if neccesary
set "sevenZipPath=C:\Program Files\7-Zip\7z.exe"

for /r %%i in (*.7z *.rar *.zip) do (
    echo Extracting file: %%i
    "%sevenZipPath%" x "%%i" -y
)
echo DONE
pause
:torrenter
torrenter.bat