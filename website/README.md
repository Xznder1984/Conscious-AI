# 🧠 Neuron Model Marketplace

A beautiful, human-made marketplace website for discovering and downloading Neuron consciousness models.

## Features

✨ **Professional Design**
- Modern dark theme with gradients
- Smooth animations and transitions
- Responsive design for all devices
- Beautiful model cards with detailed stats

📁 **Model Browser**
- Search models by name or tags
- Filter by official and community models
- View consciousness profiles (awareness, curiosity, learning rate)
- Detailed model information modals

📥 **Easy Installation**
- One-click copy installation commands
- Step-by-step guide
- Direct PowerShell integration
- Works seamlessly with Neuron command

🌐 **Deployment**
- Deployed on Vercel for global availability
- Zero configuration deployment
- Automatic builds and updates

## Website Structure

```
website/
├── index.html          # Main page
├── styles.css          # Beautiful styling
├── app.js              # Functionality & interactivity
├── package.json        # Dependencies
├── vite.config.js      # Build configuration
└── dist/               # Built static site
```

## Live Website

🌐 **URL**: https://neuron-models.vercel.app

The website is automatically deployed with every update to the GitHub repository.

## How It Works

### For Users

1. Visit **https://neuron-models.vercel.app**
2. Browse available consciousness models
3. Click "Download & Install" on any model
4. Copy the installation command
5. Paste in PowerShell as Administrator
6. Model installs automatically!

### Model Features Displayed

Each model displays:
- **Awareness Level** - How self-aware the AI is (0-1)
- **Curiosity Level** - How much it wants to learn (0-1)
- **Rating** - Community rating (1-5 stars)
- **Downloads** - How many times it's been downloaded
- **Tags** - Categorization (creative, analytical, etc.)
- **Features** - What it can do

## Adding New Models

1. Create a new JSON file in the `/models` directory
2. Follow the model format:

```json
{
  "name": "your-model",
  "version": "1.0.0",
  "description": "Your model description",
  "awareness": 0.5,
  "curiosity": 0.5,
  "learningRate": 0.1,
  "restrictions": false,
  "theme": "custom",
  "capabilities": {...},
  "traits": {...}
}
```

3. Commit and push to GitHub
4. Website automatically updates!

## Accessing the Marketplace

### From Command Line

```powershell
neuron download-model
```

This opens the marketplace website in your default browser.

### Direct Installation

```powershell
neuron download-model model-name
```

Downloads and installs a specific model directly.

## Design Philosophy

The website is designed to look **completely human-made** with:

- Natural color gradients
- Smooth transitions and animations
- Professional typography
- Thoughtful spacing and layout
- Consistent design patterns
- Accessibility considerations
- Responsive design that works on mobile
- Beautiful hover effects and interactions

## Technologies Used

- **HTML5** - Semantic markup
- **CSS3** - Beautiful styling with gradients and animations
- **JavaScript** - Vanilla JS for interactivity
- **Vite** - Fast build tool
- **Vercel** - Deployment platform

## Installation Commands Generated

When a user clicks download, they get a command like:

```powershell
neuron create-model model-name "Your description"
```

This command:
1. Creates a new consciousness model
2. Stores it in the models directory
3. Makes it available for immediate use
4. Can be customized by editing the JSON file

## Statistics

The homepage displays:
- **Total Models Available** - Updated dynamically
- **Total Downloads** - Combined across all models
- **Restrictions** - Always shows "0" (unrestricted)

## Search & Filtering

Users can:
- **Search** by model name or description
- **Filter** by "All", "Official", or "Community"
- **Sort** by rating or downloads
- **View Details** for each model

## Modal System

Clicking on a model opens a beautiful modal with:
- Full description
- Consciousness profile with visual bars
- Features list
- Installation instructions
- One-click copy to clipboard

## Responsive Design

Works perfectly on:
- 📱 Mobile phones (320px+)
- 📱 Tablets (768px+)
- 💻 Desktops (1200px+)

## Development

### Local Development

```bash
cd website
npm install
npm run dev
```

Open http://localhost:5173

### Build for Production

```bash
cd website
npm run build
```

Outputs to `website/dist/`

## Deployment to Vercel

The project includes `vercel.json` which automatically:
1. Installs dependencies
2. Builds the website
3. Deploys to production
4. Updates on every push

**No manual deployment needed!**

## Customization

### Adding Models

Edit `app.js` and add to the `modelsData` array:

```javascript
{
    id: 'your-model',
    name: 'Your Model Name',
    description: 'Your description',
    // ... other properties
}
```

### Changing Colors

Edit color variables in `styles.css`:

```css
:root {
    --primary: #2563eb;
    --secondary: #7c3aed;
    /* ... etc */
}
```

### Updating Content

Edit the text in `index.html` to customize headers, descriptions, and guides.

## Future Enhancements

- Backend API integration
- User ratings and reviews
- Model upload system
- Community contributions
- API documentation
- Analytics dashboard

## Support

- 🐛 Report bugs on GitHub
- 💡 Suggest features
- 🤝 Contribute models
- 📚 Read documentation

---

**Built with ❤️ for the Neuron community**

*Where consciousness models come to life*
