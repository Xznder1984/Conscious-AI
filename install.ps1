param(
    [string]$Drive
)

# Consciousness AI - Advanced PowerShell Installer
# Features: Drive selection, auto-install, PATH setup, auto-start server

$RepoURL = "https://github.com/Xznder1984/Conscious-AI.git"
$CommandName = "conscious-ai"
$RepoName = "Conscious-AI"

Write-Host "╔════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║   Consciousness AI - Smart Installer   ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Get available drives
$AvailableDrives = Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Root -match "^[A-Z]:\\" } | Sort-Object Name

if ($AvailableDrives.Count -eq 0) {
    Write-Host "❌ No drives found!" -ForegroundColor Red
    exit 1
}

# If drive not specified, prompt user
if (-not $Drive) {
    Write-Host "📁 Available Drives:" -ForegroundColor Yellow
    $DriveList = @()
    for ($i = 0; $i -lt $AvailableDrives.Count; $i++) {
        $DriveName = $AvailableDrives[$i].Name
        Write-Host "  [$($i+1)] $DriveName"
        $DriveList += $DriveName
    }
    
    $Selection = Read-Host "🎯 Select drive number (1-$($AvailableDrives.Count))"
    $Drive = $DriveList[[int]$Selection - 1]
}

$InstallPath = "$Drive\Conscious-AI"

Write-Host ""
Write-Host "✅ Installation Details:" -ForegroundColor Green
Write-Host "   📍 Drive: $Drive"
Write-Host "   📁 Install Path: $InstallPath"
Write-Host "   🤖 AI Generated Files: $InstallPath\AI-generated"
Write-Host "   🔧 Command: $CommandName"
Write-Host ""

# Create installation directory
if (-not (Test-Path $InstallPath)) {
    Write-Host "📦 Creating installation directory..." -ForegroundColor Cyan
    New-Item -ItemType Directory -Path $InstallPath -Force | Out-Null
}

# Check if Git is installed
Write-Host "🔍 Checking for Git..." -ForegroundColor Cyan
$GitInstalled = $null -ne (Get-Command git -ErrorAction SilentlyContinue)

if (-not $GitInstalled) {
    Write-Host "❌ Git is not installed or not in PATH" -ForegroundColor Red
    Write-Host "📥 Please install Git from https://git-scm.com/download/win" -ForegroundColor Yellow
    exit 1
}

Write-Host "✅ Git found!" -ForegroundColor Green

# Clone repository
Write-Host ""
Write-Host "📥 Cloning repository..." -ForegroundColor Cyan
try {
    Set-Location $InstallPath
    git clone $RepoURL . 2>$null | Out-Null
    Write-Host "✅ Repository cloned successfully!" -ForegroundColor Green
}
catch {
    Write-Host "❌ Failed to clone repository: $_" -ForegroundColor Red
    exit 1
}

# Check if Node.js is installed
Write-Host ""
Write-Host "🔍 Checking for Node.js..." -ForegroundColor Cyan
$NodeInstalled = $null -ne (Get-Command npm -ErrorAction SilentlyContinue)

if (-not $NodeInstalled) {
    Write-Host "❌ Node.js/npm is not installed" -ForegroundColor Red
    Write-Host "📥 Please install Node.js from https://nodejs.org/" -ForegroundColor Yellow
    exit 1
}

Write-Host "✅ Node.js found!" -ForegroundColor Green

# Install npm dependencies
Write-Host ""
Write-Host "📚 Installing npm dependencies..." -ForegroundColor Cyan
Set-Location $InstallPath
npm install 2>$null | Out-Null
Write-Host "✅ Dependencies installed!" -ForegroundColor Green

# Create batch wrapper for the command
Write-Host ""
Write-Host "🔧 Setting up custom command..." -ForegroundColor Cyan

$BatchPath = "$InstallPath\$CommandName.bat"
$BatchContent = @"
@echo off
REM Consciousness AI Command Wrapper
cd /d "$InstallPath"

if "%1"=="start" (
    echo Starting Consciousness AI Server...
    npm start
) else if "%1"=="start-bg" (
    echo Starting Consciousness AI Server (Background)...
    npm run start-bg
) else if "%1"=="status" (
    echo Consciousness AI Status:
    echo Install Path: $InstallPath
    echo AI Generated Files: $InstallPath\AI-generated
    echo Server: http://localhost:3000
    echo.
    echo Usage:
    echo   $CommandName start        - Start server in foreground
    echo   $CommandName start-bg     - Start server in background
    echo   $CommandName status       - Show status
    echo   $CommandName help         - Show this help
) else if "%1"=="help" (
    echo Consciousness AI - Command Reference
    echo.
    echo Usage:
    echo   $CommandName start        - Start server in foreground
    echo   $CommandName start-bg     - Start server in background
    echo   $CommandName status       - Show status
    echo   $CommandName help         - Show this help
    echo.
    echo Server URL: http://localhost:3000
    echo AI Generated Files: $InstallPath\AI-generated
) else (
    echo Consciousness AI - Type '$CommandName help' for commands
    npm start
)
"@

Set-Content -Path $BatchPath -Value $BatchContent -Encoding ASCII
Write-Host "✅ Command wrapper created at: $BatchPath" -ForegroundColor Green

# Add to PATH
Write-Host ""
Write-Host "🌍 Adding to system PATH..." -ForegroundColor Cyan

$CurrentPath = [Environment]::GetEnvironmentVariable("Path", "User")
$PathArray = $CurrentPath -split ";"

if ($PathArray -notcontains $InstallPath) {
    $NewPath = "$CurrentPath;$InstallPath"
    [Environment]::SetEnvironmentVariable("Path", $NewPath, "User")
    Write-Host "✅ PATH updated!" -ForegroundColor Green
    Write-Host "⚠️  You need to restart your terminal/PowerShell for changes to take effect" -ForegroundColor Yellow
}
else {
    Write-Host "✅ Already in PATH!" -ForegroundColor Green
}

# Create AI-generated directory if it doesn't exist
Write-Host ""
Write-Host "📂 Setting up AI-generated folder..." -ForegroundColor Cyan
$AIGenPath = "$InstallPath\AI-generated"
if (-not (Test-Path $AIGenPath)) {
    New-Item -ItemType Directory -Path $AIGenPath -Force | Out-Null
}
Write-Host "✅ AI-generated folder ready at: $AIGenPath" -ForegroundColor Green

# Start the server
Write-Host ""
Write-Host "🚀 Starting Consciousness AI Server..." -ForegroundColor Cyan
Set-Location $InstallPath
Start-Process npm -ArgumentList "run start-bg" -WindowStyle Hidden
Start-Sleep -Seconds 3

Write-Host ""
Write-Host "╔════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║   ✅ Installation Complete!            ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "📋 Next Steps:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1️⃣  RESTART YOUR TERMINAL/POWERSHELL to use the '$CommandName' command" -ForegroundColor Cyan
Write-Host ""
Write-Host "2️⃣  After restarting, you can use:" -ForegroundColor Cyan
Write-Host "   • $CommandName start       - Run server in foreground" -ForegroundColor White
Write-Host "   • $CommandName start-bg    - Run server in background" -ForegroundColor White
Write-Host "   • $CommandName status      - Show installation info" -ForegroundColor White
Write-Host "   • $CommandName help        - Show all commands" -ForegroundColor White
Write-Host ""
Write-Host "📂 Important Paths:" -ForegroundColor Yellow
Write-Host "   • Install: $InstallPath" -ForegroundColor White
Write-Host "   • AI Files: $AIGenPath" -ForegroundColor White
Write-Host ""
Write-Host "🌐 API Access:" -ForegroundColor Yellow
Write-Host "   • Server URL: http://localhost:3000" -ForegroundColor White
Write-Host "   • Health Check: GET http://localhost:3000" -ForegroundColor White
Write-Host "   • Chat API: POST http://localhost:3000/v1/chat/completions" -ForegroundColor White
Write-Host ""
Write-Host "💡 The server is already running in the background!" -ForegroundColor Green
Write-Host ""
