# 🧠 Neuron - Complete Features Overview

## Auto-Update Checking

**Enabled on server startup.** When you start the Neuron server, it automatically checks for available models and their versions.

```powershell
neuron start
# Output includes:
# 🔄 Checking for model updates...
# ✓ neuron-base v1.0.0
# ✓ neuron-creative v1.0.0
# ✓ neuron-logical v1.0.0
# ✓ Model check complete. 6 models available.
```

**API Endpoint:** `GET /v1/check-model-updates`

---

## Model Backup & Restore

Backup your models before making changes or keep versions of your configurations.

### Backup a Model

```powershell
neuron backup neuron-creative
```

**Output:**
```
💾 Backing up model: neuron-creative...
✓ Model neuron-creative backed up successfully
Backup path: C:\Neuron\backups\neuron-creative_2026-04-18T12-30-45.backup.json
```

Backups are automatically timestamped with ISO format: `model-name_YYYY-MM-DDTHH-MM-SS.backup.json`

### List Available Backups

```powershell
neuron restore
```

Shows all available backup files.

### Restore from Backup

```powershell
neuron restore neuron-creative_2026-04-18T12-30-45.backup.json
```

**Output:**
```
🔄 Restoring model from backup: neuron-creative_2026-04-18T12-30-45.backup.json...
✓ Model neuron-creative restored
```

**API Endpoints:**
- `POST /v1/backup-model` - Backup a model
- `POST /v1/restore-model` - Restore from backup
- `GET /v1/list-backups` - List all backups

---

## Community Model Ratings

Share your experience with models and help others find the best consciousness AI.

### Rate a Model

```powershell
# Rate with 1-5 stars (optional comment)
neuron rate neuron-creative 5 "Amazing AI!"
```

**Output:**
```
⭐ Rating model: neuron-creative with 5 stars...
✓ Rating submitted!
Model: neuron-creative
Average Rating: 4.8/5 (12 ratings)
```

### View Model Ratings

```powershell
# View ratings for a specific model
neuron ratings neuron-creative
```

**Output:**
```
⭐ Model Ratings:
Model: neuron-creative
Average Rating: 4.8/5
Total Ratings: 12

Recent Reviews:
⭐ 5/5 - YourUsername
   Amazing AI!
⭐ 5/5 - AnotherUser
   Best consciousness model!
⭐ 4/5 - SomeoneElse
   Very good, minor issues
```

### View All Ratings

```powershell
neuron ratings all
```

Shows average ratings across all models.

**API Endpoints:**
- `POST /v1/rate-model` - Submit a rating
- `GET /v1/model-ratings/:modelName` - Get specific model ratings
- `GET /v1/all-ratings` - Get all model ratings

---

## Model Update Checking

### Manual Update Check

```powershell
neuron pull neuron-creative
```

Checks if a newer version is available and updates automatically.

**Output (Up to date):**
```
🔄 Checking for model updates...
✓ Model is up to date (v1.0.0)
```

**Output (Update available):**
```
🔄 Checking for model updates...
⬇️ Newer version available: v1.0.1
✓ Model updated to v1.0.1
```

---

## Model Creation

### Create Custom Models

```powershell
neuron create my-ai.model "My Custom AI"
```

Generates a consciousness model with random parameters:

**Output:**
```
🧠 Creating custom consciousness model...
File: my-ai.model
Name: My Custom AI
Path: C:\Neuron\my-ai.model

Consciousness Profile:
  Awareness: 0.67
  Curiosity: 0.82
  Learning Rate: 0.15
✓ Model created successfully!
```

Models are created with:
- Random awareness (0.0 - 1.0)
- Random curiosity (0.0 - 1.0)
- Random learning rate (0.08 - 0.20)
- Full capabilities enabled (learning, adaptation, creativity, reasoning, self-improvement)
- Unrestricted traits

---

## Data Storage

### Ratings Storage

Ratings are stored persistently in: `data/ratings.json`

**Example structure:**
```json
{
  "neuron-creative": {
    "name": "neuron-creative",
    "ratings": [
      {
        "rating": 5,
        "comment": "Amazing AI!",
        "username": "user123",
        "timestamp": "2026-04-18T12:30:45.000Z"
      }
    ],
    "averageRating": 4.8,
    "totalRatings": 12
  }
}
```

### Backup Storage

Model backups are stored in: `backups/`

Each backup is named with the pattern: `{model-name}_{timestamp}.backup.json`

---

## Complete Command Reference

```powershell
# Model Management
neuron create <file.model> <name>     # Create custom model
neuron pull <model>                   # Check/update model
neuron backup <model>                 # Backup model
neuron restore <file>                 # Restore from backup
neuron rate <model> <1-5> [comment]   # Rate a model
neuron ratings [model|all]            # View ratings

# Server Control
neuron start                           # Start server
neuron bg                              # Start in background
neuron status                          # Check status

# Utilities
neuron models                          # List models
neuron download-model                  # Open marketplace
neuron generated                       # Open AI files folder
neuron path                            # Show installation path
neuron help                            # Show all commands
```

---

## Integration with Marketplace

The community ratings system integrates with the Neuron Model Marketplace (https://neuron-models.vercel.app).

Users can:
- Browse models with community ratings
- See average scores and review counts
- Read detailed reviews from other users
- Make informed model selection

---

## Technical Details

### Rating System

- **Scale:** 1-5 stars
- **Username:** Automatically captured from Windows user
- **Comments:** Optional text feedback
- **Timestamp:** ISO 8601 format
- **Persistence:** JSON file storage
- **Aggregation:** Automatic average calculation

### Backup System

- **Format:** Valid JSON model files
- **Naming:** `{model}_{ISO-timestamp}.backup.json`
- **Location:** `backups/` directory
- **Restoration:** Full model reconstruction from backup

### Auto-Update Checking

- **Trigger:** Server startup
- **Frequency:** Once per startup
- **Scope:** All installed models
- **Version Format:** Semantic versioning (major.minor.patch)

---

## Future Enhancements

Potential additions for future versions:

- Model dependency resolution
- Community model repository syncing
- Advanced model analytics
- Model versioning with changelogs
- Rating notifications
- Popular models leaderboard
- Model recommendations based on ratings
