// API Configuration for Neuron Marketplace Website
// Supports both local development and deployed instances

const API_CONFIG = {
  // For local development (localhost:3000)
  local: {
    baseUrl: 'http://localhost:3000',
    modelsEndpoint: '/api/models',
    searchEndpoint: '/api/models/search',
    downloadEndpoint: '/api/models/:modelName/download'
  },

  // For deployed Vercel instance
  vercel: {
    baseUrl: window.location.origin, // Uses current domain
    modelsEndpoint: '/api/models',
    searchEndpoint: '/api/models/search',
    downloadEndpoint: '/api/models/:modelName/download'
  },

  // Fallback configuration
  fallback: {
    baseUrl: 'http://localhost:3000',
    modelsEndpoint: '/api/models'
  }
};

// Detect environment and return appropriate config
function getAPIConfig() {
  const hostname = window.location.hostname;
  
  // Detect if running on Vercel
  if (hostname.includes('vercel.app') || hostname.includes('.vercel.dev')) {
    return API_CONFIG.vercel;
  }
  
  // Default to local
  if (hostname === 'localhost' || hostname === '127.0.0.1') {
    return API_CONFIG.local;
  }
  
  // For production deployments
  return {
    baseUrl: window.location.origin,
    modelsEndpoint: '/api/models',
    searchEndpoint: '/api/models/search',
    downloadEndpoint: '/api/models/:modelName/download'
  };
}

// Export functions
window.API_CONFIG = {
  getConfig: getAPIConfig,
  getModelsUrl: () => {
    const config = getAPIConfig();
    return `${config.baseUrl}${config.modelsEndpoint}`;
  },
  getSearchUrl: (keyword) => {
    const config = getAPIConfig();
    return `${config.baseUrl}${config.searchEndpoint}/${keyword}`;
  },
  getDownloadUrl: (modelName) => {
    const config = getAPIConfig();
    return `${config.baseUrl}${config.downloadEndpoint.replace(':modelName', modelName)}`;
  }
};

export default API_CONFIG;
