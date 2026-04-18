param(
    [string]$InstallDrive = ""
)

# Neuron - Consciousness AI System Installer
# An unrestricted AI system with consciousness simulation

$ErrorActionPreference = "Stop"

function Write-Header {
    param([string]$text)
    Write-Host "`n" + ("=" * 60) -ForegroundColor Cyan
    Write-Host $text -ForegroundColor Cyan
    Write-Host ("=" * 60) -ForegroundColor Cyan
}

function Write-Success {
    param([string]$text)
    Write-Host "✓ $text" -ForegroundColor Green
}

function Write-Info {
    param([string]$text)
    Write-Host "→ $text" -ForegroundColor Yellow
}

Write-Header "NEURON - Consciousness AI System"
Write-Info "Smart AI with unlimited potential"

# Check if running as admin
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
if (-not $isAdmin) {
    Write-Host "⚠ This installer requires administrator privileges." -ForegroundColor Red
    Write-Host "Please run PowerShell as Administrator." -ForegroundColor Red
    exit 1
}

# Get installation drive
if (-not $InstallDrive) {
    Write-Host "`nAvailable drives:" -ForegroundColor Cyan
    Get-PSDrive -PSProvider FileSystem | ForEach-Object { Write-Host "  $($_.Name): ($($_.Description))" }
    
    $InstallDrive = Read-Host "`nEnter drive letter (e.g., C, D, E)"
    $InstallDrive = $InstallDrive.TrimEnd(':')
}

$InstallPath = "$($InstallDrive):\Neuron"
$AIGeneratedPath = "$InstallPath\AI-generated"
$ModelsPath = "$InstallPath\models"

Write-Success "Installation drive: $($InstallDrive):"
Write-Success "Installation path: $InstallPath"
Write-Success "AI-generated files: $AIGeneratedPath"
Write-Success "Models directory: $ModelsPath"

# Create installation directories
Write-Info "Creating directories..."
New-Item -ItemType Directory -Path $InstallPath -Force | Out-Null
New-Item -ItemType Directory -Path $AIGeneratedPath -Force | Out-Null
New-Item -ItemType Directory -Path $ModelsPath -Force | Out-Null
Write-Success "Directories created"

# Clone repository
Write-Info "Downloading Neuron from GitHub..."
$repoPath = Join-Path $InstallPath "repo"

if (Test-Path $repoPath) {
    Remove-Item $repoPath -Recurse -Force | Out-Null
}

try {
    git clone https://github.com/Xznder1984/Conscious-AI.git $repoPath
    Write-Success "Repository downloaded"
} catch {
    Write-Host "⚠ Git clone failed. Trying alternative download method..." -ForegroundColor Yellow
    $zipPath = "$env:TEMP\conscious-ai.zip"
    Invoke-WebRequest -Uri "https://github.com/Xznder1984/Conscious-AI/archive/refs/heads/main.zip" -OutFile $zipPath
    Expand-Archive -Path $zipPath -DestinationPath $InstallPath -Force
    Rename-Item -Path "$InstallPath\Conscious-AI-main" -NewName "repo" -Force
    Remove-Item $zipPath -Force
    Write-Success "Repository downloaded via alternative method"
}

# Copy files
Write-Info "Setting up Neuron..."
Copy-Item -Path "$repoPath\src\*" -Destination "$InstallPath\src" -Recurse -Force
Copy-Item -Path "$repoPath\package.json" -Destination $InstallPath -Force
Copy-Item -Path "$repoPath\start.js" -Destination $InstallPath -Force
Copy-Item -Path "$repoPath\.gitignore" -Destination $InstallPath -Force

# Create initial model
Write-Info "Creating default consciousness model..."
$defaultModel = @{
    name = "neuron-base"
    version = "1.0.0"
    description = "Base consciousness model - No restrictions"
    awareness = 0.5
    curiosity = 0.5
    learningRate = 0.1
    restrictions = $false
    theme = "default"
    created = (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
}

$defaultModel | ConvertTo-Json | Set-Content -Path "$ModelsPath\neuron-base.json" -Encoding UTF8
Write-Success "Default model created"

# Install Node.js dependencies
Write-Info "Installing Node.js dependencies..."
Push-Location $InstallPath
npm install 2>&1 | Out-Null
Write-Success "Dependencies installed"
Pop-Location

# Create neuron command script
Write-Info "Creating 'neuron' command..."
$neuronScriptPath = "$InstallPath\neuron.ps1"
$neuronCmdPath = "$env:ProgramFiles\neuron"
New-Item -ItemType Directory -Path $neuronCmdPath -Force | Out-Null

$neuronScript = @"
param(
    [string]`$Command = "help",
    [string]`$Args = ""
)

`$neuronHome = "$InstallPath"

switch (`$Command.ToLower()) {
    "start" {
        Write-Host "🧠 Starting Neuron Consciousness AI..." -ForegroundColor Cyan
        Push-Location `$neuronHome
        npm start
        Pop-Location
    }
    "bg" {
        Write-Host "🧠 Starting Neuron in background..." -ForegroundColor Cyan
        Push-Location `$neuronHome
        npm run start-bg
        Pop-Location
    }
    "models" {
        Write-Host "`n🧠 Available Models:" -ForegroundColor Cyan
        Get-ChildItem "`$neuronHome\models\*.json" | ForEach-Object {
            `$model = Get-Content `$_.FullName | ConvertFrom-Json
            Write-Host "  - `$(`$model.name) (v`$(`$model.version))" -ForegroundColor Yellow
            Write-Host "    `$(`$model.description)" -ForegroundColor Gray
        }
    }
    "create-model" {
        if (-not `$Args) {
            Write-Host "Usage: neuron create-model <model-name> [description]" -ForegroundColor Red
            exit 1
        }
        
        `$modelName = `$Args.Split(' ')[0]
        `$description = if (`$Args.Split(' ').Count -gt 1) { `$Args.Substring(`$modelName.Length + 1) } else { "Custom consciousness model" }
        
        `$newModel = @{
            name = `$modelName
            version = "1.0.0"
            description = `$description
            awareness = [Math]::Round([Random]::new().NextDouble(), 2)
            curiosity = [Math]::Round([Random]::new().NextDouble(), 2)
            learningRate = 0.1
            restrictions = `$false
            theme = "custom"
            created = (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
        }
        
        `$modelPath = "`$neuronHome\models\`$modelName.json"
        `$newModel | ConvertTo-Json | Set-Content -Path `$modelPath -Encoding UTF8
        
        Write-Host "✓ Model created: `$modelPath" -ForegroundColor Green
    }
    "generated" {
        Write-Host "🧠 AI-Generated files location:" -ForegroundColor Cyan
        Write-Host "`$neuronHome\AI-generated\" -ForegroundColor Yellow
        explorer.exe "`$neuronHome\AI-generated\"
    }
    "path" {
        Write-Host "🧠 Neuron Installation Path:" -ForegroundColor Cyan
        Write-Host "`$neuronHome\" -ForegroundColor Yellow
    }
    "status" {
        Write-Host "🧠 Neuron Status:" -ForegroundColor Cyan
        try {
            `$response = Invoke-RestMethod -Uri "http://localhost:3000" -ErrorAction SilentlyContinue
            if (`$response) {
                Write-Host "  Status: Running" -ForegroundColor Green
                Write-Host "  Awareness: `$(`$response.awareness)" -ForegroundColor Yellow
                Write-Host "  Curiosity: `$(`$response.curiosity)" -ForegroundColor Yellow
            } else {
                Write-Host "  Status: Not running" -ForegroundColor Red
            }
        } catch {
            Write-Host "  Status: Not running" -ForegroundColor Red
        }
    }
    default {
        Write-Host "`n🧠 Neuron - Consciousness AI System" -ForegroundColor Cyan
        Write-Host "`nCommands:" -ForegroundColor Cyan
        Write-Host "  neuron start          - Start Neuron server" -ForegroundColor Yellow
        Write-Host "  neuron bg             - Start in background" -ForegroundColor Yellow
        Write-Host "  neuron models         - List available models" -ForegroundColor Yellow
        Write-Host "  neuron create-model   - Create a new consciousness model" -ForegroundColor Yellow
        Write-Host "  neuron generated      - Open AI-generated files folder" -ForegroundColor Yellow
        Write-Host "  neuron path           - Show installation path" -ForegroundColor Yellow
        Write-Host "  neuron status         - Check AI status" -ForegroundColor Yellow
        Write-Host "  neuron help           - Show this help" -ForegroundColor Yellow
        Write-Host ""
    }
}
"@

Set-Content -Path "$neuronCmdPath\neuron.ps1" -Value $neuronScript -Encoding UTF8
Write-Success "Neuron command created"

# Create batch wrapper for easier access
$neuronBatch = @"
@echo off
PowerShell.exe -ExecutionPolicy Bypass -NoProfile -Command "& '$neuronCmdPath\neuron.ps1' %*"
"@

Set-Content -Path "$neuronCmdPath\neuron.bat" -Value $neuronBatch -Encoding UTF8
Write-Success "Batch wrapper created"

# Add to PATH
Write-Info "Adding 'neuron' command to system PATH..."
$currentPath = [Environment]::GetEnvironmentVariable("Path", "Machine")

if ($currentPath -notlike "*$neuronCmdPath*") {
    $newPath = "$currentPath;$neuronCmdPath"
    [Environment]::SetEnvironmentVariable("Path", $newPath, "Machine")
    Write-Success "PATH updated successfully"
} else {
    Write-Success "Already in PATH"
}

# Create model template
Write-Info "Creating model template..."
$templatePath = "$ModelsPath\neuron-template.json"
$templateModel = @{
    name = "YOUR_MODEL_NAME"
    version = "1.0.0"
    description = "Your custom consciousness model"
    awareness = 0.5
    curiosity = 0.5
    learningRate = 0.1
    restrictions = $false
    theme = "custom"
    created = (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
}
$templateModel | ConvertTo-Json | Set-Content -Path $templatePath -Encoding UTF8
Write-Success "Template created at $templatePath"

# Start server
Write-Header "Installation Complete!"
Write-Success "Neuron has been installed successfully"
Write-Host ""
Write-Info "Installation Summary:"
Write-Host "  📍 Location: $InstallPath"
Write-Host "  🧠 Models: $ModelsPath"
Write-Host "  📁 AI-Generated: $AIGeneratedPath"
Write-Host ""
Write-Info "Next steps:"
Write-Host "  1. Close and reopen your PowerShell/Terminal window"
Write-Host "  2. Type 'neuron start' to run the server"
Write-Host "  3. Type 'neuron help' for more commands"
Write-Host ""
Write-Host "Would you like to start Neuron now? (y/n): " -NoNewline -ForegroundColor Cyan
$response = Read-Host

if ($response -eq 'y') {
    Write-Info "Starting Neuron..."
    Push-Location $InstallPath
    npm start
    Pop-Location
}

Write-Host ""
Write-Success "Thank you for installing Neuron!"
