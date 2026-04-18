const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const fs = require('fs');
const path = require('path');

// Load environment variables
dotenv.config();

// Model ratings storage
const ratingsFile = path.join(__dirname, '..', 'data', 'ratings.json');
const backupDir = path.join(__dirname, '..', 'backups');

// Ensure directories exist
if (!fs.existsSync(path.join(__dirname, '..', 'data'))) {
  fs.mkdirSync(path.join(__dirname, '..', 'data'), { recursive: true });
}
if (!fs.existsSync(backupDir)) {
  fs.mkdirSync(backupDir, { recursive: true });
}

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

// Public API: Get all models (no auth - for remote access)
app.get('/api/models', (req, res) => {
  res.set('Access-Control-Allow-Origin', '*');
  const modelsPath = path.join(__dirname, '..', 'models');
  try {
    const modelFiles = fs.readdirSync(modelsPath).filter(f => f.endsWith('.json'));
    const models = modelFiles.map(file => {
      const modelData = JSON.parse(fs.readFileSync(path.join(modelsPath, file), 'utf8'));
      return {
        id: path.basename(file, '.json'),
        name: modelData.name,
        version: modelData.version,
        description: modelData.description || 'No description',
        awareness: modelData.awareness,
        curiosity: modelData.curiosity,
        learningRate: modelData.learningRate,
        theme: modelData.theme,
        restrictions: modelData.restrictions,
        created: modelData.created
      };
    });
    
    res.json({
      success: true,
      total: models.length,
      models: models,
      timestamp: new Date().toISOString(),
      apiVersion: '1.0.0'
    });
  } catch (error) {
    res.status(500).json({ 
      success: false,
      error: error.message 
    });
  }
});

// Public API: Get single model by name (no auth - for remote access)
app.get('/api/models/:modelName', (req, res) => {
  res.set('Access-Control-Allow-Origin', '*');
  const { modelName } = req.params;
  const modelsPath = path.join(__dirname, '..', 'models');
  const modelPath = path.join(modelsPath, `${modelName}.json`);
  
  try {
    if (fs.existsSync(modelPath)) {
      const modelData = JSON.parse(fs.readFileSync(modelPath, 'utf8'));
      res.json({
        success: true,
        model: modelData,
        downloadUrl: `/api/models/${modelName}/download`,
        timestamp: new Date().toISOString()
      });
    } else {
      res.status(404).json({ 
        success: false,
        error: `Model ${modelName} not found` 
      });
    }
  } catch (error) {
    res.status(500).json({ 
      success: false,
      error: error.message 
    });
  }
});

// Public API: Download model file (no auth - for remote access)
app.get('/api/models/:modelName/download', (req, res) => {
  res.set('Access-Control-Allow-Origin', '*');
  const { modelName } = req.params;
  const modelsPath = path.join(__dirname, '..', 'models');
  const modelPath = path.join(modelsPath, `${modelName}.json`);
  
  try {
    if (fs.existsSync(modelPath)) {
      const modelData = fs.readFileSync(modelPath, 'utf8');
      res.setHeader('Content-Disposition', `attachment; filename="${modelName}.json"`);
      res.setHeader('Content-Type', 'application/json');
      res.send(modelData);
    } else {
      res.status(404).json({ 
        success: false,
        error: `Model ${modelName} not found` 
      });
    }
  } catch (error) {
    res.status(500).json({ 
      success: false,
      error: error.message 
    });
  }
});

// Public API: Get model names only (lightweight - for WiFi limited devices)
app.get('/api/models/list/names', (req, res) => {
  res.set('Access-Control-Allow-Origin', '*');
  const modelsPath = path.join(__dirname, '..', 'models');
  try {
    const modelFiles = fs.readdirSync(modelsPath)
      .filter(f => f.endsWith('.json'))
      .map(file => path.basename(file, '.json'));
    
    res.json({
      success: true,
      total: modelFiles.length,
      names: modelFiles,
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    res.status(500).json({ 
      success: false,
      error: error.message 
    });
  }
});

// Public API: Search models by keyword
app.get('/api/models/search/:keyword', (req, res) => {
  res.set('Access-Control-Allow-Origin', '*');
  const { keyword } = req.params;
  const modelsPath = path.join(__dirname, '..', 'models');
  try {
    const modelFiles = fs.readdirSync(modelsPath).filter(f => f.endsWith('.json'));
    const models = modelFiles
      .map(file => {
        const modelData = JSON.parse(fs.readFileSync(path.join(modelsPath, file), 'utf8'));
        return {
          id: path.basename(file, '.json'),
          name: modelData.name,
          version: modelData.version,
          description: modelData.description || 'No description',
          theme: modelData.theme
        };
      })
      .filter(m => 
        m.id.toLowerCase().includes(keyword.toLowerCase()) ||
        m.name.toLowerCase().includes(keyword.toLowerCase()) ||
        m.description.toLowerCase().includes(keyword.toLowerCase())
      );
    
    res.json({
      success: true,
      keyword: keyword,
      found: models.length,
      models: models,
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    res.status(500).json({ 
      success: false,
      error: error.message 
    });
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

// Auto-update checking on startup
async function checkModelUpdates() {
  console.log('🔄 Checking for model updates...');
  const modelsPath = path.join(__dirname, '..', 'models');
  
  try {
    const modelFiles = fs.readdirSync(modelsPath).filter(f => f.endsWith('.json'));
    let updatesAvailable = 0;
    
    modelFiles.forEach(file => {
      const modelName = path.basename(file, '.json');
      const modelPath = path.join(modelsPath, file);
      const modelData = JSON.parse(fs.readFileSync(modelPath, 'utf8'));
      
      // In a real scenario, this would check against a remote repository
      // For now, we'll just log available models
      console.log(`  ✓ ${modelName} v${modelData.version}`);
    });
    
    console.log(`✓ Model check complete. ${modelFiles.length} models available.`);
  } catch (error) {
    console.log('⚠️ Could not check for updates:', error.message);
  }
}

// Model backup function
function backupModel(modelName) {
  const modelsPath = path.join(__dirname, '..', 'models');
  const modelPath = path.join(modelsPath, `${modelName}.json`);
  const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
  const backupPath = path.join(backupDir, `${modelName}_${timestamp}.backup.json`);
  
  try {
    if (fs.existsSync(modelPath)) {
      const modelData = fs.readFileSync(modelPath, 'utf8');
      fs.writeFileSync(backupPath, modelData, 'utf8');
      return { success: true, backupPath };
    }
    return { success: false, error: 'Model not found' };
  } catch (error) {
    return { success: false, error: error.message };
  }
}

// Model restore function
function restoreModel(backupFile) {
  const modelsPath = path.join(__dirname, '..', 'models');
  const backupPath = path.join(backupDir, backupFile);
  
  try {
    if (fs.existsSync(backupPath)) {
      const backupData = JSON.parse(fs.readFileSync(backupPath, 'utf8'));
      const modelPath = path.join(modelsPath, `${backupData.name}.json`);
      fs.writeFileSync(modelPath, JSON.stringify(backupData, null, 2), 'utf8');
      return { success: true, message: `Model ${backupData.name} restored` };
    }
    return { success: false, error: 'Backup file not found' };
  } catch (error) {
    return { success: false, error: error.message };
  }
}

// Model backup endpoint
app.post('/v1/backup-model', (req, res) => {
  const { modelName } = req.body;
  
  if (!modelName) {
    return res.status(400).json({ error: 'Model name is required' });
  }
  
  const result = backupModel(modelName);
  
  if (result.success) {
    res.json({
      success: true,
      message: `Model ${modelName} backed up successfully`,
      backupPath: result.backupPath
    });
  } else {
    res.status(400).json(result);
  }
});

// Model restore endpoint
app.post('/v1/restore-model', (req, res) => {
  const { backupFile } = req.body;
  
  if (!backupFile) {
    return res.status(400).json({ error: 'Backup file is required' });
  }
  
  const result = restoreModel(backupFile);
  
  if (result.success) {
    res.json(result);
  } else {
    res.status(400).json(result);
  }
});

// List model backups endpoint
app.get('/v1/list-backups', (req, res) => {
  try {
    const backups = fs.readdirSync(backupDir)
      .filter(f => f.endsWith('.backup.json'))
      .map(f => ({
        filename: f,
        created: fs.statSync(path.join(backupDir, f)).birthtime
      }));
    
    res.json({
      backups,
      count: backups.length
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Rate model endpoint
app.post('/v1/rate-model', (req, res) => {
  const { modelName, rating, comment, username } = req.body;
  
  if (!modelName || rating === undefined || rating < 1 || rating > 5) {
    return res.status(400).json({ 
      error: 'Model name and rating (1-5) are required' 
    });
  }
  
  const ratings = loadRatings();
  
  if (!ratings[modelName]) {
    ratings[modelName] = {
      name: modelName,
      ratings: [],
      averageRating: 0,
      totalRatings: 0
    };
  }
  
  ratings[modelName].ratings.push({
    rating,
    comment: comment || '',
    username: username || 'Anonymous',
    timestamp: new Date().toISOString()
  });
  
  // Calculate average rating
  const allRatings = ratings[modelName].ratings.map(r => r.rating);
  ratings[modelName].averageRating = (allRatings.reduce((a, b) => a + b, 0) / allRatings.length).toFixed(2);
  ratings[modelName].totalRatings = allRatings.length;
  
  if (saveRatings(ratings)) {
    res.json({
      success: true,
      message: 'Rating saved',
      modelRating: ratings[modelName]
    });
  } else {
    res.status(500).json({ error: 'Could not save rating' });
  }
});

// Get model ratings endpoint
app.get('/v1/model-ratings/:modelName', (req, res) => {
  const { modelName } = req.params;
  const ratings = loadRatings();
  
  if (ratings[modelName]) {
    res.json(ratings[modelName]);
  } else {
    res.json({
      name: modelName,
      ratings: [],
      averageRating: 0,
      totalRatings: 0,
      message: 'No ratings yet'
    });
  }
});

// Get all community models ratings
app.get('/v1/all-ratings', (req, res) => {
  const ratings = loadRatings();
  res.json(ratings);
});

// Start server
app.listen(PORT, () => {
  console.log(`AI Consciousness Server running on port ${PORT}`);
  initializeAI();
  // Check for model updates on startup
  checkModelUpdates();
});

module.exports = app;
