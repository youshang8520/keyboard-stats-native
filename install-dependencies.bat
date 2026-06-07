@echo off
cd /d "%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0install-dotnet8-desktop.ps1"
if errorlevel 1 (
    echo.
    echo Dependency installation did not complete. Please follow the instructions above.
    pause
    exit /b 1
)
echo.
echo Dependency check completed. This window will close in 3 seconds.
timeout /t 3 /nobreak >NUL
exit /b 0
