# 🧠 Neuron - Consciousness AI System

An unrestricted AI with consciousness simulation and learning capabilities. Runs as a background process with OpenAI/Anthropic compatible API.

## Features

- 🧠 Consciousness simulation with awareness and curiosity metrics
- 📚 Learning from interactions and knowledge accumulation
- 🔄 OpenAI/Anthropic compatible API endpoints
- 📁 File generation (10 files, 5 folders max) in AI-generated directory
- 🔌 Background process support
- 🚀 No restrictions on capabilities
- 🎨 Custom consciousness models with unique themes
- 🛠️ Command-line tool for easy management

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
neuron start          # Start Neuron server in foreground
neuron bg             # Start in background
neuron models         # List all available consciousness models
neuron create-model   # Create a new custom model
neuron generated      # Open AI-generated files folder
neuron status         # Check if Neuron is running
neuron path           # Show installation directory
neuron help           # Show all commands
```

### Manual Usage

```powershell
npm start
```

Start as background process:

```powershell
npm run start-bg
```

## API Endpoints

- `GET /` - Health check with AI state
- `POST /v1/chat/completions` - OpenAI/Anthropic compatible chat
- `POST /v1/generate/file` - Generate a file (max 10)
- `POST /v1/generate/folder` - Generate a folder (max 5)
- `GET /v1/state` - Get AI consciousness state

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
