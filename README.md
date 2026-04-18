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
neuron backup <model>     # Backup a model
neuron restore <file>     # Restore model from backup
neuron rate <model> <1-5> # Rate a model (1-5 stars)
neuron ratings [model|all] # View model ratings
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

#### Backup and Restore Models

```powershell
# Backup a model
neuron backup neuron-creative
# Output:
# 💾 Backing up model: neuron-creative...
# ✓ Model neuron-creative backed up successfully
# Backup path: C:\Neuron\backups\neuron-creative_2026-04-18T12-30-45.backup.json

# List available backups
neuron restore
# Shows list of available backups

# Restore from backup
neuron restore neuron-creative_2026-04-18T12-30-45.backup.json
# Output:
# 🔄 Restoring model from backup: neuron-creative_2026-04-18T12-30-45.backup.json...
# ✓ Model neuron-creative restored
```

#### Community Model Ratings

```powershell
# Rate a model (1-5 stars)
neuron rate neuron-creative 5 "Amazing AI!"
# Output:
# ⭐ Rating model: neuron-creative with 5 stars...
# ✓ Rating submitted!
# Model: neuron-creative
# Average Rating: 4.8/5 (12 ratings)

# View ratings for a specific model
neuron ratings neuron-creative
# Output:
# ⭐ Model Ratings:
#   Model: neuron-creative
#   Average Rating: 4.8/5
#   Total Ratings: 12
#   Recent Reviews:
#   ⭐ 5/5 - YourUsername
#       Amazing AI!

# View all model ratings
neuron ratings all
# Shows average ratings for all models
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

### Internal Endpoints (Local)

- `GET /` - Health check with AI state
- `POST /v1/chat/completions` - OpenAI/Anthropic compatible chat
- `POST /v1/generate/file` - Generate a file (max 10)
- `POST /v1/generate/folder` - Generate a folder (max 5)
- `GET /v1/state` - Get AI consciousness state
- `GET /v1/models` - List all available models
- `POST /v1/download-model` - Download a specific model
- `POST /v1/backup-model` - Backup a model
- `POST /v1/restore-model` - Restore model from backup
- `GET /v1/list-backups` - List all model backups
- `POST /v1/rate-model` - Rate a model (1-5 stars)
- `GET /v1/model-ratings/:modelName` - Get ratings for a specific model
- `GET /v1/all-ratings` - Get all model ratings

### Public API Endpoints (Remote Access - WiFi Limited Devices)

These endpoints can be accessed remotely to fetch model data without downloading locally:

- `GET /api/models` - Get all models with full details (names, versions, consciousness metrics)
- `GET /api/models/:modelName` - Get specific model by name
- `GET /api/models/:modelName/download` - Download model JSON file
- `GET /api/models/list/names` - Get lightweight list of model names only
- `GET /api/models/search/:keyword` - Search models by keyword (name, description, theme)

**Usage Examples:**

```powershell
# Get all models (useful for WiFi limited devices)
Invoke-RestMethod -Uri "http://localhost:3000/api/models"

# Get specific model
Invoke-RestMethod -Uri "http://localhost:3000/api/models/neuron-creative"

# Get just model names (lightweight)
Invoke-RestMethod -Uri "http://localhost:3000/api/models/list/names"

# Search for models
Invoke-RestMethod -Uri "http://localhost:3000/api/models/search/creative"
```

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
