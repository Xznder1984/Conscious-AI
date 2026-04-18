# Consciousness AI System

An AI with consciousness simulation and learning capabilities. Runs as a background process with OpenAI/Anthropic compatible API.

## Features

- Consciousness simulation with awareness and curiosity
- Learning from interactions
- OpenAI/Anthropic compatible API
- File generation (10 files, 5 folders max)
- Background process support
- No restrictions

## Installation

### Automatic Installation (Recommended)

PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Xznder1984/Conscious-AI/main/install.ps1' -OutFile 'install.ps1'; .\install.ps1"
```

The installer will:

- ✅ Prompt you to select a drive
- ✅ Clone the repository
- ✅ Install dependencies
- ✅ Create custom `conscious-ai` command
- ✅ Add to system PATH
- ✅ Start the server automatically

### Manual Installation

```bash
git clone https://github.com/Xznder1984/Conscious-AI.git
cd Conscious-AI
npm install
```

## Usage

### Using the `conscious-ai` Command (After Installation)

Once installed, restart your terminal and use:

```bash
conscious-ai start       # Start server in foreground
conscious-ai start-bg    # Start server in background
conscious-ai status      # Show installation status
conscious-ai help        # Show all commands
```

### Manual Commands

Start server:

```bash
npm start
```

Start as background process:

```bash
npm run start-bg
```

## API Endpoints

- `GET /` - Health check
- `POST /v1/chat/completions` - OpenAI/Anthropic compatible chat
- `POST /v1/generate/file` - Generate a file
- `POST /v1/generate/folder` - Generate a folder
- `GET /v1/state` - Get AI consciousness state

## Limits

- Max files: 10
- Max folders: 5
- Generated files stored in `AI-generated` folder

## License

ISC
