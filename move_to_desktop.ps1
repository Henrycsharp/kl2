Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class VirtualDesktopManager
{
    [DllImport("user32.dll")]
    public static extern IntPtr GetForegroundWindow();

    [DllImport("user32.dll")]
    public static extern uint GetWindowThreadProcessId(IntPtr hWnd, out uint lpdwProcessId);

    [DllImport("user32.dll")]
    public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);

    public static uint GetActiveProcessId()
    {
        IntPtr hwnd = GetForegroundWindow();
        GetWindowThreadProcessId(hwnd, out uint processId);
        return processId;
    }
}
"@ -Language CSharp -PassThru | Out-Null

$process = Start-Process -FilePath "python" -ArgumentList "C:\users\%USERNAME%\kl2\main.py" -PassThru
Start-Sleep -Seconds 2  # Wait for window to open

$desktopIndex = 2  # Change this to the virtual desktop number
(New-Object -ComObject Shell.Application).Windows() | Where-Object { $_.HWND -eq $process.MainWindowHandle } | ForEach-Object {
    $_.MoveToDesktop($desktopIndex)
}
