@echo off
set "startupFolder=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "batFilePath=C:\path\to\your\run.bat"

:: Check if the batch file already exists in the Startup folder
if not exist "C:\Users\%USERNAME%\kl2\run.bat" (
    copy "%batFilePath%" "%startupFolder%t"
    echo run.bat has been added to the Startup folder.
) else (
    echo run.bat is already in the Startup folder.
)
exit
