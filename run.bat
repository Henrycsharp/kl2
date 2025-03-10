@echo off
echo Installing required packages...

pip install requests
pip install pynput

echo Adding autostart rule...
autostart.bat

echo Running main.py...
pythonw main.py

pause
