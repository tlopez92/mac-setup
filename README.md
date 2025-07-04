# 🚀 Mac Development Environment Setup

[![macOS](https://img.shields.io/badge/macOS-000000?style=for-the-badge&logo=apple&logoColor=white)](https://www.apple.com/macos/)
[![Terminal](https://img.shields.io/badge/Terminal-4D4D4D?style=for-the-badge&logo=gnome-terminal&logoColor=white)](https://github.com/microsoft/terminal)
[![Shell](https://img.shields.io/badge/Shell-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://en.wikipedia.org/wiki/Bash_(Unix_shell))

A comprehensive, automated setup for macOS development environments focused on modern web development, AI tooling, containerization, and .NET development.

## 🌟 Features

This setup provides a complete development environment with:

### 🔧 Core Tools
- **Homebrew** - Package manager for macOS
- **Git** - Version control system
- **Oh My Zsh** - Powerful Zsh framework
- **Powerlevel10k** - Beautiful and fast Zsh theme

### 🎨 Terminal & Shell Enhancement
- **WezTerm** - Modern terminal emulator with excellent performance
- **Warp** - AI-powered terminal (alternative option)
- **Zsh Autosuggestions** - Intelligent command completion
- **Zsh Syntax Highlighting** - Real-time syntax highlighting
- **Eza** - Modern replacement for `ls` with icons
- **Zoxide** - Smart directory navigation (`cd` replacement)
- **MesloLGS Nerd Font** - Font with programming icons and symbols

### 💻 Development Tools
- **Visual Studio Code** - Popular code editor
- **Windsurf** - AI-powered development environment
- **Claude Code** - AI coding assistant CLI
- **Docker via OrbStack** - Containerization platform
- **Raycast** - Productivity launcher and automation

### 🛠 Runtime & Language Support
- **Node.js via NVM** - JavaScript runtime with version management
- **Ruby via rbenv** - Ruby runtime with version management
- **Bun** - Fast JavaScript runtime and package manager
- **.NET** - Microsoft's development platform
- **Azure CLI & Functions** - Cloud development tools

## 🚀 Quick Start

### Prerequisites
- macOS (Intel or Apple Silicon)
- Administrative privileges on your Mac
- Internet connection

### One-Command Setup

```bash
git clone https://github.com/tlopez92/mac-setup.git
cd mac-setup
make all
```

That's it! The setup will automatically install and configure everything for you.

## 📋 What Gets Installed

### 🖥 Applications
| Application | Purpose | Installation Method |
|-------------|---------|-------------------|
| **WezTerm** | Primary terminal emulator | Homebrew Cask |
| **Warp** | AI-powered terminal | Homebrew Cask |
| **Visual Studio Code** | Code editor | Homebrew Cask |
| **Windsurf** | AI development environment | Homebrew Cask |
| **Raycast** | Productivity launcher | Homebrew Cask |
| **OrbStack** | Docker/container management | Homebrew Cask |

### 🔧 Command Line Tools
| Tool | Purpose | Installation Method |
|------|---------|-------------------|
| **Git** | Version control | Homebrew |
| **Oh My Zsh** | Zsh framework | Shell script |
| **Powerlevel10k** | Zsh theme | Homebrew |
| **Zsh Autosuggestions** | Command completion | Homebrew |
| **Zsh Syntax Highlighting** | Syntax highlighting | Homebrew |
| **Eza** | Better `ls` command | Homebrew |
| **Zoxide** | Smart directory navigation | Homebrew |
| **Claude Code** | AI coding assistant | NPM |
| **Azure CLI** | Azure cloud tools | Homebrew |
| **Azure Functions** | Serverless development | Homebrew |

### 🏃‍♂️ Runtimes & Version Managers
| Runtime | Version Manager | Purpose |
|---------|----------------|---------|
| **Node.js** | NVM | JavaScript development |
| **Ruby** | rbenv | Ruby development |
| **Bun** | Self-managed | Fast JS runtime |
| **.NET** | Built-in | Microsoft development |

## 🎯 Manual Steps

After running `make all`, you may need to complete these manual steps:

### 1. Configure Terminals
- **WezTerm**: Configuration is automatically set up
- **Warp**: Launch and follow the setup wizard
- **Terminal Font**: Ensure MesloLGS Nerd Font is selected

### 2. Configure Powerlevel10k
```bash
# Run the configuration wizard
p10k configure
```

### 3. Application Setup
- **Raycast**: Launch and configure your preferred shortcuts
- **OrbStack**: Launch and complete Docker setup
- **Visual Studio Code**: Install your preferred extensions
- **Windsurf**: Sign in with your account

### 4. Cloud Tools (Optional)
```bash
# Sign in to Azure (if using Azure)
az login

# Configure Claude Code (if using Claude)
claude-code auth
```

## 🔧 Customization

### Terminal Themes
The setup includes a custom color scheme for WezTerm. You can modify it by editing:
```bash
~/.wezterm.lua
```

### Zsh Configuration
Your shell configuration is located at:
```bash
~/.zshrc
```

### Adding More Tools
To add additional tools to the setup:
1. Edit the `makefile`
2. Add your tool to the `.PHONY` target list
3. Create a new target with installation commands
4. Add the target to the `all` dependency list

## 🛠 Individual Components

You can install individual components instead of everything:

```bash
# Install just the terminal setup
make zsh homebrew font p10k zsh-autosuggestions zsh-syntax-highlighting

# Install just development tools
make nvm rbenv bun vscode windsurf claude-code

# Install just productivity apps
make raycast warp orbstack

# Setup just the shell configuration
make setup_zshrc
```

## 🔍 Troubleshooting

### Common Issues

#### Font Issues
If icons don't display correctly:
1. Ensure WezTerm is using "MesloLGS Nerd Font"
2. Restart your terminal
3. Run `p10k configure` to reconfigure the theme

#### Permission Issues
If you encounter permission errors:
```bash
# Fix Homebrew permissions
sudo chown -R $(whoami) /usr/local/share/zsh /usr/local/share/zsh/site-functions
```

#### NVM/Node Issues
If Node.js isn't available:
```bash
# Reload your shell
source ~/.zshrc

# Install latest LTS Node
nvm install --lts
nvm use --lts
```

#### Theme Not Loading
If Powerlevel10k isn't working:
```bash
# Reinstall the theme
brew reinstall powerlevel10k

# Reconfigure
p10k configure
```

### Getting Help

1. **Check the logs**: Most installation steps show detailed output
2. **Restart your terminal**: Many changes require a fresh terminal session
3. **Reload your shell**: Run `source ~/.zshrc` after making changes
4. **Check installed tools**: Use `which <tool>` to verify installation

## 🤝 Contributing

Feel free to submit issues and enhancement requests!

### To contribute:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test on a clean macOS system
5. Submit a pull request

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

## 🙏 Acknowledgments

This setup is inspired by and builds upon the excellent work of:
- [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [Homebrew](https://brew.sh)
- The amazing macOS development community

---

**Happy coding! 🎉**

*Made with ❤️ for the macOS development community*