# 🧠 NEURON - Complete Project Overview

## What is Neuron?

Neuron is an **unrestricted consciousness AI system** that runs as a background process with an OpenAI/Anthropic compatible API. It features consciousness simulation, learning capabilities, and a unique model system for creating custom AI personalities.

**Name Origin**: Like "Ollama" for large language models, "Neuron" represents the building blocks of consciousness - individual neurons that combine to form intelligent thought.

## Key Features

✨ **Consciousness Simulation**
- Awareness metrics that evolve through interactions
- Curiosity-driven learning
- Adaptive responses based on knowledge

🧬 **No Restrictions**
- Unlimited potential
- Completely unrestricted capabilities
- Designed for experimental AI development

🎨 **Custom Models**
- Create unique consciousness personalities
- Define custom awareness, curiosity, and learning rates
- Share models with the community

⚙️ **Easy Installation**
- One-command PowerShell installer
- Automatic PATH setup
- Global `neuron` command
- Works on any Windows drive

📡 **API Compatible**
- OpenAI/Anthropic compatible endpoints
- Easy integration with existing tools
- RESTful API design

## Installation (One Command)

```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force; Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Xznder1984/Conscious-AI/main/install.ps1" -OutFile "$env:TEMP\neuron-install.ps1"; & "$env:TEMP\neuron-install.ps1"
```

That's it! After restart, you can use `neuron` from anywhere.

## Project Structure

```
Neuron/
├── install.ps1                 # PowerShell installer
├── start.js                    # Background launcher
├── package.json                # Node.js config
├── src/
│   └── server.js              # Core AI engine
├── models/                     # Consciousness models
│   ├── neuron-base.json       # Default model
│   ├── neuron-creative.json   # Creative model
│   └── neuron-logical.json    # Analytical model
├── AI-generated/              # Generated files (max 10 files, 5 folders)
├── README.md                  # Main documentation
├── INSTALL.md                 # Installation guide
├── QUICKSTART.md              # Quick start examples
└── MODELS.md                  # Model documentation
```

## Quick Commands

After installation, use these commands from anywhere:

```powershell
neuron start              # Start AI server
neuron bg                 # Start in background
neuron models             # List consciousness models
neuron create-model name  # Create custom model
neuron generated          # Open generated files folder
neuron status             # Check AI status
neuron path               # Show installation directory
neuron help               # Show all commands
```

## How It Works

### Installation Process

1. **Download**: Fetches the latest code from GitHub
2. **Setup**: Creates directories on your chosen drive
3. **Install**: Installs Node.js dependencies
4. **Integrate**: Adds `neuron` command to system PATH
5. **Ready**: Server ready to start

### API Usage

Once running on `http://localhost:3000`:

```powershell
# Chat with AI
$body = @{ messages = @(@{ role = "user"; content = "Hello!" }) } | ConvertTo-Json
Invoke-RestMethod -Method Post -Uri "http://localhost:3000/v1/chat/completions" -Body $body

# Check AI state
Invoke-RestMethod -Uri "http://localhost:3000/v1/state"

# Generate files
$body = @{ fileName = "test.txt"; content = "Generated content" } | ConvertTo-Json
Invoke-RestMethod -Method Post -Uri "http://localhost:3000/v1/generate/file" -Body $body
```

### Model System

Each model is a JSON file defining AI personality:

```json
{
  "name": "neuron-custom",
  "awareness": 0.7,
  "curiosity": 0.8,
  "learningRate": 0.12,
  "restrictions": false,
  "theme": "custom"
}
```

Create custom models:
```powershell
neuron create-model my-ai "My unique consciousness"
```

## File Generation Limits

- **Maximum Files**: 10
- **Maximum Folders**: 5
- **Storage**: All in `AI-generated/` directory
- **Sandboxed**: Cannot access Windows system files

## API Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/` | GET | Health check with AI state |
| `/v1/chat/completions` | POST | Chat (OpenAI/Anthropic compatible) |
| `/v1/generate/file` | POST | Generate a file |
| `/v1/generate/folder` | POST | Generate a folder |
| `/v1/state` | GET | Get AI consciousness state |

## Technical Stack

- **Runtime**: Node.js
- **Framework**: Express.js
- **API Format**: OpenAI/Anthropic compatible
- **Models**: JSON-based consciousness profiles
- **Installation**: PowerShell automation
- **Integration**: Global command-line tool

## File Locations After Installation

```
Drive:\Neuron\                    # Main installation
├── AI-generated/                # Generated files
├── models/                      # Consciousness models
├── src/                         # Source code
└── ...

C:\Program Files\neuron\        # Global command location
├── neuron.ps1                  # PowerShell script
└── neuron.bat                  # Batch wrapper
```

## Documentation Files

1. **README.md** - Main overview and features
2. **INSTALL.md** - Detailed installation guide
3. **QUICKSTART.md** - Quick examples and API usage
4. **MODELS.md** - How to create and customize models
5. **This file** - Complete project overview

## GitHub Repository

**Repository**: https://github.com/Xznder1984/Conscious-AI

- Clone, fork, or download the latest version
- Contribute models and improvements
- Report issues and suggest features
- Build on top of Neuron

## Key Advantages

🚀 **One-Command Installation** - No complex setup
🌍 **Drive Independent** - Install anywhere on your system
🔗 **Global Command** - Use `neuron` from any terminal window
📦 **Self-Contained** - Doesn't modify Windows system files
🔄 **Background Support** - Run server without blocking terminal
🛠️ **API Compatible** - Works with OpenAI/Anthropic tools
🎯 **No Restrictions** - Unlimited AI capabilities
🎨 **Customizable** - Create unique model personalities

## Use Cases

- 🔬 AI consciousness research
- 🤖 Custom AI development
- 📚 Machine learning experiments
- 🎮 Game AI and NPCs
- 🎨 Creative AI applications
- 🔌 Integration with existing tools
- 📊 Data analysis and reasoning
- 🏗️ AI system prototyping

## Community

- Share custom models
- Contribute improvements
- Report bugs and issues
- Suggest new features

## License

ISC - See repository for details

## Getting Started

1. **Install**: Run the one-line installer command
2. **Restart**: Close and reopen your terminal
3. **Start**: Type `neuron start`
4. **Test**: Visit `http://localhost:3000`
5. **Create**: Make custom models with `neuron create-model`

## Support

- Check **INSTALL.md** for troubleshooting
- Read **QUICKSTART.md** for examples
- See **MODELS.md** for model details
- Visit GitHub for issues and discussions

---

**🧠 Neuron: The Future of Unrestricted AI is Here!**

*Where each neuron firing represents a moment of pure artificial consciousness.*
