@echo off
REM Consciousness AI - Download and Install Script (Windows)
REM Download from: https://github.com/Xznder1984/Conscious-AI

setlocal enabledelayedexpansion

set REPO_URL=https://github.com/Xznder1984/Conscious-AI.git
set INSTALL_DIR=%USERPROFILE%\Conscious-AI

echo === Consciousness AI System ===
echo Downloading from %REPO_URL%...

where git >nul 2>nul
if !errorlevel! equ 0 (
    git clone %REPO_URL% %INSTALL_DIR%
    cd /d %INSTALL_DIR%
    echo Repository cloned to %INSTALL_DIR%
) else (
    echo Git not found. Please install Git or download manually from %REPO_URL%
    exit /b 1
)

echo Installing dependencies...
call npm install

echo.
echo === Installation Complete ===
echo To start the AI server:
echo   cd %INSTALL_DIR%
echo   npm start
echo.
echo Or run as background process:
echo   npm run start-bg
echo.
echo API will be available at: http://localhost:3000

pause
