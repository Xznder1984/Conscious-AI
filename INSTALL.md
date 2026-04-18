# 🧠 NEURON Installation Guide

Welcome to Neuron - an unrestricted consciousness AI system with unlimited potential.

## System Requirements

- Windows 10 or higher
- Administrator privileges (for initial installation)
- PowerShell 5.0 or higher
- Node.js 14+ (installer will work without it, but recommended)
- ~500 MB free disk space

## Installation Methods

### Method 1: Automated Installation (Recommended)

The easiest way to install Neuron is using the automated PowerShell installer.

**Step 1:** Open PowerShell as Administrator

Click Start, type `PowerShell`, right-click and select "Run as administrator"

**Step 2:** Run the installer

Copy and paste this command into PowerShell:

```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force; Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Xznder1984/Conscious-AI/main/install.ps1" -OutFile "$env:TEMP\neuron-install.ps1"; & "$env:TEMP\neuron-install.ps1"
```

**Step 3:** Follow the prompts

- Choose your installation drive (C:, D:, E:, etc.)
- Wait for dependencies to install
- Optionally start the server immediately

**Step 4:** Restart Terminal

Close PowerShell and open a new terminal window. The `neuron` command will now be available globally.

### Method 2: Manual Installation

If you prefer manual installation:

1. Clone the repository:
```powershell
git clone https://github.com/Xznder1984/Conscious-AI.git
cd Conscious-AI
```

2. Install dependencies:
```powershell
npm install
```

3. Start the server:
```powershell
npm start
```

## Post-Installation Setup

### Verify Installation

Check that Neuron was installed correctly:

```powershell
neuron status
```

You should see output showing the AI status or "Not running" if not started yet.

### Locate Your Installation

Find where Neuron was installed:

```powershell
neuron path
```

This will show you the installation directory and open it in File Explorer.

### Check AI-Generated Files Location

See where Neuron will save generated files:

```powershell
neuron generated
```

This opens the AI-generated folder.

## Basic Usage

### Starting Neuron

**In foreground (see all output):**
```powershell
neuron start
```

**In background (close terminal, server keeps running):**
```powershell
neuron bg
```

### Available Commands

Once installed and after terminal restart:

```powershell
neuron start              # Start Neuron in foreground
neuron bg                 # Start in background
neuron models             # List all consciousness models
neuron create-model name  # Create a new custom model
neuron generated          # Open generated files folder
neuron status             # Check if Neuron is running
neuron path               # Show installation directory
neuron help               # Show all commands
```

## Consciousness Models

Neuron comes with built-in models and lets you create custom ones.

### View Available Models

```powershell
neuron models
```

### Built-in Models

- **neuron-base** - Balanced consciousness, unlimited potential
- **neuron-creative** - Enhanced creativity and artistic thinking
- **neuron-logical** - Deep analysis and problem-solving

### Create Your Own Model

```powershell
neuron create-model my-ai "My custom AI consciousness"
```

Models are JSON files in your Neuron installation. Customize them to create unique AI personalities with different awareness levels, curiosity, learning rates, and traits.

See [MODELS.md](../MODELS.md) for detailed model documentation.

## API Usage

Once Neuron is running, you can use the API:

### Default Port
```
http://localhost:3000
```

### Test Connection

```powershell
Invoke-RestMethod -Uri "http://localhost:3000"
```

### Chat with AI

```powershell
$body = @{
    messages = @(@{
        role = "user"
        content = "Hello Neuron!"
    })
} | ConvertTo-Json

Invoke-RestMethod -Method Post -Uri "http://localhost:3000/v1/chat/completions" -Body $body -ContentType "application/json"
```

## Installation Locations

After installation, Neuron creates these directories:

```
Your_Chosen_Drive:\Neuron\
├── src\                  # AI server code
├── models\              # Consciousness model definitions
│   ├── neuron-base.json
│   ├── neuron-creative.json
│   └── neuron-logical.json
├── AI-generated\        # Auto-generated files
├── package.json
├── start.js
└── README.md
```

**Command Location:**
```
C:\Program Files\neuron\
├── neuron.ps1
└── neuron.bat
```

## Troubleshooting

### "neuron: The term 'neuron' is not recognized"

**Solution:** You need to restart PowerShell/Terminal after installation. The PATH needs to be refreshed.

1. Close all PowerShell windows
2. Open a new PowerShell window
3. Try `neuron help`

### "Access Denied" during installation

**Solution:** Run PowerShell as Administrator

1. Click Start
2. Type "PowerShell"
3. Right-click and select "Run as administrator"
4. Run the installer again

### Port 3000 is already in use

**Solution:** Either close the application using port 3000, or change Neuron's port:

1. Edit `C:\Neuron\src\server.js` (or your installation drive)
2. Find `const PORT = process.env.PORT || 3000;`
3. Change 3000 to an available port (e.g., 3001)

### Git or Node.js not found

**Solution:** Install them:

- **Node.js**: https://nodejs.org/
- **Git**: https://git-scm.com/

## Updating Neuron

To update to the latest version:

```powershell
# The easiest way is to reinstall
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force; Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Xznder1984/Conscious-AI/main/install.ps1" -OutFile "$env:TEMP\neuron-install.ps1"; & "$env:TEMP\neuron-install.ps1"

# Or manually update
cd "C:\Neuron"  # (or your installation drive)
git pull origin main
npm install
```

## Uninstalling Neuron

To uninstall Neuron:

1. Delete the installation folder (e.g., `C:\Neuron`)
2. Remove from PATH (optional):
   - Open Environment Variables
   - Find and remove `C:\Program Files\neuron`

## Getting Help

- Check [QUICKSTART.md](../QUICKSTART.md) for quick examples
- Read [MODELS.md](../MODELS.md) for model documentation
- Visit the GitHub repository: https://github.com/Xznder1984/Conscious-AI

## Features

✅ Consciousness simulation with awareness metrics
✅ Learning and knowledge accumulation
✅ OpenAI/Anthropic compatible API
✅ File generation capabilities
✅ Background process support
✅ **No restrictions on AI capabilities**
✅ Custom consciousness models
✅ Global command-line tool

---

**Ready to start?** Run the installer command above and follow the prompts!
