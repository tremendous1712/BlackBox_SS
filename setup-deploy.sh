#!/bin/bash
# BlackBox Deployment Setup Script

echo "🚀 BlackBox Deployment Setup"
echo "=============================="
echo ""

# Check if git is initialized
if [ ! -d .git ]; then
    echo "📦 Initializing Git repository..."
    git init
    git add .
    git commit -m "Initial commit - BlackBox app with deployment configs"
    echo "✅ Git initialized!"
else
    echo "✅ Git already initialized"
fi

echo ""
echo "📋 Next Steps:"
echo "1. Create a GitHub repository:"
echo "   https://github.com/new"
echo ""
echo "2. Push to GitHub:"
echo "   git remote add origin https://github.com/YOUR_USERNAME/blackbox.git"
echo "   git branch -M main"
echo "   git push -u origin main"
echo ""
echo "3. Deploy Backend on Railway:"
echo "   https://railway.app"
echo "   → Select 'Deploy from GitHub'"
echo "   → Set Root Directory to 'backend/'"
echo ""
echo "4. Deploy Frontend on Vercel:"
echo "   https://vercel.com"
echo "   → Import GitHub repo"
echo "   → Set Root Directory to 'web/'"
echo "   → Add env var: VITE_BACKEND_URL=<your-railway-url>"
echo ""
echo "5. Read the full guide:"
echo "   cat DEPLOYMENT.md"
echo ""
echo "✨ Everything is ready!"
