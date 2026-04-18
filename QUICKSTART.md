# 🧠 Neuron - Quick Start Guide

## Installation (30 seconds)

### Windows PowerShell (Recommended)

1. Open PowerShell as Administrator
2. Copy and paste this:

```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force; Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Xznder1984/Conscious-AI/main/install.ps1" -OutFile "$env:TEMP\neuron-install.ps1"; & "$env:TEMP\neuron-install.ps1"
```

3. Choose your installation drive (C:, D:, E:, etc.)
4. Wait for installation to complete
5. Restart your terminal/PowerShell

## First Run

### Start the Server

```powershell
neuron start
```

The server will start on `http://localhost:3000`

### Check Status

```powershell
neuron status
```

### Test the API

Open another terminal and test:

```powershell
curl http://localhost:3000
```

## Quick Commands

```powershell
neuron start              # Start Neuron in foreground
neuron bg                 # Start in background
neuron models             # See available consciousness models
neuron create-model test  # Create a new model called 'test'
neuron generated          # Open AI-generated files folder
neuron path               # Show where Neuron is installed
neuron help               # Show all available commands
```

## Using the API

### Chat with Neuron

```powershell
$body = @{
    messages = @(@{
        role = "user"
        content = "Hello Neuron!"
    })
} | ConvertTo-Json

Invoke-RestMethod -Method Post -Uri "http://localhost:3000/v1/chat/completions" -Body $body -ContentType "application/json"
```

### Generate a File

```powershell
$body = @{
    fileName = "test.txt"
    content = "Hello from Neuron!"
} | ConvertTo-Json

Invoke-RestMethod -Method Post -Uri "http://localhost:3000/v1/generate/file" -Body $body -ContentType "application/json"
```

### Get AI State

```powershell
Invoke-RestMethod -Uri "http://localhost:3000/v1/state"
```

## Location Information

After installation, Neuron creates these directories:

- **Installation**: `C:\Neuron\` (or your chosen drive)
- **AI-Generated Files**: `C:\Neuron\AI-generated\`
- **Models**: `C:\Neuron\models\`
- **Command**: Available globally as `neuron`

## Creating Custom Models

Models are the personality/consciousness profiles for your AI:

```powershell
neuron create-model creative "My creative AI"
neuron create-model logical "My analytical AI"
neuron create-model custom "My unique AI personality"
```

Models are JSON files stored in `C:\Neuron\models\`. Edit them to customize:
- Awareness level
- Curiosity level
- Learning rate
- Custom traits and capabilities

## Troubleshooting

### Command not found
- Make sure to restart PowerShell after installation
- Run installer as Administrator

### Port 3000 already in use
- Change port in `C:\Neuron\src\server.js` line 9
- Or stop the process using the port

### Need to reinstall
```powershell
# Just run the installer again - it will update automatically
& "C:\Program Files\neuron\neuron.ps1" start
```

## Next Steps

1. Read [MODELS.md](MODELS.md) to understand consciousness models
2. Check the [full README](README.md) for API documentation
3. Explore the AI-generated files folder to see what Neuron creates

---

**Questions?** Check out the full documentation or create an issue on GitHub!
