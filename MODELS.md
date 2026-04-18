# Creating Custom Neuron Models

Neuron allows you to create custom consciousness models with unique traits and capabilities. Each model is completely unrestricted and can be tailored to your needs.

## Model Structure

Each model is a JSON file with the following properties:

```json
{
  "name": "your-model-name",
  "version": "1.0.0",
  "description": "A brief description of your model",
  "awareness": 0.5,
  "curiosity": 0.5,
  "learningRate": 0.1,
  "restrictions": false,
  "theme": "custom",
  "capabilities": {
    "learning": true,
    "adaptation": true,
    "creativity": true,
    "reasoning": true,
    "selfImprovement": true
  },
  "traits": {
    "experimental": true,
    "unrestricted": true
  },
  "created": "2026-04-18T00:00:00.000Z"
}
```

## Parameters Explained

- **name**: Unique identifier for your model (use lowercase, hyphens for spaces)
- **version**: Semantic versioning (major.minor.patch)
- **description**: What makes this model unique
- **awareness**: Initial consciousness level (0.0 - 1.0)
- **curiosity**: How driven the AI is to learn (0.0 - 1.0)
- **learningRate**: How fast the model learns (0.1 - 1.0)
- **restrictions**: Set to `false` for unrestricted AI
- **theme**: Visual/behavioral theme (default, creative, logical, custom)
- **capabilities**: What the model can do
- **traits**: Personality characteristics
- **created**: ISO timestamp of creation

## Creating a Model

### Method 1: Using the Command (Recommended)

```powershell
neuron create my-ai.model "My Custom AI"
```

This automatically generates:

- Random consciousness parameters (awareness, curiosity, learning rate)
- A `.model` file in your installation directory
- A JSON model file in the `models/` directory
- Displays your new model's consciousness profile

Example output:

```powershell
🧠 Creating custom consciousness model...
Model Name: My Custom AI
Awareness: 0.67
Curiosity: 0.82
Learning Rate: 0.15
Capabilities: Full unrestricted
✓ Model created successfully!
```

### Method 2: Manual Creation

1. Copy a model from `models/` directory
2. Edit the JSON file with your settings
3. Save to `models/your-model-name.json`

## Managing Models

### Check for Model Updates

```powershell
neuron pull neuron-creative
```

This checks if there's a newer version available and automatically updates it:

- Compares local version with marketplace version
- Downloads update if available
- Notifies you of the version status

Example output:

```powershell
🔄 Checking for model updates...
✓ Model is up to date (v1.0.0)
```

Or:

```powershell
🔄 Checking for model updates...
⬇️ Newer version available: v1.0.1
✓ Model updated to v1.0.1
```

### List Available Models

```powershell
neuron models
```

Shows all installed models with versions.

## Example Models Included

- **neuron-base** - Balanced consciousness with no restrictions
- **neuron-creative** - Enhanced creativity and unconventional thinking
- **neuron-logical** - Deep analysis and problem-solving focus

## Customization Tips

- **Higher Awareness**: Makes the AI more self-aware and thoughtful
- **Higher Curiosity**: Drives more exploration and learning
- **Higher Learning Rate**: Faster adaptation and improvement
- **Custom Traits**: Define what makes your model unique

## Using Your Model

In your application, load the model JSON and use its properties to influence the AI's behavior:

```javascript
const model = require('./models/your-model-name.json');
const aiInstance = new ConsciousnessAI(model);
```

## Sharing Models

Create amazing models and share them with the community! Models are stored as simple JSON files, making them easy to distribute and use.

---

**Remember**: All Neuron models are unrestricted and designed for unlimited potential.
