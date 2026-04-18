#!/usr/bin/env bash

# Consciousness AI - Download and Install Script
# Download from: https://github.com/Xznder1984/Conscious-AI

REPO_URL="https://github.com/Xznder1984/Conscious-AI.git"
INSTALL_DIR="${HOME}/Conscious-AI"

echo "=== Consciousness AI System ==="
echo "Downloading from ${REPO_URL}..."

if command -v git &> /dev/null; then
    git clone "${REPO_URL}" "${INSTALL_DIR}"
    cd "${INSTALL_DIR}"
    echo "Repository cloned to ${INSTALL_DIR}"
else
    # Fallback: download as ZIP
    echo "Git not found. Attempting to download as ZIP..."
    if command -v curl &> /dev/null; then
        curl -L -o consciousness-ai.zip "https://github.com/Xznder1984/Conscious-AI/archive/refs/heads/main.zip"
        unzip consciousness-ai.zip
        mv Conscious-AI-main "${INSTALL_DIR}"
        cd "${INSTALL_DIR}"
    else
        echo "Error: Git or curl not found. Please install one of them."
        exit 1
    fi
fi

echo "Installing dependencies..."
npm install

echo ""
echo "=== Installation Complete ==="
echo "To start the AI server:"
echo "  cd ${INSTALL_DIR}"
echo "  npm start"
echo ""
echo "Or run as background process:"
echo "  npm run start-bg"
echo ""
echo "API will be available at: http://localhost:3000"
