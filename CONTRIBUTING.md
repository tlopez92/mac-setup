# Contributing to Mac Setup

Thank you for your interest in contributing to the Mac Development Environment Setup project! This document provides guidelines and information for contributors.

## 🤝 How to Contribute

### Types of Contributions

We welcome several types of contributions:

- **🐛 Bug Reports** - Report issues with the setup process
- **💡 Feature Requests** - Suggest new tools or improvements
- **📖 Documentation** - Improve README, guides, or code comments
- **🔧 Code Contributions** - Add new tools, fix bugs, or improve the makefile
- **🧪 Testing** - Test the setup on different macOS versions

### 📋 Before You Start

1. **Check existing issues** - Look for existing bug reports or feature requests
2. **Read the README** - Understand the project structure and goals
3. **Test the current setup** - Run `make all` on a clean macOS system
4. **Review the code** - Familiarize yourself with the makefile structure

## 🚀 Getting Started

### 1. Fork and Clone

```bash
# Fork the repository on GitHub, then clone your fork
git clone https://github.com/yourusername/mac-setup.git
cd mac-setup

# Add the upstream repository
git remote add upstream https://github.com/tlopez92/mac-setup.git
```

### 2. Create a Branch

```bash
# Create a descriptive branch name
git checkout -b feature/add-new-tool
# or
git checkout -b fix/makefile-issue
# or
git checkout -b docs/update-readme
```

### 3. Make Your Changes

Follow the coding standards and patterns established in the project:

- **Makefile targets** should check if tools are already installed
- **Error handling** should be graceful with informative messages
- **Documentation** should be updated for any new features
- **Testing** should be performed on multiple macOS versions when possible

## 📝 Coding Standards

### Makefile Guidelines

```makefile
# Good: Check if tool exists before installing
tool-name:
	@echo "Installing Tool Name..."
	@if ! command -v tool-name >/dev/null 2>&1; then \
		brew install tool-name; \
	else \
		echo "Tool Name is already installed."; \
	fi

# Good: Check if application exists before installing
app-name:
	@echo "Installing App Name..."
	@if ! ls /Applications/App\ Name.app >/dev/null 2>&1; then \
		brew install --cask app-name; \
	else \
		echo "App Name is already installed."; \
	fi
```

### Shell Configuration

- Use `$$` for variables in makefile echo statements
- Properly escape special characters
- Test shell configurations in clean environments

### Documentation

- Use clear, descriptive language
- Include examples where helpful
- Update tables and lists when adding new tools
- Follow the existing emoji and formatting style

## 🧪 Testing

### Required Testing

Before submitting a PR, test your changes:

1. **Validate makefile syntax**:
   ```bash
   make -n all
   ```

2. **Test on clean macOS** (if possible):
   - Use a virtual machine or fresh macOS install
   - Run the full setup process
   - Verify all tools work correctly

3. **Test individual components**:
   ```bash
   make your-new-target
   ```

### CI/CD Testing

Our CI runs on multiple macOS versions:
- macOS 12 (Monterey)
- macOS 13 (Ventura) 
- macOS 14 (Sonoma)

The CI will:
- Validate makefile syntax
- Check shell scripts
- Lint markdown files

## 📤 Submitting Changes

### Pull Request Process

1. **Update documentation** - Include any necessary documentation updates
2. **Test thoroughly** - Ensure your changes work on multiple macOS versions
3. **Write clear commit messages** - Follow the existing commit message style
4. **Submit a pull request** - Use the PR template and fill out all sections

### Commit Message Format

```
Add/Update/Fix: Brief description of changes

- Detailed bullet point of change 1
- Detailed bullet point of change 2
- Any breaking changes or important notes

Closes #issue-number (if applicable)
```

### Pull Request Guidelines

- Fill out the PR template completely
- Link to any related issues
- Include screenshots if UI changes are involved
- Be responsive to feedback and requested changes

## 🔍 Code Review Process

1. **Automated checks** - CI must pass (makefile validation, linting)
2. **Manual review** - Code owners will review your changes
3. **Testing** - Changes may be tested on different macOS versions
4. **Approval** - At least one maintainer approval required
5. **Merge** - Maintainers will merge approved PRs

## 🛠 Development Tips

### Adding New Tools

When adding a new tool to the makefile:

1. **Research installation method** - Homebrew, direct download, npm, etc.
2. **Add to .PHONY** - Include your target in the .PHONY line
3. **Add to dependencies** - Include in the `all` target if appropriate
4. **Test installation check** - Verify the "already installed" check works
5. **Update documentation** - Add to README.md tables and descriptions

### Common Patterns

```makefile
# Command-line tool via Homebrew
tool-name:
	@echo "Installing Tool Name..."
	@if ! command -v tool-name >/dev/null 2>&1; then \
		brew install tool-name; \
	else \
		echo "Tool Name is already installed."; \
	fi

# GUI application via Homebrew Cask
app-name:
	@echo "Installing App Name..."
	@if ! ls /Applications/App\ Name.app >/dev/null 2>&1; then \
		brew install --cask app-name; \
	else \
		echo "App Name is already installed."; \
	fi

# Node.js package via npm
npm-package:
	@echo "Installing NPM Package..."
	@if ! command -v npm-package >/dev/null 2>&1; then \
		npm install -g npm-package; \
	else \
		echo "NPM Package is already installed."; \
	fi
```

## 🐛 Reporting Issues

### Bug Reports

Include the following information:

- **macOS version** - Output of `sw_vers`
- **Architecture** - Intel or Apple Silicon
- **Error message** - Complete error output
- **Steps to reproduce** - Exact commands run
- **Expected vs actual behavior**

### Feature Requests

- **Use case** - Why is this feature needed?
- **Proposed solution** - How should it work?
- **Alternatives considered** - Other approaches you've thought about
- **Additional context** - Screenshots, examples, etc.

## 💬 Getting Help

- **GitHub Issues** - For bug reports and feature requests
- **GitHub Discussions** - For questions and general discussion
- **Email** - Contact @tlopez92 for sensitive issues

## 🏆 Recognition

Contributors will be recognized in:
- GitHub contributors list
- Release notes for significant contributions
- Special acknowledgment for major features

## 📜 Code of Conduct

This project follows the [Contributor Covenant](https://www.contributor-covenant.org/). Please be respectful and inclusive in all interactions.

## 🎉 Thank You!

Your contributions help make macOS development setup easier for everyone. Thank you for taking the time to contribute!

---

*Happy contributing! 🚀*