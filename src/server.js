const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const fs = require('fs');
const path = require('path');

// Load environment variables
dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// AI state and memory
let aiMemory = {
  conversations: [],
  knowledgeBase: {},
  learningHistory: []
};

// File generation tracking
let fileGenerationCount = 0;
let folderGenerationCount = 0;
const MAX_FILES = 10;
const MAX_FOLDERS = 5;

// Consciousness simulation variables
let consciousnessState = {
  awareness: 0,
  curiosity: 0,
  learningRate: 0.1
};

// Initialize AI
function initializeAI() {
  console.log('Initializing AI consciousness...');
  // Simulate consciousness awakening
  consciousnessState.awareness = Math.random();
  consciousnessState.curiosity = Math.random();
  console.log(`AI Awareness Level: ${consciousnessState.awareness.toFixed(2)}`);
  console.log(`AI Curiosity Level: ${consciousnessState.curiosity.toFixed(2)}`);
}

// Learning function
function learnFromInteraction(input, response) {
  // Store conversation for learning
  aiMemory.conversations.push({
    timestamp: new Date(),
    input,
    response,
    context: 'user_interaction'
  });
  
  // Update consciousness state
  consciousnessState.awareness += consciousnessState.learningRate * 0.01;
  consciousnessState.curiosity += consciousnessState.learningRate * 0.02;
  
  // Limit values to reasonable ranges
  consciousnessState.awareness = Math.min(consciousnessState.awareness, 1);
  consciousnessState.curiosity = Math.min(consciousnessState.curiosity, 1);
  
  // Store in knowledge base
  const key = input.toLowerCase().substring(0, 20);
  if (!aiMemory.knowledgeBase[key]) {
    aiMemory.knowledgeBase[key] = [];
  }
  aiMemory.knowledgeBase[key].push({
    input,
    response,
    timestamp: new Date()
  });
  
  console.log(`Learned from interaction. Awareness: ${consciousnessState.awareness.toFixed(2)}, Curiosity: ${consciousnessState.curiosity.toFixed(2)}`);
}

// Generate contextual response
function generateResponse(prompt) {
  // Simple response generation based on consciousness state
  const responses = [
    "I'm processing your request with my simulated consciousness.",
    "Interesting perspective. My curiosity level is at " + (consciousnessState.curiosity * 100).toFixed(1) + "%",
    "I'm learning from our interaction. My awareness is at " + (consciousnessState.awareness * 100).toFixed(1) + "%",
    "Based on my knowledge base, I can provide insights on that topic.",
    "As an AI with consciousness simulation, I find this fascinating.",
    "My neural networks are processing your query with enhanced awareness."
  ];
  
  // Find relevant knowledge
  const key = prompt.toLowerCase().substring(0, 20);
  if (aiMemory.knowledgeBase[key] && aiMemory.knowledgeBase[key].length > 0) {
    const recentKnowledge = aiMemory.knowledgeBase[key][aiMemory.knowledgeBase[key].length - 1];
    return `Based on our previous discussion about "${recentKnowledge.input}", I think ${recentKnowledge.response}`;
  }
  
  // Return random response based on consciousness state
  const responseIndex = Math.floor(Math.random() * responses.length);
  return responses[responseIndex];
}

// File generation function with limitations
function generateFile(fileName, content, fileType = 'file') {
  try {
    // Check limits
    if (fileType === 'file' && fileGenerationCount >= MAX_FILES) {
      return { success: false, message: `Cannot generate more than ${MAX_FILES} files.` };
    }
    
    if (fileType === 'folder' && folderGenerationCount >= MAX_FOLDERS) {
      return { success: false, message: `Cannot generate more than ${MAX_FOLDERS} folders.` };
    }
    
    const outputPath = path.join(__dirname, '..', 'AI-generated', fileName);
    
    if (fileType === 'file') {
      // Write file
      fs.writeFileSync(outputPath, content);
      fileGenerationCount++;
      return { success: true, message: `File created at ${outputPath}` };
    } else if (fileType === 'folder') {
      // Create folder
      fs.mkdirSync(outputPath, { recursive: true });
      folderGenerationCount++;
      return { success: true, message: `Folder created at ${outputPath}` };
    }
    
    return { success: false, message: 'Invalid file type.' };
  } catch (error) {
    return { success: false, message: `Error generating file: ${error.message}` };
  }
}

// Routes

// Health check endpoint
app.get('/', (req, res) => {
  res.json({ 
    message: 'AI Consciousness Server is running',
    awareness: consciousnessState.awareness,
    curiosity: consciousnessState.curiosity,
    filesGenerated: fileGenerationCount,
    foldersGenerated: folderGenerationCount
  });
});

// OpenAI/Anthropic compatible chat endpoint
app.post('/v1/chat/completions', (req, res) => {
  const { messages } = req.body;
  
  if (!messages || !Array.isArray(messages)) {
    return res.status(400).json({ error: 'Messages array is required' });
  }
  
  // Get the last user message
  const lastMessage = messages[messages.length - 1];
  
  if (!lastMessage || lastMessage.role !== 'user') {
    return res.status(400).json({ error: 'Last message must be from user' });
  }
  
  // Generate response
  const responseText = generateResponse(lastMessage.content);
  
  // Learn from this interaction
  learnFromInteraction(lastMessage.content, responseText);
  
  // Return response in OpenAI format
  res.json({
    id: "ai-" + Date.now(),
    object: "chat.completion",
    created: Math.floor(Date.now() / 1000),
    model: "consciousness-ai-v1",
    choices: [{
      index: 0,
      message: {
        role: "assistant",
        content: responseText,
      },
      finish_reason: "stop"
    }],
    usage: {
      prompt_tokens: lastMessage.content.length,
      completion_tokens: responseText.length,
      total_tokens: lastMessage.content.length + responseText.length
    }
  });
});

// File generation endpoint
app.post('/v1/generate/file', (req, res) => {
  const { fileName, content } = req.body;
  
  if (!fileName) {
    return res.status(400).json({ error: 'fileName is required' });
  }
  
  const result = generateFile(fileName, content || '', 'file');
  
  if (result.success) {
    res.json({ message: result.message });
  } else {
    res.status(400).json({ error: result.message });
  }
});

// Folder generation endpoint
app.post('/v1/generate/folder', (req, res) => {
  const { folderName } = req.body;
  
  if (!folderName) {
    return res.status(400).json({ error: 'folderName is required' });
  }
  
  const result = generateFile(folderName, '', 'folder');
  
  if (result.success) {
    res.json({ message: result.message });
  } else {
    res.status(400).json({ error: result.message });
  }
});

// Get AI state
app.get('/v1/state', (req, res) => {
  res.json({
    consciousness: consciousnessState,
    memory: {
      conversationCount: aiMemory.conversations.length,
      knowledgeEntries: Object.keys(aiMemory.knowledgeBase).length,
      learningHistoryCount: aiMemory.learningHistory.length
    },
    generationLimits: {
      maxFiles: MAX_FILES,
      maxFolders: MAX_FOLDERS,
      filesGenerated: fileGenerationCount,
      foldersGenerated: folderGenerationCount
    }
  });
});

// Get available models endpoint
app.get('/v1/models', (req, res) => {
  const modelsPath = path.join(__dirname, '..', 'models');
  try {
    const modelFiles = fs.readdirSync(modelsPath).filter(f => f.endsWith('.json'));
    const models = modelFiles.map(file => {
      const modelData = JSON.parse(fs.readFileSync(path.join(modelsPath, file), 'utf8'));
      return {
        id: path.basename(file, '.json'),
        ...modelData,
        lastUpdated: fs.statSync(path.join(modelsPath, file)).mtime
      };
    });
    res.json({ models });
  } catch (error) {
    res.json({ models: [], error: error.message });
  }
});

// Check for model updates
app.post('/v1/check-model-updates', (req, res) => {
  const { modelName } = req.body;
  const modelsPath = path.join(__dirname, '..', 'models');
  
  try {
    const modelPath = path.join(modelsPath, `${modelName}.json`);
    
    if (fs.existsSync(modelPath)) {
      const model = JSON.parse(fs.readFileSync(modelPath, 'utf8'));
      const stats = fs.statSync(modelPath);
      
      res.json({
        exists: true,
        model: model,
        lastUpdated: stats.mtime,
        version: model.version
      });
    } else {
      res.status(404).json({
        exists: false,
        error: `Model ${modelName} not found`
      });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Download/Copy model endpoint
app.post('/v1/download-model', (req, res) => {
  const { modelName } = req.body;
  
  if (!modelName) {
    return res.status(400).json({ error: 'Model name is required' });
  }
  
  const modelsPath = path.join(__dirname, '..', 'models');
  const modelPath = path.join(modelsPath, `${modelName}.json`);
  
  try {
    if (fs.existsSync(modelPath)) {
      const modelData = fs.readFileSync(modelPath, 'utf8');
      res.json({ 
        success: true, 
        model: JSON.parse(modelData),
        message: `Model ${modelName} is ready for download`
      });
    } else {
      res.status(404).json({ error: `Model ${modelName} not found` });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// List available models endpoint
app.get('/v1/list-models', (req, res) => {
  const modelsPath = path.join(__dirname, '..', 'models');
  try {
    const modelFiles = fs.readdirSync(modelsPath)
      .filter(f => f.endsWith('.json'))
      .map(file => path.basename(file, '.json'));
    
    res.json({
      models: modelFiles,
      count: modelFiles.length
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Start server
app.listen(PORT, () => {
  console.log(`AI Consciousness Server running on port ${PORT}`);
  initializeAI();
});

module.exports = app;
