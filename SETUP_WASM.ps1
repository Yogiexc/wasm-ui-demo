# ============================================
# WASM UI Demo - Complete PowerShell Setup
# ============================================

Write-Host @"
🚀 WASM UI Demo Setup Script
================================
This script will:
1. Create project structure
2. Install wasm-pack (if needed)
3. Create all necessary files
4. Build WASM module
5. Start local server
"@ -ForegroundColor Cyan

# Check if already in wasm-ui-demo folder
$currentPath = Get-Location
if ($currentPath.Path -notmatch "wasm-ui-demo$") {
    Write-Host "`n❌ Please run this script from wasm-ui-demo folder" -ForegroundColor Red
    Write-Host "   Current: $currentPath" -ForegroundColor Yellow
    Write-Host "   Expected: D:\BelajarCoding\wasm-ui-demo" -ForegroundColor Yellow
    exit 1
}

Write-Host "`n✅ Running from correct directory" -ForegroundColor Green

# ============================================
# Step 1: Create Directories
# ============================================
Write-Host "`n[1/6] Creating directory structure..." -ForegroundColor Yellow
New-Item -Path "wasm\src" -ItemType Directory -Force | Out-Null
New-Item -Path "public" -ItemType Directory -Force | Out-Null
Write-Host "✅ Directories created" -ForegroundColor Green

# ============================================
# Step 2: Check Rust
# ============================================
Write-Host "`n[2/6] Checking Rust installation..." -ForegroundColor Yellow
if (!(Get-Command cargo -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Rust not found!" -ForegroundColor Red
    Write-Host "   Please install from: https://rustup.rs/" -ForegroundColor Yellow
    exit 1
}
$rustVersion = rustc --version
Write-Host "✅ Rust found: $rustVersion" -ForegroundColor Green

# ============================================
# Step 3: Install/Check wasm-pack
# ============================================
Write-Host "`n[3/6] Checking wasm-pack..." -ForegroundColor Yellow
if (!(Get-Command wasm-pack -ErrorAction SilentlyContinue)) {
    Write-Host "⚠️  wasm-pack not found. Installing..." -ForegroundColor Yellow
    Write-Host "   This will take 5-10 minutes..." -ForegroundColor Cyan
    cargo install wasm-pack
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Failed to install wasm-pack" -ForegroundColor Red
        exit 1
    }
}
$wasmPackVersion = wasm-pack --version
Write-Host "✅ wasm-pack ready: $wasmPackVersion" -ForegroundColor Green

# ============================================
# Step 4: Create Cargo.toml
# ============================================
Write-Host "`n[4/6] Creating Cargo.toml..." -ForegroundColor Yellow
$cargoToml = @"
[package]
name = "wasm-ui-demo"
version = "0.1.0"
edition = "2021"

[lib]
crate-type = ["cdylib"]

[dependencies]
wasm-bindgen = "0.2"
js-sys = "0.3"

[dependencies.web-sys]
version = "0.3"
features = [
    "console",
    "Performance",
    "Window",
]

[profile.release]
opt-level = 3
lto = true
codegen-units = 1
"@
$cargoToml | Out-File -FilePath "wasm\Cargo.toml" -Encoding UTF8 -NoNewline
Write-Host "✅ Cargo.toml created" -ForegroundColor Green

# ============================================
# Step 5: Create lib.rs (placeholder)
# ============================================
Write-Host "`n[5/6] Creating lib.rs..." -ForegroundColor Yellow
$libRs = @"
use wasm_bindgen::prelude::*;

#[wasm_bindgen]
extern "C" {
    #[wasm_bindgen(js_namespace = console)]
    fn log(s: &str);
}

/// Calculate prime numbers using Sieve of Eratosthenes
#[wasm_bindgen]
pub fn calculate_primes(n: u32) -> Vec<u32> {
    if n < 2 {
        return vec![];
    }

    let mut is_prime = vec![true; (n + 1) as usize];
    is_prime[0] = false;
    is_prime[1] = false;

    let sqrt_n = (n as f64).sqrt() as u32;
    for i in 2..=sqrt_n {
        if is_prime[i as usize] {
            let mut j = i * i;
            while j <= n {
                is_prime[j as usize] = false;
                j += i;
            }
        }
    }

    is_prime
        .iter()
        .enumerate()
        .filter_map(|(idx, &prime)| if prime { Some(idx as u32) } else { None })
        .collect()
}

/// Generate Mandelbrot set
#[wasm_bindgen]
pub fn generate_mandelbrot(
    width: u32,
    height: u32,
    max_iterations: u32,
    zoom: f64,
    offset_x: f64,
    offset_y: f64,
) -> Vec<u8> {
    let mut data = vec![0u8; (width * height * 4) as usize];

    for py in 0..height {
        for px in 0..width {
            let x0 = (px as f64 / width as f64 - 0.5) * zoom + offset_x;
            let y0 = (py as f64 / height as f64 - 0.5) * zoom + offset_y;

            let mut x = 0.0;
            let mut y = 0.0;
            let mut iteration = 0;

            while x * x + y * y <= 4.0 && iteration < max_iterations {
                let xtemp = x * x - y * y + x0;
                y = 2.0 * x * y + y0;
                x = xtemp;
                iteration += 1;
            }

            let idx = ((py * width + px) * 4) as usize;
            
            if iteration == max_iterations {
                data[idx] = 0;
                data[idx + 1] = 0;
                data[idx + 2] = 0;
                data[idx + 3] = 255;
            } else {
                let color = (iteration as f64 / max_iterations as f64 * 255.0) as u8;
                data[idx] = color;
                data[idx + 1] = color / 2;
                data[idx + 2] = 255 - color;
                data[idx + 3] = 255;
            }
        }
    }

    data
}

/// Calculate Fibonacci number
#[wasm_bindgen]
pub fn fibonacci(n: u32) -> u64 {
    if n <= 1 {
        return n as u64;
    }

    let mut prev = 0u64;
    let mut curr = 1u64;

    for _ in 2..=n {
        let next = prev + curr;
        prev = curr;
        curr = next;
    }

    curr
}

/// Analyze text
#[wasm_bindgen]
pub fn analyze_text(text: &str) -> String {
    let words: Vec<&str> = text.split_whitespace().collect();
    
    let word_count = words.len();
    let char_count = text.chars().count();
    let unique_words = {
        let mut unique = std::collections::HashSet::new();
        for word in &words {
            unique.insert(word.to_lowercase());
        }
        unique.len()
    };

    format!(
        "Words: {}, Chars: {}, Unique: {}",
        word_count, char_count, unique_words
    )
}
"@
$libRs | Out-File -FilePath "wasm\src\lib.rs" -Encoding UTF8 -NoNewline
Write-Host "✅ lib.rs created" -ForegroundColor Green

# ============================================
# Step 6: Create index.html
# ============================================
Write-Host "`n[6/6] Creating index.html..." -ForegroundColor Yellow
Write-Host "⚠️  You need to manually create public\index.html" -ForegroundColor Yellow
Write-Host "   Copy content from the HTML artifact above" -ForegroundColor Cyan

# ============================================
# Build WASM
# ============================================
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Ready to build WASM module!" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "`nBefore building, please:" -ForegroundColor Yellow
Write-Host "1. Create public\index.html (copy from artifact)" -ForegroundColor White
Write-Host "2. Press any key to continue..." -ForegroundColor Cyan
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

Write-Host "`n🔨 Building WASM module..." -ForegroundColor Yellow
Write-Host "   This may take 2-5 minutes on first build..." -ForegroundColor Cyan

Set-Location wasm
wasm-pack build --target web --out-dir ..\public\pkg

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n========================================" -ForegroundColor Green
    Write-Host "✅ BUILD SUCCESSFUL!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    
    Write-Host "`nGenerated files in public\pkg:" -ForegroundColor Cyan
    Get-ChildItem ..\public\pkg | Format-Table Name, Length
    
    Set-Location ..\public
    
    Write-Host "`n🌐 Starting local server..." -ForegroundColor Yellow
    Write-Host "   Open: http://localhost:8080" -ForegroundColor Cyan
    Write-Host "   Press Ctrl+C to stop" -ForegroundColor Yellow
    Write-Host "`n" -NoNewline
    
    # Try Python first, fallback to other options
    if (Get-Command python -ErrorAction SilentlyContinue) {
        python -m http.server 8080
    } elseif (Get-Command npx -ErrorAction SilentlyContinue) {
        npx http-server -p 8080
    } else {
        Write-Host "❌ No web server found!" -ForegroundColor Red
        Write-Host "   Install Python or Node.js to run server" -ForegroundColor Yellow
        Write-Host "`n   Or manually open public\index.html in browser" -ForegroundColor Cyan
    }
} else {
    Write-Host "`n========================================" -ForegroundColor Red
    Write-Host "❌ BUILD FAILED" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "Check errors above and try again" -ForegroundColor Yellow
}