# BlackBox App - Deployment Guide

## Overview
- **Frontend**: React + Vite deployed on **Vercel** (free)
- **Backend**: FastAPI with ML models deployed on **Railway** (free tier available)

## Prerequisites
- GitHub account
- Railway account (free at https://railway.app)
- Vercel account (free at https://vercel.com)

---

## 🚀 Step 1: Prepare for Deployment

### 1.1 Create a GitHub Repository
```bash
git init
git add .
git commit -m "Initial commit - BlackBox app"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/blackbox.git
git push -u origin main
```

### 1.2 Verify Project Structure
```
blackbox/
├── backend/
│   ├── app.py
│   ├── predict.py
│   ├── Procfile
│   ├── requirements.txt
│   └── .gitignore
├── web/
│   ├── src/
│   ├── package.json
│   ├── vercel.json
│   ├── .env.example
│   └── .env.local (for local development)
├── .gitignore
└── DEPLOYMENT.md (this file)
```

---

## 🚂 Step 2: Deploy Backend on Railway

### 2.1 Create Railway Project
1. Go to https://railway.app
2. Click **"New Project"** → **"Deploy from GitHub repo"**
3. Authorize Railway with GitHub
4. Select your **blackbox** repository

### 2.2 Configure Railway
1. Click **"Add Service"** → **"GitHub Repo"**
2. **Important**: Set the **Root Directory** to `backend/`
   - This tells Railway to look for `Procfile` and `requirements.txt` in the backend folder
3. Click **"Deploy"**

### 2.3 Get Your Backend URL
- Railway will auto-deploy and assign a URL like: `https://blackbox-production-xxxx.railway.app`
- You'll see it in the Railway dashboard under your project

### 2.4 Verify Backend is Running
```bash
curl https://your-railway-url.railway.app/docs
```
You should see the FastAPI interactive docs page.

---

## 🎨 Step 3: Deploy Frontend on Vercel

### 3.1 Create Vercel Project
1. Go to https://vercel.com
2. Click **"Add New..."** → **"Project"**
3. Select your **blackbox** GitHub repo
4. Click **"Import"**

### 3.2 Configure Vercel
1. **Framework Preset**: Select **"Vite"** (or it auto-detects)
2. **Root Directory**: Set to `web/`
3. **Build Command**: Keep as `npm run build` (already in vercel.json)
4. **Output Directory**: Keep as `dist` (already in vercel.json)

### 3.3 Add Environment Variable
1. Before deploying, go to **Settings** → **Environment Variables**
2. Add:
   - **Name**: `VITE_BACKEND_URL`
   - **Value**: `https://your-railway-url.railway.app`
   - Example: `https://blackbox-production-xxxx.railway.app`
3. Click **"Save"**
4. Click **"Deployments"** → **"Redeploy"** on the latest deployment

### 3.4 Get Your Frontend URL
- Vercel will assign a URL like: `https://blackbox.vercel.app`
- Your app is live! 🎉

---

## 🔗 Step 4: Connect Frontend to Backend

The frontend automatically uses the backend URL from the environment variable.

**For local development:**
- Frontend (Vite): `http://localhost:5173`
- Backend (FastAPI): `http://localhost:8000`
- The `.env.local` file in `web/` already has this configured

**To test locally:**
```bash
# Terminal 1: Start backend
cd backend
python -m uvicorn app:app --reload

# Terminal 2: Start frontend
cd web
npm install
npm run dev
```

---

## 📝 Making Updates

### Push Updates to Production
```bash
# Make changes, then:
git add .
git commit -m "Your message"
git push origin main
```

- **Backend** auto-deploys from Railway (if connected to GitHub)
- **Frontend** auto-deploys from Vercel (if connected to GitHub)

### Update Backend URL (if Railway URL changes)
1. Go to Vercel Project Settings → Environment Variables
2. Update `VITE_BACKEND_URL` with new Railway URL
3. Redeploy the frontend

---

## ⚙️ Environment Variables Reference

### Backend (Railway)
- `.env` file in `backend/` directory
- Currently just needs `PORT` (Railway sets this automatically)
- For custom variables, add them in Railway dashboard

### Frontend (Vercel)  
- `VITE_BACKEND_URL`: URL of your Railway backend
- Add in Vercel Project Settings → Environment Variables
- Must start with `VITE_` to be available in browser code

---

## 🐛 Troubleshooting

### Frontend can't connect to backend
- Check CORS is enabled in backend (it is in app.py)
- Verify `VITE_BACKEND_URL` is set in Vercel
- Check backend is deployed and running on Railway

### Backend deployment fails
- Check `Procfile` exists in `backend/` directory
- Verify `requirements.txt` has all dependencies
- Check Railway logs for error messages

### Model loading is slow
- First request is slower (model loads from disk)
- Subsequent requests should be faster
- Consider pre-loading model in production

---

## 💡 Next Steps (Optional Optimizations)

1. **Add custom domain** to Vercel or Railway
2. **Enable caching** for ML model in backend
3. **Add CI/CD workflows** with GitHub Actions
4. **Monitor logs** in Railway/Vercel dashboards
5. **Set up alerts** for failed deployments

---

## 📞 Support Links

- Railway Docs: https://docs.railway.app
- Vercel Docs: https://vercel.com/docs
- FastAPI Docs: https://fastapi.tiangolo.com
- Vite Docs: https://vitejs.dev
