$ErrorActionPreference = "Stop"

function Test-DotNetDesktop8 {
    try {
        $runtimes = & dotnet --list-runtimes 2>$null
        return [bool]($runtimes | Where-Object { $_ -match "^Microsoft\.WindowsDesktop\.App 8\." })
    } catch {
        return $false
    }
}

function Get-DotNetArch {
    switch ([System.Runtime.InteropServices.RuntimeInformation]::ProcessArchitecture.ToString().ToLowerInvariant()) {
        "x64" { return "x64" }
        "x86" { return "x86" }
        "arm64" { return "arm64" }
        default { return "x64" }
    }
}

Write-Host "Checking .NET 8 Windows Desktop Runtime..."
if (Test-DotNetDesktop8) {
    Write-Host ".NET 8 Windows Desktop Runtime is already installed."
    exit 0
}

Write-Host ".NET 8 Windows Desktop Runtime was not found."

$winget = Get-Command winget -ErrorAction SilentlyContinue
if ($winget) {
    Write-Host "Trying winget install..."
    try {
        winget install --id Microsoft.DotNet.DesktopRuntime.8 --source winget --accept-package-agreements --accept-source-agreements
        if (Test-DotNetDesktop8) {
            Write-Host "Installation completed."
            exit 0
        }
    } catch {
        Write-Host ("winget install failed: " + $_.Exception.Message)
    }
}

Write-Host "Trying Microsoft dotnet-install script..."
$arch = Get-DotNetArch
$tempDir = Join-Path $env:TEMP "keyboard-stats-dotnet-install"
$installScript = Join-Path $tempDir "dotnet-install.ps1"
New-Item -ItemType Directory -Path $tempDir -Force | Out-Null

try {
    Invoke-WebRequest -Uri "https://dot.net/v1/dotnet-install.ps1" -OutFile $installScript -UseBasicParsing
    & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $installScript -Channel 8.0 -Runtime windowsdesktop -Architecture $arch
    if (Test-DotNetDesktop8) {
        Write-Host "Installation completed."
        exit 0
    }
} catch {
    Write-Host ("dotnet-install failed: " + $_.Exception.Message)
}

Write-Host "Automatic install did not complete. Opening the official download page."
Start-Process "https://dotnet.microsoft.com/download/dotnet/8.0"
exit 1
