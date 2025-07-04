# Makefile for setting up Mac development environment

.PHONY: all zsh homebrew oh-my-zsh wezterm git font wezterm-config p10k zsh-autosuggestions zsh-syntax-highlighting eza zoxide docker azure azure-functions raycast orbstack warp windsurf vscode claude-code nvm rbenv bun setup_zshrc

all: zsh homebrew oh-my-zsh git font p10k zsh-autosuggestions zsh-syntax-highlighting eza zoxide nvm rbenv bun raycast orbstack warp windsurf vscode claude-code setup_zshrc

zsh:
	@echo "Checking shell..."
	@if [ "$(basename $(SHELL))" != "zsh" ]; then \
		chsh -s /bin/zsh; \
	fi

homebrew:
	@echo "Checking for Homebrew..."
	@if ! command -v brew >/dev/null 2>&1; then \
		echo "Homebrew not found, installing..."; \
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	else \
		echo "Homebrew is already installed."; \
	fi
	@echo "Adding Homebrew to path for Apple Silicon Macbooks..."
	@echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
	@zsh -c "source ~/.zprofile"

wezterm:
	@echo "Installing Wezterm..."
	brew install --cask wezterm

git:
	@echo "Installing git..."
	brew install git

font:
	@echo "Installing Meslo Nerd Font..."
	brew install font-meslo-lg-nerd-font

wezterm-config:
	@echo "Setting up Wezterm configuration..."
	@touch ~/.wezterm.lua
	@echo '-- Pull in the wezterm API\nlocal wezterm = require("wezterm")\n\n-- This will hold the configuration.\nlocal config = wezterm.config_builder()\n\n-- Config choices\nconfig.font = wezterm.font("MesloLGS Nerd Font", { weight = "Regular" })\nconfig.font_size = 14\nconfig.enable_tab_bar = true\nconfig.window_decorations = "RESIZE"\nconfig.window_background_opacity = 0.9\nconfig.macos_window_background_blur = 20\n\n-- Colorscheme\nconfig.colors = {\n\tforeground = "#CBE0F0",\n\tbackground = "#011423",\n\tcursor_bg = "#47FF9C",\n\tcursor_border = "#47FF9C",\n\tcursor_fg = "#011423",\n\tselection_bg = "#033259",\n\tselection_fg = "#CBE0F0",\n\tansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },\n\tbrights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },\n}\n\n-- Return configuration\nreturn config' > ~/.wezterm.lua

p10k:
	@echo "Installing Powerlevel10k theme..."
	brew install powerlevel10k

zsh-autosuggestions:
	@echo "Installing zsh-autosuggestions..."
	brew install zsh-autosuggestions

zsh-syntax-highlighting:
	@echo "Installing zsh-syntax-highlighting..."
	brew install zsh-syntax-highlighting

eza:
	@echo "Installing eza (better ls)..."
	brew install eza

zoxide:
	@echo "Installing zoxide (better cd)..."
	brew install zoxide

docker:
	@echo "Installing Docker..."
	if ! command -v docker &> /dev/null; then \
  		brew install --cask docker; \
  	fi

azure:
	@echo "Installing Azure CLI..."
	brew install azure-cli
	@echo "Running Azure login..."
	@zsh -c "az login"

azure-functions:
	@echo "Installing Azure Functions Core Tools..."
	brew tap azure/functions
	brew install azure-functions-core-tools@4

oh-my-zsh:
	@echo "Installing Oh My Zsh..."
	@if [ ! -d "$$HOME/.oh-my-zsh" ]; then \
		sh -c "$$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended; \
	else \
		echo "Oh My Zsh is already installed."; \
	fi

nvm:
	@echo "Installing NVM..."
	@if [ ! -d "$$HOME/.nvm" ]; then \
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash; \
		export NVM_DIR="$$HOME/.nvm"; \
		[ -s "$$NVM_DIR/nvm.sh" ] && \. "$$NVM_DIR/nvm.sh"; \
		nvm install --lts; \
		nvm use --lts; \
		nvm alias default lts/*; \
	else \
		echo "NVM is already installed."; \
	fi

rbenv:
	@echo "Installing rbenv..."
	@if ! command -v rbenv >/dev/null 2>&1; then \
		brew install rbenv ruby-build; \
		rbenv install $$(rbenv install -l | grep -v - | tail -1); \
		rbenv global $$(rbenv install -l | grep -v - | tail -1); \
	else \
		echo "rbenv is already installed."; \
	fi

bun:
	@echo "Installing Bun..."
	@if ! command -v bun >/dev/null 2>&1; then \
		curl -fsSL https://bun.sh/install | bash; \
	else \
		echo "Bun is already installed."; \
	fi

raycast:
	@echo "Installing Raycast..."
	@if ! ls /Applications/Raycast.app >/dev/null 2>&1; then \
		brew install --cask raycast; \
	else \
		echo "Raycast is already installed."; \
	fi

orbstack:
	@echo "Installing OrbStack..."
	@if ! ls /Applications/OrbStack.app >/dev/null 2>&1; then \
		brew install --cask orbstack; \
	else \
		echo "OrbStack is already installed."; \
	fi

warp:
	@echo "Installing Warp..."
	@if ! ls /Applications/Warp.app >/dev/null 2>&1; then \
		brew install --cask warp; \
	else \
		echo "Warp is already installed."; \
	fi

windsurf:
	@echo "Installing Windsurf..."
	@if ! ls /Applications/Windsurf.app >/dev/null 2>&1; then \
		brew install --cask windsurf; \
	else \
		echo "Windsurf is already installed."; \
	fi

vscode:
	@echo "Installing Visual Studio Code..."
	@if ! ls /Applications/Visual\ Studio\ Code.app >/dev/null 2>&1; then \
		brew install --cask visual-studio-code; \
	else \
		echo "Visual Studio Code is already installed."; \
	fi

claude-code:
	@echo "Installing Claude Code..."
	@if ! command -v claude-code >/dev/null 2>&1; then \
		npm install -g @anthropic-ai/claude-code; \
	else \
		echo "Claude Code is already installed."; \
	fi

setup_zshrc:
	@echo "Setting up .zshrc..."
	@echo '# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.\n# Initialization code that may require console input (password prompts, [y/n]\n# confirmations, etc.) must go above this block; everything else may go below.\nif [[ -r "$$HOME/.cache/p10k-instant-prompt-$${(%):-%n}.zsh" ]]; then\n  source "$$HOME/.cache/p10k-instant-prompt-$${(%):-%n}.zsh"\nfi\n\n# PATH configuration\nexport PATH="/usr/local/share/dotnet:$$PATH"\n\n# Oh My Zsh configuration\nexport ZSH="$$HOME/.oh-my-zsh"\nZSH_THEME="powerlevel10k/powerlevel10k"\nplugins=(git zsh-autosuggestions)\n\nsource $$ZSH/oh-my-zsh.sh\n\n# Sourcing additional plugins and themes\nsource $$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh\nsource $$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh\n\n# Powerlevel10k configuration\n[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh\n\n# History setup\nHISTFILE=$$HOME/.zhistory\nSAVEHIST=1000\nHISTSIZE=999\nsetopt share_history\nsetopt hist_expire_dups_first\nsetopt hist_ignore_dups\nsetopt hist_verify\n\n# Key bindings for history search\nbindkey "^[[A" history-search-backward\nbindkey "^[[B" history-search-forward\n\n# Aliases and utilities\nalias ls="eza --icons=always"\neval "$$(zoxide init zsh)"\nalias cd="z"\n\n# NVM configuration - updated for latest LTS\nexport NVM_DIR="$$HOME/.nvm"\n[ -s "$$NVM_DIR/nvm.sh" ] && \\. "$$NVM_DIR/nvm.sh"  # This loads nvm\n[ -s "$$NVM_DIR/bash_completion" ] && \\. "$$NVM_DIR/bash_completion"  # This loads nvm bash_completion\n# Use default Node version (will be set to latest LTS)\nnvm use default --silent 2>/dev/null || nvm use --lts --silent\n\n# Ruby configuration\neval "$$(rbenv init - zsh)"\n\n# Added by Windsurf\nexport PATH="/Users/tj/.codeium/windsurf/bin:$$PATH"\n\n# bun completions\n[ -s "/Users/tj/.bun/_bun" ] && source "/Users/tj/.bun/_bun"\n\n# bun\nexport BUN_INSTALL="$$HOME/.bun"\nexport PATH="$$BUN_INSTALL/bin:$$PATH"' > ~/.zshrc