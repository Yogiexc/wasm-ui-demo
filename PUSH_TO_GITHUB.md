# 📤 Push Project ke GitHub - Step-by-Step

## 🎯 Prerequisites

### 1. Install Git (jika belum)

**Windows:**
```powershell
# Download dari: https://git-scm.com/download/win
# Atau via winget:
winget install Git.Git
```

**Verify:**
```bash
git --version
# Output: git version 2.x.x
```

### 2. Setup Git Config (first time)

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Verify
git config --list
```

### 3. Create GitHub Account

1. Buka: https://github.com/signup
2. Sign up dengan email
3. Verify email

---

## 📦 Step-by-Step: Push to GitHub

### Step 1: Create Repository di GitHub

1. **Login ke GitHub**
2. **Click tombol "+" (top right) → New repository**
3. **Fill in details:**
   - Repository name: `wasm-ui-demo`
   - Description: `WebAssembly UI Demo - Frontend Accelerator with Rust & WASM`
   - Visibility: ✅ Public (untuk portfolio)
   - ❌ JANGAN check "Initialize with README" (kita sudah punya)
4. **Click "Create repository"**

GitHub akan tampilkan halaman dengan instruksi. **JANGAN tutup halaman ini dulu!**

---

### Step 2: Initialize Git di Project

```powershell
# Masuk ke folder project
Set-Location "D:\BelajarCoding\wasm-ui-demo"

# Initialize git repository
git init

# Check status
git status
```

Output:
```
Initialized empty Git repository in D:/BelajarCoding/wasm-ui-demo/.git/
```

---

### Step 3: Create .gitignore

```powershell
# Create .gitignore file
@"
# Rust
target/
**/*.rs.bk
Cargo.lock

# WASM Build Output
public/pkg/
*.wasm

# Node (if using npm)
node_modules/
package-lock.json

# IDE
.idea/
.vscode/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db

# Logs
*.log

# Temporary files
*.tmp
"@ | Out-File -FilePath ".gitignore" -Encoding UTF8
```

---

### Step 4: Add & Commit Files

```bash
# Add all files (except yang di .gitignore)
git add .

# Check apa yang akan di-commit
git status

# Commit dengan message
git commit -m "feat: initial commit - WASM UI Demo with Rust"
```

Output:
```
[main (root-commit) abc1234] feat: initial commit - WASM UI Demo with Rust
 6 files changed, 856 insertions(+)
 create mode 100644 .gitignore
 create mode 100644 CONTRIBUTING.md
 create mode 100644 README.md
 create mode 100644 wasm/Cargo.toml
 create mode 100644 wasm/src/lib.rs
 create mode 100644 public/index.html
```

---

### Step 5: Add Remote & Push

**Copy command dari halaman GitHub yang tadi (atau ganti `yourusername`):**

```bash
# Add remote origin
git remote add origin https://github.com/yourusername/wasm-ui-demo.git

# Rename branch ke 'main' (jika masih 'master')
git branch -M main

# Push ke GitHub
git push -u origin main
```

**Jika diminta login:**
- Username: `yourusername`
- Password: **BUKAN password biasa!** Gunakan **Personal Access Token**

---

### Step 6: Create GitHub Personal Access Token

**Jika git push minta password:**

1. Buka: https://github.com/settings/tokens
2. Click **"Generate new token" → "Generate new token (classic)"**
3. Fill in:
   - Note: `wasm-ui-demo-push`
   - Expiration: `90 days` (atau custom)
   - Scopes: ✅ Check `repo` (full access)
4. Click **"Generate token"**
5. **COPY TOKEN** (hanya muncul sekali!)
6. Paste sebagai password di git push

---

### Step 7: Verify di GitHub

1. Buka: `https://github.com/yourusername/wasm-ui-demo`
2. Refresh page
3. **Should see:**
   - ✅ README.md rendered beautifully
   - ✅ All project files
   - ✅ Folder structure intact

---

## 🎨 Bonus: Add GitHub Topics & Description

1. **Di halaman repository, click ⚙️ (Settings icon) atau "About" section**
2. **Add description:**
   ```
   🚀 WebAssembly UI Demo - Exploring WASM to offload heavy logic from JavaScript. Built with Rust + wasm-bindgen. Showcases prime calculation, Mandelbrot set, and performance comparisons.
   ```
3. **Add topics (tags):**
   ```
   webassembly, rust, wasm, wasm-bindgen, frontend, performance, demo, tutorial
   ```
4. **Add website (jika punya GitHub Pages):**
   ```
   https://yourusername.github.io/wasm-ui-demo
   ```

---

## 📋 Complete Git Command Cheatsheet

```bash
# ============================================
# INITIAL SETUP (one-time)
# ============================================
git init                                # Initialize repo
git config --global user.name "Name"    # Set username
git config --global user.email "email"  # Set email

# ============================================
# DAILY WORKFLOW
# ============================================
git status                              # Check status
git add .                               # Stage all changes
git add file.rs                         # Stage specific file
git commit -m "message"                 # Commit changes
git push                                # Push to remote
git pull                                # Pull from remote

# ============================================
# BRANCHING
# ============================================
git branch                              # List branches
git branch feature-name                 # Create branch
git checkout feature-name               # Switch branch
git checkout -b feature-name            # Create & switch
git merge feature-name                  # Merge branch

# ============================================
# REMOTE
# ============================================
git remote add origin URL               # Add remote
git remote -v                           # List remotes
git push -u origin main                 # First push
git push                                # Subsequent pushes

# ============================================
# UNDO & RESET
# ============================================
git reset HEAD file.rs                  # Unstage file
git checkout -- file.rs                 # Discard changes
git reset --soft HEAD~1                 # Undo last commit (keep changes)
git reset --hard HEAD~1                 # Undo last commit (discard changes)

# ============================================
# VIEW HISTORY
# ============================================
git log                                 # Commit history
git log --oneline                       # Compact history
git log --graph --all                   # Visual graph
git diff                                # Show changes
```

---

## 🔄 Future Updates Workflow

Setelah initial push, untuk update code:

```bash
# 1. Make changes to code
# (edit wasm/src/lib.rs, public/index.html, etc.)

# 2. Build WASM (jika edit Rust)
cd wasm
wasm-pack build --target web --out-dir ../public/pkg
cd ..

# 3. Check changes
git status
git diff

# 4. Stage changes
git add .

# 5. Commit dengan descriptive message
git commit -m "feat: add image blur algorithm"
# or
git commit -m "fix: correct mandelbrot color calculation"
# or
git commit -m "docs: update README with SIMD guide"

# 6. Push to GitHub
git push
```

---

## 🌟 GitHub Pages Setup (Optional - Deploy Live Demo)

Deploy project sebagai static website:

```bash
# 1. Create gh-pages branch
git checkout -b gh-pages

# 2. Push gh-pages
git push -u origin gh-pages

# 3. Di GitHub Settings:
# - Repository → Settings → Pages
# - Source: Deploy from a branch
# - Branch: gh-pages / root
# - Click Save

# 4. Wait 1-2 minutes, then access:
# https://yourusername.github.io/wasm-ui-demo
```

**Note:** GitHub Pages serve dari `public/` jadi pastikan `index.html` di root atau adjust settings.

---

## 🐛 Troubleshooting

### Error: "Permission denied (publickey)"

**Solution: Use HTTPS instead of SSH**
```bash
# Check current remote
git remote -v

# If using SSH (git@github.com:...), change to HTTPS:
git remote set-url origin https://github.com/yourusername/wasm-ui-demo.git

# Try push again
git push
```

### Error: "failed to push some refs"

**Solution: Pull first, then push**
```bash
git pull origin main --rebase
git push
```

### Error: "Support for password authentication was removed"

**Solution: Use Personal Access Token instead of password**
1. Generate token: https://github.com/settings/tokens
2. Use token as password when pushing

### Large files warning

**Solution: Add to .gitignore**
```bash
# If you accidentally committed large files:
git rm --cached public/pkg/*.wasm
echo "public/pkg/" >> .gitignore
git commit -m "fix: ignore WASM build artifacts"
git push
```

---

## 📊 Example: Complete First Push Session

```powershell
# 1. Navigate to project
PS D:\> Set-Location "D:\BelajarCoding\wasm-ui-demo"

# 2. Initialize git
PS D:\BelajarCoding\wasm-ui-demo> git init
Initialized empty Git repository in D:/BelajarCoding/wasm-ui-demo/.git/

# 3. Add all files
PS D:\BelajarCoding\wasm-ui-demo> git add .

# 4. Commit
PS D:\BelajarCoding\wasm-ui-demo> git commit -m "feat: initial commit - WASM UI Demo"
[main (root-commit) 1a2b3c4] feat: initial commit - WASM UI Demo
 6 files changed, 856 insertions(+)

# 5. Add remote
PS D:\BelajarCoding\wasm-ui-demo> git remote add origin https://github.com/yourusername/wasm-ui-demo.git

# 6. Push
PS D:\BelajarCoding\wasm-ui-demo> git push -u origin main
Enumerating objects: 10, done.
Counting objects: 100% (10/10), done.
Delta compression using up to 8 threads
Compressing objects: 100% (8/8), done.
Writing objects: 100% (10/10), 12.34 KiB | 1.23 MiB/s, done.
Total 10 (delta 1), reused 0 (delta 0), pack-reused 0
To https://github.com/yourusername/wasm-ui-demo.git
 * [new branch]      main -> main
Branch 'main' set up to track remote branch 'main' from 'origin'.

# 7. Done! 🎉
```

---

## ✅ Final Checklist

Before declaring project complete:

- [ ] All code files committed
- [ ] README.md properly formatted
- [ ] CONTRIBUTING.md included
- [ ] .gitignore configured
- [ ] LICENSE file added (MIT)
- [ ] GitHub repository created
- [ ] Code pushed to GitHub
- [ ] Repository description added
- [ ] Topics/tags added
- [ ] Project works locally
- [ ] Build artifacts ignored (.gitignore)
- [ ] Links in README updated (replace `yourusername`)

---

## 🎉 Selamat!

Project kamu sekarang live di GitHub dan siap untuk:
- ✅ Portfolio showcase
- ✅ Job applications
- ✅ Open source contributions
- ✅ Community engagement

**Next steps:**
- Share link di LinkedIn
- Post di Twitter/X dengan hashtag #WebAssembly #Rust
- Add to portfolio website
- Submit to awesome-wasm list

---

**Happy Coding! 🚀**