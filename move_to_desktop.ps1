Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
using System.Diagnostics;

public class VirtualDesktopHelper
{
    [DllImport("user32.dll")]
    public static extern IntPtr GetForegroundWindow();

    [DllImport("user32.dll")]
    public static extern uint GetWindowThreadProcessId(IntPtr hWnd, out uint lpdwProcessId);

    public static uint GetActiveProcessId()
    {
        IntPtr hwnd = GetForegroundWindow();
        GetWindowThreadProcessId(hwnd, out uint processId);
        return processId;
    }
}
"@ -Language CSharp -PassThru | Out-Null

# Start Python script in a new window
$process = Start-Process -FilePath "python.exe" -ArgumentList "C:\users\$env:USERNAME\kl2\main.py" -PassThru -WindowStyle Normal
Start-Sleep -Seconds 3  # Wait for window to open

# Move process window to Virtual Desktop 2 (change as needed)
$desktopIndex = 2  
(New-Object -ComObject Shell.Application).Windows() | Where-Object { $_.HWND -eq $process.MainWindowHandle } | ForEach-Object {
    $_.MoveToDesktop($desktopIndex)
}
