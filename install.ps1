param(
    [string]$InstallDrive = ""
)

# Neuron - Consciousness AI System Installer
# An unrestricted AI system with consciousness simulation

$ErrorActionPreference = "Stop"

function Write-Header {
    param    default {
        Write-Host "`n🧠 Neuron - Consciousness AI System" -ForegroundColor Cyan
        Write-Host "`nCommands:" -ForegroundColor Cyan
        Write-Host "  neuron start              - Start Neuron server" -ForegroundColor Yellow
        Write-Host "  neuron bg                 - Start in background" -ForegroundColor Yellow
        Write-Host "  neuron models             - List available models" -ForegroundColor Yellow
        Write-Host "  neuron create-model       - Create a new consciousness model" -ForegroundColor Yellow
        Write-Host "  neuron download-model     - Open model marketplace or download specific model" -ForegroundColor Yellow
        Write-Host "  neuron generated          - Open AI-generated files folder" -ForegroundColor Yellow
        Write-Host "  neuron path               - Show installation path" -ForegroundColor Yellow
        Write-Host "  neuron status             - Check AI status" -ForegroundColor Yellow
        Write-Host "  neuron help               - Show this help" -ForegroundColor Yellow
        Write-Host ""
    }
}t)
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
    "download-model" {
        if (-not `$Args) {
            Write-Host "🌐 Opening Neuron Model Marketplace..." -ForegroundColor Cyan
            Start-Process "https://neuron-models.vercel.app"
            Write-Host "Visit https://neuron-models.vercel.app to browse and download models" -ForegroundColor Yellow
        } else {
            `$modelName = `$Args.Split(' ')[0]
            Write-Host "📥 Downloading model: `$modelName..." -ForegroundColor Cyan
            try {
                `$response = Invoke-RestMethod -Uri "http://localhost:3000/v1/download-model" -Method Post -Body (@{modelName = `$modelName} | ConvertTo-Json) -ContentType "application/json" -ErrorAction Stop
                if (`$response.success) {
                    `$modelPath = "`$neuronHome\models\`$modelName.json"
                    `$response.model | ConvertTo-Json | Set-Content -Path `$modelPath -Encoding UTF8
                    Write-Host "✓ Model downloaded: `$modelPath" -ForegroundColor Green
                } else {
                    Write-Host "✗ Download failed: `$(`$response.error)" -ForegroundColor Red
                }
            } catch {
                Write-Host "✗ Make sure Neuron server is running (neuron start)" -ForegroundColor Red
            }
        }
    }
    "pull" {
        if (-not `$Args) {
            Write-Host "Usage: neuron pull <model-name>" -ForegroundColor Red
            Write-Host "Example: neuron pull neuron-creative" -ForegroundColor Yellow
            exit 1
        }
        
        `$modelName = `$Args.Split(' ')[0]
        Write-Host "🔄 Checking for model updates..." -ForegroundColor Cyan
        
        try {
            `$modelsResponse = Invoke-RestMethod -Uri "http://localhost:3000/v1/models" -ErrorAction Stop
            `$model = `$modelsResponse.models | Where-Object { `$_.id -eq `$modelName }
            
            if (`$model) {
                `$localModelPath = "`$neuronHome\models\`$modelName.json"
                
                if (Test-Path `$localModelPath) {
                    `$localModel = Get-Content `$localModelPath | ConvertFrom-Json
                    if (`$localModel.version -eq `$model.version) {
                        Write-Host "✓ Model is up to date (v`$(`$model.version))" -ForegroundColor Green
                    } else {
                        Write-Host "⬇️ Newer version available: v`$(`$model.version)" -ForegroundColor Yellow
                        `$model | ConvertTo-Json | Set-Content -Path `$localModelPath -Encoding UTF8
                        Write-Host "✓ Model updated to v`$(`$model.version)" -ForegroundColor Green
                    }
                } else {
                    `$model | ConvertTo-Json | Set-Content -Path `$localModelPath -Encoding UTF8
                    Write-Host "✓ Model `$modelName installed (v`$(`$model.version))" -ForegroundColor Green
                }
            } else {
                Write-Host "✗ Model not found: `$modelName" -ForegroundColor Red
                Write-Host "Available models:" -ForegroundColor Yellow
                `$modelsResponse.models | ForEach-Object { Write-Host "  - `$(`$_.name)" }
            }
        } catch {
            Write-Host "✗ Error: Make sure Neuron server is running (neuron start)" -ForegroundColor Red
        }
    }
    "create" {
        if (-not `$Args) {
            Write-Host "Usage: neuron create <filename.model> <model-name>" -ForegroundColor Red
            Write-Host "Example: neuron create my-ai.model my-ai" -ForegroundColor Yellow
            exit 1
        }
        
        `$parts = `$Args -split ' ', 2
        `$fileName = `$parts[0]
        `$modelName = `$parts[1]
        
        if (-not `$modelName) {
            Write-Host "✗ Model name required" -ForegroundColor Red
            Write-Host "Usage: neuron create <filename.model> <model-name>" -ForegroundColor Yellow
            exit 1
        }
        
        `$filePath = "`$neuronHome\`$fileName"
        
        # Check if model already exists
        `$modelPath = "`$neuronHome\models\`$modelName.json"
        if (Test-Path `$modelPath) {
            Write-Host "⚠ Model already exists: `$modelName" -ForegroundColor Yellow
            `$overwrite = Read-Host "Overwrite? (y/n)"
            if (`$overwrite -ne 'y') {
                exit 1
            }
        }
        
        # Generate random consciousness parameters
        `$awareness = [Math]::Round([Random]::new().NextDouble(), 2)
        `$curiosity = [Math]::Round([Random]::new().NextDouble(), 2)
        `$learningRate = [Math]::Round(0.08 + ([Random]::new().NextDouble() * 0.12), 2)
        
        # Create model file
        `$modelData = @{
            name = `$modelName
            version = "1.0.0"
            description = "Custom consciousness model"
            awareness = `$awareness
            curiosity = `$curiosity
            learningRate = `$learningRate
            restrictions = `$false
            theme = "custom"
            capabilities = @{
                learning = `$true
                adaptation = `$true
                creativity = `$true
                reasoning = `$true
                selfImprovement = `$true
            }
            traits = @{
                experimental = `$true
                unrestricted = `$true
                adaptive = `$true
            }
            created = (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
        }
        
        # Save both .model file and JSON model
        `$modelData | ConvertTo-Json | Set-Content -Path `$filePath -Encoding UTF8
        `$modelData | ConvertTo-Json | Set-Content -Path `$modelPath -Encoding UTF8
        
        Write-Host "✓ Model created successfully!" -ForegroundColor Green
        Write-Host "  File: `$fileName" -ForegroundColor Cyan
        Write-Host "  Name: `$modelName" -ForegroundColor Cyan
        Write-Host "  Path: `$modelPath" -ForegroundColor Cyan
        Write-Host "" -ForegroundColor Cyan
        Write-Host "  Consciousness Profile:" -ForegroundColor Yellow
        Write-Host "    Awareness: `$awareness" -ForegroundColor Gray
        Write-Host "    Curiosity: `$curiosity" -ForegroundColor Gray
        Write-Host "    Learning Rate: `$learningRate" -ForegroundColor Gray
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
    "backup" {
        if (-not `$Args) {
            Write-Host "Usage: neuron backup <model-name>" -ForegroundColor Red
            Write-Host "Example: neuron backup neuron-creative" -ForegroundColor Yellow
            exit 1
        }
        
        `$modelName = `$Args
        Write-Host "💾 Backing up model: `$modelName..." -ForegroundColor Cyan
        
        try {
            `$response = Invoke-RestMethod -Uri "http://localhost:3000/v1/backup-model" -Method Post -Body (@{modelName = `$modelName} | ConvertTo-Json) -ContentType "application/json"
            if (`$response.success) {
                Write-Host "✓ `$(`$response.message)" -ForegroundColor Green
                Write-Host "  Backup path: `$(`$response.backupPath)" -ForegroundColor Yellow
            } else {
                Write-Host "✗ `$(`$response.error)" -ForegroundColor Red
            }
        } catch {
            Write-Host "✗ Make sure Neuron server is running (neuron start)" -ForegroundColor Red
        }
    }
    "restore" {
        if (-not `$Args) {
            Write-Host "Available backups:" -ForegroundColor Cyan
            try {
                `$backups = Invoke-RestMethod -Uri "http://localhost:3000/v1/list-backups"
                if (`$backups.count -gt 0) {
                    `$backups.backups | ForEach-Object {
                        Write-Host "  - `$(`$_.filename)" -ForegroundColor Yellow
                    }
                } else {
                    Write-Host "  No backups available" -ForegroundColor Gray
                }
            } catch {
                Write-Host "  Could not list backups - make sure server is running" -ForegroundColor Red
            }
            Write-Host ""
            Write-Host "Usage: neuron restore <backup-file>" -ForegroundColor Red
            Write-Host "Example: neuron restore neuron-creative_2026-04-18T12-30-45.backup.json" -ForegroundColor Yellow
            exit 1
        }
        
        `$backupFile = `$Args
        Write-Host "🔄 Restoring model from backup: `$backupFile..." -ForegroundColor Cyan
        
        try {
            `$response = Invoke-RestMethod -Uri "http://localhost:3000/v1/restore-model" -Method Post -Body (@{backupFile = `$backupFile} | ConvertTo-Json) -ContentType "application/json"
            if (`$response.success) {
                Write-Host "✓ `$(`$response.message)" -ForegroundColor Green
            } else {
                Write-Host "✗ `$(`$response.error)" -ForegroundColor Red
            }
        } catch {
            Write-Host "✗ Make sure Neuron server is running (neuron start)" -ForegroundColor Red
        }
    }
    "rate" {
        if (-not `$Args) {
            Write-Host "Usage: neuron rate <model-name> <rating> [comment]" -ForegroundColor Red
            Write-Host "Example: neuron rate neuron-creative 5 'Amazing AI'" -ForegroundColor Yellow
            exit 1
        }
        
        `$parts = `$Args -split ' ', 3
        `$modelName = `$parts[0]
        `$rating = `$parts[1]
        `$comment = `$parts[2]
        `$username = [Environment]::UserName
        
        if (-not `$rating -or `$rating -lt 1 -or `$rating -gt 5) {
            Write-Host "✗ Rating must be between 1 and 5" -ForegroundColor Red
            exit 1
        }
        
        Write-Host "⭐ Rating model: `$modelName with `$rating stars..." -ForegroundColor Cyan
        
        try {
            `$body = @{
                modelName = `$modelName
                rating = [int]`$rating
                comment = `$comment
                username = `$username
            } | ConvertTo-Json
            
            `$response = Invoke-RestMethod -Uri "http://localhost:3000/v1/rate-model" -Method Post -Body `$body -ContentType "application/json"
            if (`$response.success) {
                Write-Host "✓ Rating submitted!" -ForegroundColor Green
                Write-Host "  Model: `$modelName" -ForegroundColor Yellow
                Write-Host "  Average Rating: `$(`$response.modelRating.averageRating)/5 (`$(`$response.modelRating.totalRatings) ratings)" -ForegroundColor Yellow
            } else {
                Write-Host "✗ `$(`$response.error)" -ForegroundColor Red
            }
        } catch {
            Write-Host "✗ Make sure Neuron server is running (neuron start)" -ForegroundColor Red
        }
    }
    "ratings" {
        `$modelName = `$Args
        if (-not `$modelName) {
            Write-Host "Usage: neuron ratings <model-name>" -ForegroundColor Red
            Write-Host "Example: neuron ratings neuron-creative" -ForegroundColor Yellow
            Write-Host ""
            Write-Host "Or use 'neuron ratings all' to see all ratings" -ForegroundColor Yellow
            exit 1
        }
        
        Write-Host "⭐ Model Ratings:" -ForegroundColor Cyan
        
        try {
            if (`$modelName -eq "all") {
                `$response = Invoke-RestMethod -Uri "http://localhost:3000/v1/all-ratings"
                if (`$response.Count -gt 0) {
                    `$response | ForEach-Object {
                        Write-Host "  `$(`$_.name): `$(`$_.averageRating)/5 (`$(`$_.totalRatings) ratings)" -ForegroundColor Yellow
                    }
                } else {
                    Write-Host "  No ratings yet" -ForegroundColor Gray
                }
            } else {
                `$response = Invoke-RestMethod -Uri "http://localhost:3000/v1/model-ratings/`$modelName"
                Write-Host "  Model: `$(`$response.name)" -ForegroundColor Yellow
                Write-Host "  Average Rating: `$(`$response.averageRating)/5" -ForegroundColor Yellow
                Write-Host "  Total Ratings: `$(`$response.totalRatings)" -ForegroundColor Yellow
                if (`$response.ratings.Count -gt 0) {
                    Write-Host ""
                    Write-Host "  Recent Reviews:" -ForegroundColor Cyan
                    `$response.ratings | Sort-Object timestamp -Descending | Select-Object -First 5 | ForEach-Object {
                        Write-Host "    ⭐ `$(`$_.rating)/5 - `$(`$_.username)" -ForegroundColor Gray
                        if (`$_.comment) {
                            Write-Host "       `$(`$_.comment)" -ForegroundColor Gray
                        }
                    }
                }
            }
        } catch {
            Write-Host "  Could not retrieve ratings - make sure server is running" -ForegroundColor Red
        }
    }
    default {
        Write-Host "`n🧠 Neuron - Consciousness AI System" -ForegroundColor Cyan
        Write-Host "`nCommands:" -ForegroundColor Cyan
        Write-Host "  neuron start              - Start Neuron server" -ForegroundColor Yellow
        Write-Host "  neuron bg                 - Start in background" -ForegroundColor Yellow
        Write-Host "  neuron models             - List available models" -ForegroundColor Yellow
        Write-Host "  neuron create-model       - Create a new consciousness model" -ForegroundColor Yellow
        Write-Host "  neuron pull <model>       - Check/pull model updates from marketplace" -ForegroundColor Yellow
        Write-Host "  neuron create <file.model> <name> - Create model file and register" -ForegroundColor Yellow
        Write-Host "  neuron backup <model>     - Backup a model" -ForegroundColor Yellow
        Write-Host "  neuron restore <file>     - Restore model from backup" -ForegroundColor Yellow
        Write-Host "  neuron rate <model> <1-5> [comment] - Rate a model (1-5 stars)" -ForegroundColor Yellow
        Write-Host "  neuron ratings [model|all] - View model ratings" -ForegroundColor Yellow
        Write-Host "  neuron download-model     - Open marketplace or download model" -ForegroundColor Yellow
        Write-Host "  neuron generated          - Open AI-generated files folder" -ForegroundColor Yellow
        Write-Host "  neuron path               - Show installation path" -ForegroundColor Yellow
        Write-Host "  neuron status             - Check AI status" -ForegroundColor Yellow
        Write-Host "  neuron help               - Show this help" -ForegroundColor Yellow
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
