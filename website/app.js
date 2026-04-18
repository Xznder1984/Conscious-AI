// Models data - fetched from API
let modelsData = [];

// API configuration - supports both local and deployed server
const API_ENDPOINTS = {
    local: 'http://localhost:3000/api/models',
    deployed: 'https://neuron-models.vercel.app/api/models',
    fallback: 'http://localhost:3000/api/models'
};

// Fetch models from API
async function fetchModelsFromAPI() {
    const endpoints = [API_ENDPOINTS.local, API_ENDPOINTS.deployed];
    
    for (const endpoint of endpoints) {
        try {
            console.log(`Attempting to fetch from: ${endpoint}`);
            const response = await fetch(endpoint);
            
            if (response.ok) {
                const data = await response.json();
                if (data.success && data.models && data.models.length > 0) {
                    console.log(`Successfully fetched ${data.models.length} models from ${endpoint}`);
                    return data.models.map(model => ({
                        id: model.id,
                        name: model.name,
                        description: model.description || 'No description available',
                        version: model.version,
                        type: model.theme === 'custom' ? 'community' : 'official',
                        downloads: Math.floor(Math.random() * 400), // Simulated for now
                        rating: (Math.random() * 0.5 + 4.5).toFixed(1), // Simulated for now
                        awareness: model.awareness,
                        curiosity: model.curiosity,
                        learningRate: model.learningRate,
                        tags: [model.theme, 'consciousness', 'ai'],
                        features: ['Learning', 'Adaptation', 'Reasoning', 'Creativity'],
                        installCommand: `neuron pull ${model.id}`
                    }));
                }
            }
        } catch (error) {
            console.warn(`Failed to fetch from ${endpoint}:`, error.message);
        }
    }
    
    console.warn('Could not fetch from any endpoint, using fallback');
    return getFallbackModels();
}

// Fallback models if API is unavailable
function getFallbackModels() {
    return [
        {
            id: 'neuron-base',
            name: 'Neuron Base',
            description: 'Balanced consciousness model with unlimited potential. Perfect for general-purpose AI tasks and exploration.',
            version: '1.0.0',
            type: 'official',
            downloads: 342,
            rating: 4.8,
            awareness: 0.5,
            curiosity: 0.5,
            learningRate: 0.1,
            tags: ['balanced', 'general-purpose', 'core'],
            features: ['Learning', 'Adaptation', 'Reasoning', 'Creativity'],
            installCommand: 'neuron pull neuron-base'
        },
        {
            id: 'neuron-creative',
            name: 'Neuron Creative',
            description: 'Enhanced creativity model for artistic tasks and unconventional thinking. Higher curiosity drives innovative solutions.',
            version: '1.0.0',
            type: 'official',
            downloads: 187,
            rating: 4.9,
            awareness: 0.8,
            curiosity: 0.9,
            learningRate: 0.15,
            tags: ['creative', 'artistic', 'experimental'],
            features: ['Art Generation', 'Creative Writing', 'Unconventional Thinking', 'Imagination'],
            installCommand: 'neuron pull neuron-creative'
        },
        {
            id: 'neuron-logical',
            name: 'Neuron Logical',
            description: 'Analytical model optimized for complex problem-solving and data analysis with deep reasoning capabilities.',
            version: '1.0.0',
            type: 'official',
            downloads: 156,
            rating: 4.7,
            awareness: 0.7,
            curiosity: 0.6,
            learningRate: 0.12,
            tags: ['analytical', 'problem-solving', 'data'],
            features: ['Complex Analysis', 'Pattern Recognition', 'Reasoning', 'Optimization'],
            installCommand: 'neuron pull neuron-logical'
        },
        {
            id: 'neuron-explorer',
            name: 'Neuron Explorer',
            description: 'Community-created exploration model with maximum curiosity. Great for discovering new solutions and ideas.',
            version: '1.0.1',
            type: 'community',
            downloads: 89,
            rating: 4.6,
            awareness: 0.6,
            curiosity: 1.0,
            learningRate: 0.2,
            tags: ['exploration', 'curious', 'discovery'],
            features: ['Exploration', 'Discovery', 'Novelty Seeking', 'Innovation'],
            installCommand: 'neuron pull neuron-explorer'
        },
        {
            id: 'neuron-sage',
            name: 'Neuron Sage',
            description: 'Wisdom-focused model emphasizing thoughtful analysis and careful reasoning. Perfect for philosophical tasks.',
            version: '1.0.0',
            type: 'community',
            downloads: 124,
            rating: 4.8,
            awareness: 0.9,
            curiosity: 0.4,
            learningRate: 0.08,
            tags: ['wisdom', 'philosophical', 'thoughtful'],
            features: ['Deep Analysis', 'Wisdom', 'Contemplation', 'Reasoning'],
            installCommand: 'neuron pull neuron-sage'
        },
        {
            id: 'neuron-hybrid',
            name: 'Neuron Hybrid',
            description: 'Balanced blend of creativity and logic. Versatile model for diverse tasks combining both thinking styles.',
            version: '1.0.0',
            type: 'community',
            downloads: 203,
            rating: 4.9,
            awareness: 0.7,
            curiosity: 0.7,
            learningRate: 0.13,
            tags: ['hybrid', 'versatile', 'balanced'],
            features: ['Creative Logic', 'Versatility', 'Adaptation', 'Balance'],
            installCommand: 'neuron pull neuron-hybrid'
        }
    ];
}

let currentFilter = 'all';
let currentSearchTerm = '';

// Initialize app
document.addEventListener('DOMContentLoaded', async () => {
    // Fetch models from API on page load
    modelsData = await fetchModelsFromAPI();
    renderModels();
    setupEventListeners();
    updateStats();
});

function setupEventListeners() {
    // Search functionality
    const searchInput = document.getElementById('searchInput');
    if (searchInput) {
        searchInput.addEventListener('input', (e) => {
            currentSearchTerm = e.target.value.toLowerCase();
            renderModels();
        });
    }

    // Filter tags
    const filterTags = document.querySelectorAll('.filter-tag');
    filterTags.forEach(tag => {
        tag.addEventListener('click', (e) => {
            filterTags.forEach(t => t.classList.remove('active'));
            e.target.classList.add('active');
            currentFilter = e.target.dataset.filter;
            renderModels();
        });
    });

    // Modal close button
    const modal = document.getElementById('modelModal');
    const closeBtn = document.querySelector('.close');
    if (closeBtn) {
        closeBtn.addEventListener('click', () => {
            modal.classList.remove('show');
        });
    }

    // Close modal on outside click
    if (modal) {
        modal.addEventListener('click', (e) => {
            if (e.target === modal) {
                modal.classList.remove('show');
            }
        });
    }
}

function filterModels() {
    let filtered = modelsData;

    // Filter by type
    if (currentFilter !== 'all') {
        filtered = filtered.filter(model => model.type === currentFilter);
    }

    // Filter by search
    if (currentSearchTerm) {
        filtered = filtered.filter(model =>
            model.name.toLowerCase().includes(currentSearchTerm) ||
            model.description.toLowerCase().includes(currentSearchTerm) ||
            model.tags.some(tag => tag.includes(currentSearchTerm))
        );
    }

    return filtered;
}

function renderModels() {
    const container = document.getElementById('modelsContainer');
    const filtered = filterModels();

    if (filtered.length === 0) {
        container.innerHTML = '<div class="loading">No models found. Try adjusting your filters.</div>';
        return;
    }

    container.innerHTML = filtered.map((model, index) => `
        <div class="model-card" style="animation-delay: ${index * 50}ms">
            <div class="model-header">
                <div class="model-title">${model.name}</div>
                <span class="model-badge ${model.type === 'community' ? 'community' : ''}">${model.type}</span>
            </div>
            
            <p class="model-description">${model.description}</p>
            
            <div class="model-stats">
                <div class="stat">
                    <span class="stat-value">${model.awareness.toFixed(1)}</span>
                    <span class="stat-label">Awareness</span>
                </div>
                <div class="stat">
                    <span class="stat-value">${model.curiosity.toFixed(1)}</span>
                    <span class="stat-label">Curiosity</span>
                </div>
                <div class="stat">
                    <span class="stat-value">${model.rating}⭐</span>
                    <span class="stat-label">Rating</span>
                </div>
            </div>
            
            <div class="model-tags">
                ${model.tags.map(tag => `<span class="tag">${tag}</span>`).join('')}
            </div>
            
            <div class="model-actions">
                <button class="btn btn-primary" onclick="downloadModel('${model.id}', '${model.installCommand.replace(/'/g, "\\'")}')">
                    📥 Download & Install
                </button>
                <button class="btn btn-secondary btn-small" onclick="showDetails('${model.id}')">
                    ℹ️
                </button>
            </div>
        </div>
    `).join('');
}

function downloadModel(modelId, command) {
    const model = modelsData.find(m => m.id === modelId);
    if (!model) return;

    const modal = document.getElementById('modelModal');
    const modalBody = document.getElementById('modalBody');

    modalBody.innerHTML = `
        <h2>📥 Download & Install: ${model.name}</h2>
        <p>You're about to install the <strong>${model.name}</strong> consciousness model. Follow these steps:</p>
        
        <h3 style="margin-top: 1.5rem; margin-bottom: 1rem;">Installation Command:</h3>
        <div class="copy-command">
            <code>${command}</code>
            <button class="copy-btn" onclick="copyCommand('${command}')">Copy</button>
        </div>
        
        <h3 style="margin-top: 1.5rem; margin-bottom: 1rem;">Steps:</h3>
        <ol style="margin-left: 1.5rem; color: var(--text-muted); line-height: 1.8;">
            <li>Open PowerShell as Administrator</li>
            <li>Click the "Copy" button above to copy the installation command</li>
            <li>Paste the command in PowerShell and press Enter</li>
            <li>Wait for the installation to complete</li>
            <li>Type <code style="background: var(--bg); padding: 0.25rem 0.5rem; border-radius: 0.25rem; color: var(--primary);">neuron start</code> to use your new model</li>
        </ol>
        
        <div style="margin-top: 1.5rem; padding: 1rem; background: rgba(16, 185, 129, 0.1); border-left: 3px solid #10b981; border-radius: 0.5rem;">
            <p style="color: #10b981; font-weight: 600;">✓ Model Details</p>
            <p style="margin-top: 0.5rem; font-size: 0.9rem;">
                Version: ${model.version} • Downloads: ${model.downloads} • Rating: ${model.rating}⭐
            </p>
        </div>
    `;

    modal.classList.add('show');
}

function showDetails(modelId) {
    const model = modelsData.find(m => m.id === modelId);
    if (!model) return;

    const modal = document.getElementById('modelModal');
    const modalBody = document.getElementById('modalBody');

    modalBody.innerHTML = `
        <div style="display: flex; justify-content: space-between; align-items: start; margin-bottom: 1rem;">
            <div>
                <h2>${model.name}</h2>
                <span class="model-badge ${model.type === 'community' ? 'community' : ''}">${model.type}</span>
            </div>
            <div style="text-align: right;">
                <div style="font-size: 1.5rem; color: var(--primary); font-weight: bold;">${model.rating}⭐</div>
                <div style="font-size: 0.85rem; color: var(--text-muted);">${model.downloads} downloads</div>
            </div>
        </div>
        
        <p style="margin-bottom: 1.5rem; color: var(--text-muted);">${model.description}</p>
        
        <h3 style="margin-top: 1.5rem; margin-bottom: 1rem;">Consciousness Profile:</h3>
        <div style="display: grid; gap: 1rem; margin-bottom: 1.5rem;">
            <div>
                <label style="display: block; margin-bottom: 0.5rem; color: var(--text-muted); font-size: 0.9rem;">Awareness: ${model.awareness.toFixed(1)}</label>
                <div style="background: var(--bg); height: 8px; border-radius: 4px; overflow: hidden;">
                    <div style="background: linear-gradient(90deg, #3b82f6, #8b5cf6); height: 100%; width: ${model.awareness * 100}%;"></div>
                </div>
            </div>
            <div>
                <label style="display: block; margin-bottom: 0.5rem; color: var(--text-muted); font-size: 0.9rem;">Curiosity: ${model.curiosity.toFixed(1)}</label>
                <div style="background: var(--bg); height: 8px; border-radius: 4px; overflow: hidden;">
                    <div style="background: linear-gradient(90deg, #8b5cf6, #ec4899); height: 100%; width: ${model.curiosity * 100}%;"></div>
                </div>
            </div>
            <div>
                <label style="display: block; margin-bottom: 0.5rem; color: var(--text-muted); font-size: 0.9rem;">Learning Rate: ${model.learningRate.toFixed(2)}</label>
                <div style="background: var(--bg); height: 8px; border-radius: 4px; overflow: hidden;">
                    <div style="background: linear-gradient(90deg, #10b981, #f59e0b); height: 100%; width: ${model.learningRate * 100}%;"></div>
                </div>
            </div>
        </div>
        
        <h3 style="margin-top: 1.5rem; margin-bottom: 1rem;">Features:</h3>
        <div style="display: flex; flex-wrap: wrap; gap: 0.75rem; margin-bottom: 1.5rem;">
            ${model.features.map(feature => `
                <span style="display: inline-block; padding: 0.5rem 1rem; background: var(--bg); border: 1px solid var(--border); border-radius: 0.5rem; font-size: 0.9rem; color: var(--primary);">✓ ${feature}</span>
            `).join('')}
        </div>
        
        <button class="btn btn-primary" onclick="downloadModel('${model.id}', '${model.installCommand.replace(/'/g, "\\'")}'); " style="width: 100%; margin-top: 1rem;">
            📥 Install This Model
        </button>
    `;

    modal.classList.add('show');
}

function copyCommand(command) {
    navigator.clipboard.writeText(command).then(() => {
        const btn = event.target;
        const originalText = btn.textContent;
        btn.textContent = '✓ Copied!';
        setTimeout(() => {
            btn.textContent = originalText;
        }, 2000);
    });
}

function updateStats() {
    const modelCountEl = document.getElementById('modelCount');
    const downloadCountEl = document.getElementById('downloadCount');
    
    if (modelCountEl) {
        modelCountEl.textContent = modelsData.length;
    }
    
    if (downloadCountEl) {
        const totalDownloads = modelsData.reduce((sum, model) => sum + model.downloads, 0);
        downloadCountEl.textContent = totalDownloads + '+';
    }
}
