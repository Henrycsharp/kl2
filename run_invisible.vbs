Set WshShell = CreateObject("WScript.Shell")
WshShell.Run "cmd /c start /min python C:\users\%USERNAME%\kl2\main.py", 0, False
