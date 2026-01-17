# 🤝 Contributing to WASM UI Demo

Thank you for your interest in contributing to this project! This guide will help you get started.

## 🎯 Ways to Contribute

We welcome contributions in these areas:

### 1. **New Use Cases** 🚀
Add more WASM demonstrations that showcase performance benefits:
- Image processing (filters, transformations)
- Audio processing (FFT, synthesis)
- Cryptography (hashing, encryption)
- Data compression
- Physics simulations
- Game of Life or other cellular automata

### 2. **Performance Optimizations** ⚡
- SIMD implementations
- Multi-threading with Web Workers
- Memory optimization techniques
- Benchmark automation

### 3. **Documentation** 📚
- Improve code comments
- Add tutorials for specific algorithms
- Create video demonstrations
- Translate README to other languages

### 4. **Bug Fixes** 🐛
- Fix compilation issues
- Cross-browser compatibility
- Error handling improvements

### 5. **UI/UX Enhancements** 🎨
- Better visualizations
- Responsive design improvements
- Accessibility features
- Dark/light mode

### 6. **Tooling & DevEx** 🛠️
- Automated testing
- CI/CD pipeline
- Docker setup
- Better build scripts

## 📋 Contribution Guidelines

### Before You Start

1. **Check existing issues** - Someone might already be working on it
2. **Open an issue first** - Discuss your idea before spending time coding
3. **Keep it simple** - Focus on educational value over complexity

### Getting Started

1. **Fork the repository**
   ```bash
   # Click "Fork" button on GitHub
   ```

2. **Clone your fork**
   ```bash
   git clone https://github.com/YOUR_USERNAME/wasm-ui-demo.git
   cd wasm-ui-demo
   ```

3. **Create a branch**
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/bug-description
   ```

4. **Set up development environment**
   ```bash
   # Install dependencies (if not already)
   cargo install wasm-pack
   
   # Build
   cd wasm
   wasm-pack build --target web --out-dir ../public/pkg
   ```

### Making Changes

#### For Rust/WASM Code:

1. Edit `wasm/src/lib.rs`
2. Keep functions small and focused
3. Add documentation comments:
   ```rust
   /// Calculate prime numbers using Sieve of Eratosthenes
   /// 
   /// # Arguments
   /// * `n` - Upper bound for prime search
   /// 
   /// # Returns
   /// Vec<u32> containing all prime numbers up to n
   #[wasm_bindgen]
   pub fn calculate_primes(n: u32) -> Vec<u32> {
       // implementation
   }
   ```

4. Test locally:
   ```bash
   wasm-pack build --target web --out-dir ../public/pkg
   cd ../public
   python -m http.server 8080
   ```

#### For Frontend Code:

1. Edit `public/index.html`
2. Keep UI simple and accessible
3. Add performance metrics for new features
4. Test in multiple browsers (Chrome, Firefox, Safari)

#### Code Style:

**Rust:**
- Use `cargo fmt` before committing
- Run `cargo clippy` to catch common issues
- Follow Rust naming conventions

**JavaScript:**
- Use ES6+ features
- Keep functions pure when possible
- Add comments for complex logic

**HTML/CSS:**
- Semantic HTML5
- Responsive design (mobile-first)
- Accessible (ARIA labels, keyboard navigation)

### Commit Messages

Follow conventional commits format:

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style (formatting, no logic change)
- `refactor`: Code refactoring
- `perf`: Performance improvement
- `test`: Adding tests
- `chore`: Maintenance tasks

**Examples:**
```bash
git commit -m "feat(wasm): add image blur algorithm"
git commit -m "fix(ui): correct mandelbrot color rendering"
git commit -m "docs(readme): add SIMD optimization guide"
git commit -m "perf(prime): optimize sieve implementation"
```

### Submitting Pull Request

1. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

2. **Create Pull Request on GitHub**
   - Clear title describing the change
   - Reference related issues (#123)
   - Describe what changed and why
   - Add screenshots for UI changes

3. **PR Template:**
   ```markdown
   ## Description
   Brief description of changes
   
   ## Type of Change
   - [ ] Bug fix
   - [ ] New feature
   - [ ] Performance improvement
   - [ ] Documentation update
   
   ## Testing
   - [ ] Tested in Chrome
   - [ ] Tested in Firefox
   - [ ] Tested on mobile
   
   ## Screenshots (if applicable)
   [Add screenshots here]
   
   ## Related Issues
   Fixes #123
   ```

4. **Wait for review**
   - Address feedback promptly
   - Keep discussions respectful
   - Make requested changes in new commits

## 🎓 Learning Resources

New to WebAssembly or Rust? Check these out:

- [Rust Book](https://doc.rust-lang.org/book/)
- [Rust WASM Book](https://rustwasm.github.io/docs/book/)
- [wasm-bindgen Guide](https://rustwasm.github.io/wasm-bindgen/)
- [MDN WebAssembly](https://developer.mozilla.org/en-US/docs/WebAssembly)

## 💡 Ideas for Contributions

Not sure where to start? Try these beginner-friendly tasks:

### Easy 🟢
- [ ] Add input validation to prevent crashes
- [ ] Improve error messages
- [ ] Add loading spinners during computation
- [ ] Fix typos in documentation
- [ ] Add more comments to code

### Medium 🟡
- [ ] Implement SHA-256 hashing in WASM
- [ ] Add CSV parsing demo
- [ ] Create benchmark comparison charts
- [ ] Add keyboard shortcuts
- [ ] Implement undo/redo for canvas

### Hard 🔴
- [ ] Multi-threaded WASM with Web Workers
- [ ] SIMD-optimized image processing
- [ ] Real-time audio synthesis
- [ ] Ray tracing demo
- [ ] Neural network inference

## 🧪 Testing Checklist

Before submitting PR, verify:

- [ ] Code compiles without warnings
- [ ] All demos work in browser
- [ ] No console errors
- [ ] Performance metrics display correctly
- [ ] Responsive on mobile (375px width)
- [ ] Works in Chrome, Firefox, Safari
- [ ] README updated if needed
- [ ] No hardcoded paths or credentials

## 📜 Code of Conduct

- Be respectful and inclusive
- Welcome newcomers
- Focus on constructive feedback
- Assume good intentions
- No harassment or discrimination

## 🙏 Recognition

Contributors will be:
- Listed in README.md
- Mentioned in release notes
- Credited in commit history

Thank you for making this project better! 🚀

## 📞 Questions?

- Open an issue for discussion
- Tag maintainer in comments
- Keep discussions public (helps others learn)

---

**Happy Contributing!** 🎉