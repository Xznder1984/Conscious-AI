# 🚀 Deploying Neuron with API to Vercel

This guide explains how to connect the Neuron API to your Vercel marketplace website.

## Overview

The marketplace website automatically fetches models from the Neuron API. You can:
- **Run locally** - website fetches from `localhost:3000`
- **Deploy to Vercel** - website can fetch from your own server or a remote Neuron instance

## Option 1: Local Development (Easy)

### Step 1: Start the Neuron Server

```powershell
neuron start
# Server runs on http://localhost:3000
```

### Step 2: Run the Website Locally

```bash
cd website
npm install
npm run dev
# Opens http://localhost:5173
```

The website automatically detects `localhost:3000` and fetches models from there.

---

## Option 2: Deploy Website to Vercel (With Self-Hosted API)

Perfect if you want the website on Vercel but the API running on your own server.

### Step 1: Push to GitHub

```bash
git add .
git commit -m "Add API integration to website"
git push origin main
```

### Step 2: Set Up Vercel Environment Variables

In your Vercel project settings, add:

```
VITE_API_URL=http://your-server-ip:3000
```

Or if using a domain:

```
VITE_API_URL=https://neuron-api.youromain.com
```

### Step 3: Configure API Access

Update `website/app.js` to use the environment variable:

```javascript
const API_ENDPOINTS = {
    local: import.meta.env.VITE_API_URL || 'http://localhost:3000/api/models',
    deployed: import.meta.env.VITE_API_URL || 'https://neuron-models.vercel.app/api/models',
    fallback: 'http://localhost:3000/api/models'
};
```

### Step 4: Ensure CORS is Enabled

The API already has CORS enabled:

```javascript
res.set('Access-Control-Allow-Origin', '*');
```

This allows cross-origin requests from any Vercel domain.

### Step 5: Make Server Publicly Accessible

If running Neuron locally, expose it with:

```bash
# Use ngrok (tunnel tool)
ngrok http 3000
# Gives you: https://xxxx-xx-xxx-xx-xxx.ngrok.app

# Update VITE_API_URL to the ngrok URL
```

Or use your own domain/server.

---

## Option 3: Deploy Everything to Vercel (Full Deployment)

You can also deploy the entire Node.js API to Vercel.

### Step 1: Create `api/models.js` in Vercel Functions

```bash
mkdir -p api
```

Create `api/models.js`:

```javascript
const fs = require('fs');
const path = require('path');

export default function handler(req, res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  
  const modelsPath = path.join(process.cwd(), 'models');
  
  try {
    const modelFiles = fs.readdirSync(modelsPath).filter(f => f.endsWith('.json'));
    const models = modelFiles.map(file => {
      const modelData = JSON.parse(fs.readFileSync(path.join(modelsPath, file), 'utf8'));
      return {
        id: path.basename(file, '.json'),
        name: modelData.name,
        version: modelData.version,
        description: modelData.description,
        awareness: modelData.awareness,
        curiosity: modelData.curiosity,
        learningRate: modelData.learningRate
      };
    });
    
    res.json({
      success: true,
      total: models.length,
      models: models
    });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
}
```

### Step 2: Update `vercel.json`

```json
{
  "buildCommand": "cd website && npm install && npm run build",
  "outputDirectory": "website/dist",
  "framework": "vite",
  "functions": {
    "api/**/*.js": {
      "runtime": "nodejs18.x"
    }
  }
}
```

### Step 3: Deploy

```bash
vercel deploy --prod
```

---

## Connecting to Vercel Deployment

After deploying, the website automatically:

1. **Detects the Vercel domain** (e.g., `neuron-models.vercel.app`)
2. **Fetches from** `https://neuron-models.vercel.app/api/models`
3. **Displays models** in the marketplace

---

## Testing the API Integration

### Test Locally

```powershell
# Start server
neuron start

# Test API from browser or PowerShell
Invoke-RestMethod -Uri "http://localhost:3000/api/models"
```

### Test on Vercel

```powershell
# After deployment
Invoke-RestMethod -Uri "https://your-vercel-domain.vercel.app/api/models"
```

---

## Troubleshooting

### "Cannot fetch models"

**Problem:** Website shows "Could not fetch from any endpoint"

**Solution:**
1. Ensure server is running: `neuron start`
2. Check API responds: `curl http://localhost:3000/api/models`
3. Check browser console for CORS errors
4. If deployed to Vercel, verify `VITE_API_URL` is set correctly

### CORS Errors

**Problem:** `Access-Control-Allow-Origin` error

**Solution:**
- The API already has CORS enabled
- Check that your API server is publicly accessible
- For local development, use `localhost:3000`

### Models Not Showing

**Problem:** Website loads but shows no models

**Solution:**
1. Check that models exist in `models/` directory
2. Verify API returns data: `http://localhost:3000/api/models`
3. Check website browser console for fetch errors

---

## Quick Commands

```bash
# Local development
neuron start                    # Start API server
cd website && npm run dev       # Start website

# Deploy to Vercel
git push origin main            # Auto-deploys if connected

# Manual Vercel deploy
vercel deploy --prod

# Test API
curl http://localhost:3000/api/models
curl https://your-domain/api/models
```

---

## Environment Variables

### For Vercel Deployments

Add to Vercel project settings:

| Variable | Value | Example |
|----------|-------|---------|
| `VITE_API_URL` | API base URL | `http://your-server:3000` |
| `VITE_APP_NAME` | App name | `Neuron Models` |

### For Local Development

Create `.env` file in `website/`:

```
VITE_API_URL=http://localhost:3000
VITE_APP_NAME=Neuron Models
```

---

## Next Steps

1. ✅ API endpoints configured
2. ✅ Website fetches from API
3. ✅ Ready for deployment
4. 🚀 Deploy to Vercel when ready!

See [README.md](../README.md) for more info.
