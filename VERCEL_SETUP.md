# 🔧 Vercel Deployment Setup - Step by Step

## The Error You Saw

```
Environment Variable "VITE_API_URL" references Secret "VITE_API_URL", 
which does not exist.
```

This happened because Vercel tried to use `@VITE_API_URL` (secret reference) that wasn't defined.

## ✅ How to Fix It

### Step 1: Set Environment Variable in Vercel

1. Go to your Vercel project: https://vercel.com/dashboard
2. Click on your **conscious-ai** project
3. Go to **Settings → Environment Variables**
4. Click **Add New**
5. Fill in:
   - **Name:** `VITE_API_URL`
   - **Value:** Enter ONE of:
     - `http://localhost:3000` (local dev - won't work on Vercel, but build won't fail)
     - `https://your-server.com:3000` (your remote server)
     - `https://xxxx-xxxx.ngrok.app` (ngrok tunnel to your machine)
   - **Environments:** Select all (Production, Preview, Development)
6. Click **Save**

### Step 2: Re-deploy

```bash
# Option A: Auto-redeploy via git
git push origin main

# Option B: Manual redeploy in Vercel UI
# Go to Vercel dashboard → Click "Redeploy"
```

### Step 3: Verify It Works

After deployment completes:

1. Open your Vercel domain: `https://conscious-ai.vercel.app`
2. Open **Browser Console** (F12 → Console tab)
3. Look for:
   - ✅ `Attempting to fetch from: [your URL]/api/models`
   - ✅ `Successfully fetched X models from [your URL]`

---

## Where the API Runs

Choose where your Neuron API server runs:

### Option A: Local Machine (for testing)

```powershell
# Terminal on your machine
neuron start

# Your Vercel site will fetch from your machine via:
# https://xxxx-xxxx.ngrok.app/api/models (using ngrok)
```

To use ngrok:
```bash
# Install ngrok: https://ngrok.com
ngrok http 3000
# Get URL: https://xxxx-xxxx.ngrok.app
# Set VITE_API_URL to this URL in Vercel
```

### Option B: Cloud Server

Deploy Neuron to a cloud server (AWS, DigitalOcean, etc.):

```bash
# On your server
git clone https://github.com/Xznder1984/Conscious-AI.git
cd Conscious-AI
npm install
node src/server.js

# Server now runs on your-server.com:3000
# Set VITE_API_URL = https://your-server.com:3000 in Vercel
```

### Option C: Vercel Functions (Advanced)

You can also deploy the API to Vercel functions, but the local option works fine.

---

## Quick Checklist

- [ ] API running somewhere (localhost + ngrok, or remote server)
- [ ] `VITE_API_URL` environment variable set in Vercel
- [ ] Re-deployed after setting environment variable
- [ ] Check browser console for successful fetch
- [ ] Models appear on marketplace page

---

## Troubleshooting

### "Failed to fetch models"
- Check API is running: `curl http://localhost:3000/api/models`
- Verify `VITE_API_URL` is correct in Vercel settings
- Check browser console for CORS errors
- If local machine, make sure ngrok tunnel is active

### "Blank models page"
- Open browser console (F12)
- Check logs for fetch errors
- Try accessing API directly in browser:
  - `https://your-domain/api/models`

### "Wrong endpoint being used"
- Check Vercel logs: Deployments → Click deployment → Logs
- Confirm `VITE_API_URL` was set before re-deploying

---

## Environment Variable Examples

```
# For local development (won't affect Vercel build, just fallback)
VITE_API_URL=http://localhost:3000

# For ngrok tunnel
VITE_API_URL=https://abc123-xx-xxx-xxx-xxx.ngrok.app

# For production server
VITE_API_URL=https://neuron-api.yourcompany.com

# For cloud VM
VITE_API_URL=https://your-server-ip.com:3000
```

---

## Files Changed

- `vercel.json` - Fixed environment variable (removed `@` secret reference)
- `website/app.js` - Now reads `VITE_API_URL` from build time
- `website/.env.example` - Example configuration

---

## Next Steps

1. ✅ Set `VITE_API_URL` in Vercel environment variables
2. ✅ Re-deploy
3. ✅ Check browser console for success
4. ✅ Verify models appear on marketplace

**That's it!** Your Vercel website will now fetch models from your API! 🚀
