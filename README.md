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

```bash
npm install
```

## Usage

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
