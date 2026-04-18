const { spawn } = require('child_process');
const path = require('path');

// Start the AI server as a background process
const serverProcess = spawn('node', ['src/server.js'], {
  cwd: __dirname,
  detached: true,
  stdio: 'ignore'
});

// Exit this script but keep the server running
serverProcess.unref();
console.log('AI Consciousness Server started in background');
console.log('Server PID:', serverProcess.pid);
console.log('Access the API at http://localhost:3000');
