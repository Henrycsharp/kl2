@echo off
echo Installing required packages...

pip install requests
pip install pynput

echo Running main.py...
pythonw main.py

pause
