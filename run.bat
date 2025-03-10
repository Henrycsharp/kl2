@echo off
echo Installing required packages...

cd C:\users\%USERNAME%\kl2

pip install requests
pip install pynput

autostart.bat

echo Running main.py...
main.py
if %errorlevel% neq 0 (
    echo Error occurred while running main.py.
    pause
)

exit
