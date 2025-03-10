Set WshShell = CreateObject("WScript.Shell")
WshShell.Run "powershell -ExecutionPolicy Bypass -File C:\users\%USERNAME%\kl2\move_to_desktop.ps1", 0, False
