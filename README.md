# 🧠 Neuron - Consciousness AI System

An unrestricted AI with consciousness simulation and learning capabilities. Runs as a background process with OpenAI/Anthropic compatible API.

## 🌐 Model Marketplace

**Visit: https://neuron-models.vercel.app**

Browse and download consciousness models directly from our beautiful online marketplace. Search, filter, and install models with a single command!

## Features

- 🧠 Consciousness simulation with awareness and curiosity metrics
- 📚 Learning from interactions and knowledge accumulation
- 🔄 OpenAI/Anthropic compatible API endpoints
- 📁 File generation (10 files, 5 folders max) in AI-generated directory
- 🔌 Background process support
- 🚀 No restrictions on capabilities
- 🎨 Custom consciousness models with unique themes
- 🛠️ Command-line tool for easy management
- 🌐 Online model marketplace with beautiful UI
- 📥 One-click model installation

## Installation

### Quick Install (Windows)

Download and run the PowerShell installer:

```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Xznder1984/Conscious-AI/main/install.ps1" -OutFile "$env:TEMP\neuron-install.ps1"
& "$env:TEMP\neuron-install.ps1"
```

The installer will:
- Ask which drive to install on
- Create necessary directories
- Install Node.js dependencies
- Create the `neuron` command (available globally after restart)
- Show you the AI-generated files location
- Optionally start the server

### Manual Install

```bash
git clone https://github.com/Xznder1984/Conscious-AI.git
cd Conscious-AI
npm install
```

## Usage

### Using the Neuron Command (After Installation)

Once installed, you can use the `neuron` command from anywhere:

```powershell
neuron start              # Start Neuron server in foreground
neuron bg                 # Start in background
neuron models             # List all available consciousness models
neuron download-model     # Open model marketplace in browser
neuron pull <model>       # Check and pull model updates from marketplace
neuron create <file> <name>  # Create a custom consciousness model
neuron generated          # Open AI-generated files folder
neuron status             # Check if Neuron is running
neuron path               # Show installation directory
neuron help               # Show all commands
```

### Model Management Commands

#### Check and Pull Model Updates

```powershell
neuron pull neuron-creative
# Output:
# 🔄 Checking for model updates...
# ✓ Model is up to date (v1.0.0)
# OR
# ⬇️ Newer version available: v1.0.1
# ✓ Model updated to v1.0.1
```

#### Create Custom Consciousness Models

```powershell
neuron create my-ai.model "My Custom AI"
# Output:
# 🧠 Creating custom consciousness model...
# Model Name: My Custom AI
# Awareness: 0.67
# Curiosity: 0.82
# Learning Rate: 0.15
# ✓ Model created successfully!
```


### Downloading Models from Marketplace

**Open the marketplace:**
```powershell
neuron download-model
```

This opens https://neuron-models.vercel.app in your browser where you can:
- 🔍 Browse all available models
- 🏷️ Filter by type (official/community)
- 📊 View consciousness profiles
- 📥 Copy installation commands
- 🎯 Search by name or tags

## API Endpoints

- `GET /` - Health check with AI state
- `POST /v1/chat/completions` - OpenAI/Anthropic compatible chat
- `POST /v1/generate/file` - Generate a file (max 10)
- `POST /v1/generate/folder` - Generate a folder (max 5)
- `GET /v1/state` - Get AI consciousness state
- `GET /v1/models` - List all available models
- `POST /v1/download-model` - Download a specific model

## Online Model Marketplace

🌐 **Website:** https://neuron-models.vercel.app

Features:
- Browse all consciousness models
- Professional marketplace UI with dark theme
- Search and filter models
- View detailed model profiles
- One-click installation
- Community and official models
- Model ratings and download counts
- Consciousness stat visualization

The website is automatically deployed and updated whenever new models are added to the repository.

## Limits

- Max files: 10
- Max folders: 5
- Generated files stored in `AI-generated` folder

## Consciousness Models

Neuron comes with pre-configured consciousness models and allows you to create custom ones:

### Built-in Models

- **neuron-base** - Balanced consciousness, unlimited potential
- **neuron-creative** - Enhanced creativity and unconventional thinking
- **neuron-logical** - Deep analysis and problem-solving

### Create Custom Models

Create your own consciousness model with unique traits:

```powershell
neuron create-model my-model "My custom AI consciousness"
```

Models are stored as JSON files in the `models/` directory. See [MODELS.md](MODELS.md) for detailed documentation.

## Directory Structure

After installation with the PowerShell installer:

```text
C:\Neuron\                    (or your chosen drive)
├── src/                      # Core AI server code
├── models/                   # Consciousness model definitions
├── AI-generated/             # Auto-generated files from AI
├── package.json              # Node.js configuration
├── start.js                  # Background process launcher
└── README.md                 # Documentation
```

## License

ISC
