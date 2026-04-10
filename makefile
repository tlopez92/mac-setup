SHELL := /bin/bash
PATH := /opt/homebrew/bin:/usr/local/bin:$(PATH)
export PATH

.DEFAULT_GOAL := help
.NOTPARALLEL:

HOME_DIR := $(HOME)
ZPROFILE := $(HOME_DIR)/.zprofile
MANAGED_ZPROFILE := $(HOME_DIR)/.zprofile.mac-setup
ZSHRC := $(HOME_DIR)/.zshrc
MANAGED_ZSHRC := $(HOME_DIR)/.zshrc.mac-setup
WEZTERM_CONFIG := $(HOME_DIR)/.wezterm.lua
OH_MY_ZSH_DIR := $(HOME_DIR)/.oh-my-zsh
OH_MY_ZSH_CUSTOM := $(OH_MY_ZSH_DIR)/custom
NVM_DIR := $(HOME_DIR)/.nvm

CORE_TARGETS := zsh homebrew git oh-my-zsh font p10k zsh-autosuggestions zsh-syntax-highlighting eza zoxide setup_shell wezterm wezterm-config
LANGUAGE_TARGETS := nvm node rbenv bun dotnet python anaconda
APP_TARGETS := raycast orbstack warp vscode rider jetbrains-toolbox postman insomnia
AI_TARGETS := claude-code github-copilot ollama
DATA_TARGETS := postgresql redis mongodb
CLOUD_TARGETS := aws terraform
OPTIONAL_TARGETS := azure azure-functions docker windsurf

.PHONY: help all core languages apps ai data cloud optional doctor \
	check-macos zsh homebrew tap-hashicorp tap-mongodb tap-azure-functions \
	oh-my-zsh link-oh-my-zsh-assets setup_shell setup_zshrc wezterm-config wezterm git font p10k \
	zsh-autosuggestions zsh-syntax-highlighting eza zoxide docker azure azure-functions aws terraform \
	raycast orbstack warp windsurf vscode claude-code github-copilot dotnet rider jetbrains-toolbox \
	python anaconda ollama postman insomnia postgresql redis mongodb nvm node rbenv bun

define install_formula
	@echo "Ensuring Homebrew formula '$(1)' is installed..."
	@brew list --formula $(1) >/dev/null 2>&1 || brew install $(1)
endef

define install_cask
	@echo "Ensuring Homebrew cask '$(1)' is installed..."
	@brew list --cask $(1) >/dev/null 2>&1 || brew install --cask $(1)
endef

define install_app_cask
	@echo "Ensuring Homebrew cask '$(1)' is installed..."
	@if brew list --cask $(1) >/dev/null 2>&1; then \
		echo "Homebrew cask '$(1)' is already installed."; \
	elif [ -d "/Applications/$(2)" ]; then \
		echo "Found existing /Applications/$(2); attempting to adopt it into Homebrew..."; \
		brew install --cask --adopt $(1) || { \
			echo "Could not adopt /Applications/$(2); leaving it in place and continuing."; \
		}; \
	else \
		brew install --cask $(1); \
	fi
endef

help:
	@printf '%s\n' \
		"make all       Install the default macOS setup." \
		"make core      Install shell tooling and terminal defaults." \
		"make languages Install language runtimes and SDKs." \
		"make apps      Install desktop applications." \
		"make ai        Install AI tooling." \
		"make data      Install local databases." \
		"make cloud     Install cloud and IaC CLIs." \
		"make optional  Install opt-in extras not included in 'all'." \
		"make doctor    Print a quick post-install summary."

all: core languages apps ai data cloud doctor

core: check-macos $(CORE_TARGETS)

languages: check-macos $(LANGUAGE_TARGETS)

apps: check-macos $(APP_TARGETS)

ai: check-macos $(AI_TARGETS)

data: check-macos $(DATA_TARGETS)

cloud: check-macos $(CLOUD_TARGETS)

optional: check-macos $(OPTIONAL_TARGETS)

check-macos:
	@echo "Checking operating system..."
	@if [ "$$(uname -s)" != "Darwin" ]; then \
		echo "This setup only supports macOS."; \
		exit 1; \
	fi

zsh:
	@echo "Checking login shell..."
	@if [ "$$SHELL" = "/bin/zsh" ]; then \
		echo "zsh is already the active shell."; \
	else \
		echo "Your current shell is $$SHELL."; \
		echo "If you want zsh as the login shell, run: chsh -s /bin/zsh"; \
	fi

homebrew: check-macos
	@echo "Ensuring Homebrew is installed..."
	@if command -v brew >/dev/null 2>&1; then \
		echo "Homebrew is already installed at $$(command -v brew)."; \
	else \
		echo "Homebrew is not installed yet."; \
		echo "The first run may prompt for your macOS administrator password."; \
		NONINTERACTIVE=1 /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	fi
	@echo "Writing Homebrew shell configuration..."
	@{ \
		printf '%s\n' '# Managed by mac-setup'; \
		printf '%s\n' 'if [ -x /opt/homebrew/bin/brew ]; then'; \
		printf '%s\n' '  eval "$$(/opt/homebrew/bin/brew shellenv)"'; \
		printf '%s\n' 'elif [ -x /usr/local/bin/brew ]; then'; \
		printf '%s\n' '  eval "$$(/usr/local/bin/brew shellenv)"'; \
		printf '%s\n' 'fi'; \
	} > "$(MANAGED_ZPROFILE)"
	@touch "$(ZPROFILE)"
	@if grep -Fq 'source "$$HOME/.zprofile.mac-setup"' "$(ZPROFILE)"; then \
		echo "$(ZPROFILE) already sources $(MANAGED_ZPROFILE)."; \
	else \
		printf '\n[ -f "$$HOME/.zprofile.mac-setup" ] && source "$$HOME/.zprofile.mac-setup"\n' >> "$(ZPROFILE)"; \
		echo "Added Homebrew shellenv include to $(ZPROFILE)."; \
	fi

tap-hashicorp: homebrew
	@echo "Ensuring HashiCorp tap is available..."
	@brew tap hashicorp/tap >/dev/null

tap-mongodb: homebrew
	@echo "Ensuring MongoDB tap is available..."
	@brew tap mongodb/brew >/dev/null

tap-azure-functions: homebrew
	@echo "Ensuring Azure Functions tap is available..."
	@brew tap azure/functions >/dev/null

wezterm: homebrew
	$(call install_app_cask,wezterm,WezTerm.app)

git: homebrew
	$(call install_formula,git)

font: homebrew
	$(call install_cask,font-meslo-lg-nerd-font)

p10k: homebrew
	$(call install_formula,powerlevel10k)

zsh-autosuggestions: homebrew
	$(call install_formula,zsh-autosuggestions)

zsh-syntax-highlighting: homebrew
	$(call install_formula,zsh-syntax-highlighting)

eza: homebrew
	$(call install_formula,eza)

zoxide: homebrew
	$(call install_formula,zoxide)

oh-my-zsh:
	@echo "Ensuring Oh My Zsh is installed..."
	@if [ -d "$(OH_MY_ZSH_DIR)" ]; then \
		echo "Oh My Zsh is already installed."; \
	else \
		RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; \
	fi

link-oh-my-zsh-assets: oh-my-zsh p10k zsh-autosuggestions zsh-syntax-highlighting
	@echo "Linking Powerlevel10k and zsh plugins into Oh My Zsh..."
	@mkdir -p "$(OH_MY_ZSH_CUSTOM)/themes" "$(OH_MY_ZSH_CUSTOM)/plugins"
	@ln -sfn "$$(brew --prefix powerlevel10k)/share/powerlevel10k" "$(OH_MY_ZSH_CUSTOM)/themes/powerlevel10k"
	@ln -sfn "$$(brew --prefix zsh-autosuggestions)/share/zsh-autosuggestions" "$(OH_MY_ZSH_CUSTOM)/plugins/zsh-autosuggestions"
	@ln -sfn "$$(brew --prefix zsh-syntax-highlighting)/share/zsh-syntax-highlighting" "$(OH_MY_ZSH_CUSTOM)/plugins/zsh-syntax-highlighting"

setup_shell: homebrew link-oh-my-zsh-assets
	@echo "Writing managed shell configuration..."
	@{ \
		printf '%s\n' '# Managed by mac-setup'; \
		printf '%s\n' 'if command -v eza >/dev/null 2>&1; then'; \
		printf '%s\n' '  alias ls="eza --icons=auto"'; \
		printf '%s\n' 'fi'; \
		printf '%s\n' ''; \
		printf '%s\n' 'if command -v zoxide >/dev/null 2>&1; then'; \
		printf '%s\n' '  eval "$$(zoxide init zsh)"'; \
		printf '%s\n' '  alias cd="z"'; \
		printf '%s\n' 'fi'; \
		printf '%s\n' ''; \
		printf '%s\n' 'export NVM_DIR="$$HOME/.nvm"'; \
		printf '%s\n' 'if [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then'; \
		printf '%s\n' '  . "/opt/homebrew/opt/nvm/nvm.sh"'; \
		printf '%s\n' 'elif [ -s "/usr/local/opt/nvm/nvm.sh" ]; then'; \
		printf '%s\n' '  . "/usr/local/opt/nvm/nvm.sh"'; \
		printf '%s\n' 'fi'; \
		printf '%s\n' 'if command -v nvm >/dev/null 2>&1; then'; \
		printf '%s\n' '  nvm use --silent default >/dev/null 2>&1 || true'; \
		printf '%s\n' 'fi'; \
		printf '%s\n' ''; \
		printf '%s\n' 'if command -v rbenv >/dev/null 2>&1; then'; \
		printf '%s\n' '  eval "$$(rbenv init - zsh)"'; \
		printf '%s\n' 'fi'; \
		printf '%s\n' ''; \
		printf '%s\n' 'if [ -d "$$HOME/.bun/bin" ]; then'; \
		printf '%s\n' '  export BUN_INSTALL="$$HOME/.bun"'; \
		printf '%s\n' '  export PATH="$$BUN_INSTALL/bin:$$PATH"'; \
		printf '%s\n' 'fi'; \
		printf '%s\n' ''; \
		printf '%s\n' 'if [ -d "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" ]; then'; \
		printf '%s\n' '  export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$$PATH"'; \
		printf '%s\n' 'fi'; \
		printf '%s\n' ''; \
		printf '%s\n' 'if [ -d "$$HOME/.codeium/windsurf/bin" ]; then'; \
		printf '%s\n' '  export PATH="$$HOME/.codeium/windsurf/bin:$$PATH"'; \
		printf '%s\n' 'fi'; \
		printf '%s\n' ''; \
		printf '%s\n' 'if [ -d "/usr/local/share/dotnet" ]; then'; \
		printf '%s\n' '  export PATH="/usr/local/share/dotnet:$$PATH"'; \
		printf '%s\n' 'fi'; \
	} > "$(MANAGED_ZSHRC)"
	@if [ ! -f "$(ZSHRC)" ]; then \
		echo "Creating $(ZSHRC) starter config..."; \
		{ \
			printf '%s\n' '# Generated by mac-setup'; \
			printf '%s\n' 'export ZSH="$$HOME/.oh-my-zsh"'; \
			printf '%s\n' 'ZSH_THEME="powerlevel10k/powerlevel10k"'; \
			printf '%s\n' 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting)'; \
			printf '%s\n' ''; \
			printf '%s\n' 'if [ -d "$$ZSH" ]; then'; \
			printf '%s\n' '  source "$$ZSH/oh-my-zsh.sh"'; \
			printf '%s\n' 'fi'; \
			printf '%s\n' ''; \
			printf '%s\n' '[ -f "$$HOME/.zshrc.mac-setup" ] && source "$$HOME/.zshrc.mac-setup"'; \
		} > "$(ZSHRC)"; \
	else \
		echo "Preserving existing $(ZSHRC)."; \
		if grep -Fq 'source "$$HOME/.zshrc.mac-setup"' "$(ZSHRC)"; then \
			echo "$(ZSHRC) already sources $(MANAGED_ZSHRC)."; \
		else \
			printf '\n[ -f "$$HOME/.zshrc.mac-setup" ] && source "$$HOME/.zshrc.mac-setup"\n' >> "$(ZSHRC)"; \
			echo "Added managed config include to $(ZSHRC)."; \
		fi; \
	fi

setup_zshrc: setup_shell

wezterm-config:
	@echo "Ensuring WezTerm configuration exists..."
	@if [ -f "$(WEZTERM_CONFIG)" ]; then \
		echo "$(WEZTERM_CONFIG) already exists; leaving it unchanged."; \
	else \
		{ \
			printf '%s\n' '-- Managed starter config created by mac-setup'; \
			printf '%s\n' 'local wezterm = require("wezterm")'; \
			printf '%s\n' 'local config = wezterm.config_builder()'; \
			printf '%s\n' ''; \
			printf '%s\n' 'config.font = wezterm.font("MesloLGS Nerd Font")'; \
			printf '%s\n' 'config.font_size = 14'; \
			printf '%s\n' 'config.enable_tab_bar = true'; \
			printf '%s\n' 'config.window_decorations = "RESIZE"'; \
			printf '%s\n' 'config.window_background_opacity = 0.92'; \
			printf '%s\n' 'config.macos_window_background_blur = 20'; \
			printf '%s\n' ''; \
			printf '%s\n' 'config.colors = {'; \
			printf '%s\n' '  foreground = "#CBE0F0",'; \
			printf '%s\n' '  background = "#011423",'; \
			printf '%s\n' '  cursor_bg = "#47FF9C",'; \
			printf '%s\n' '  cursor_border = "#47FF9C",'; \
			printf '%s\n' '  cursor_fg = "#011423",'; \
			printf '%s\n' '  selection_bg = "#033259",'; \
			printf '%s\n' '  selection_fg = "#CBE0F0",'; \
			printf '%s\n' '  ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#A277FF", "#24EAF7", "#24EAF7" },'; \
			printf '%s\n' '  brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#A277FF", "#24EAF7", "#24EAF7" },'; \
			printf '%s\n' '}'; \
			printf '%s\n' ''; \
			printf '%s\n' 'return config'; \
		} > "$(WEZTERM_CONFIG)"; \
		echo "Created starter WezTerm config at $(WEZTERM_CONFIG)."; \
	fi

docker: orbstack
	@echo "OrbStack is the default Docker-compatible runtime in this setup."

azure: homebrew
	$(call install_formula,azure-cli)

azure-functions: tap-azure-functions
	$(call install_formula,azure-functions-core-tools@4)

aws: homebrew
	$(call install_formula,awscli)

terraform: tap-hashicorp
	@echo "Ensuring Homebrew formula 'hashicorp/tap/terraform' is installed..."
	@brew list --formula terraform >/dev/null 2>&1 || brew install hashicorp/tap/terraform

raycast: homebrew
	$(call install_app_cask,raycast,Raycast.app)

orbstack: homebrew
	$(call install_app_cask,orbstack,OrbStack.app)

warp: homebrew
	$(call install_app_cask,warp,Warp.app)

windsurf: homebrew
	$(call install_app_cask,windsurf,Windsurf.app)

vscode: homebrew
	$(call install_app_cask,visual-studio-code,Visual Studio Code.app)

dotnet: homebrew
	$(call install_cask,dotnet-sdk)

rider: homebrew
	$(call install_app_cask,rider,Rider.app)

jetbrains-toolbox: homebrew
	$(call install_app_cask,jetbrains-toolbox,JetBrains Toolbox.app)

python: homebrew
	$(call install_formula,python)

anaconda: homebrew
	$(call install_cask,anaconda)

nvm: homebrew
	$(call install_formula,nvm)
	@mkdir -p "$(NVM_DIR)"

node: nvm
	@echo "Ensuring the current Node.js LTS is installed via nvm..."
	@export NVM_DIR="$(NVM_DIR)"; \
	. "$$(brew --prefix nvm)/nvm.sh"; \
	nvm install --lts; \
	nvm alias default 'lts/*'; \
	nvm use --silent default >/dev/null

rbenv: homebrew
	@echo "Ensuring Homebrew formulas 'rbenv' and 'ruby-build' are installed..."
	@brew list --formula rbenv >/dev/null 2>&1 || brew install rbenv
	@brew list --formula ruby-build >/dev/null 2>&1 || brew install ruby-build
	@LATEST_RUBY="$$(rbenv install -l 2>/dev/null | sed 's/^[[:space:]]*//' | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$$' | tail -1)"; \
	if [ -n "$$LATEST_RUBY" ]; then \
		if ! rbenv versions --bare | grep -qx "$$LATEST_RUBY"; then \
			echo "Installing Ruby $$LATEST_RUBY via rbenv..."; \
			rbenv install "$$LATEST_RUBY"; \
		else \
			echo "Ruby $$LATEST_RUBY is already installed via rbenv."; \
		fi; \
		rbenv global "$$LATEST_RUBY"; \
	else \
		echo "Could not determine the latest stable Ruby version."; \
		exit 1; \
	fi

bun:
	@echo "Ensuring Bun is installed..."
	@if command -v bun >/dev/null 2>&1; then \
		echo "Bun is already installed."; \
	else \
		curl -fsSL https://bun.sh/install | bash; \
	fi

claude-code: node
	@echo "Ensuring Claude Code is installed..."
	@export NVM_DIR="$(NVM_DIR)"; \
	. "$$(brew --prefix nvm)/nvm.sh"; \
	nvm use --silent default >/dev/null; \
	if command -v claude >/dev/null 2>&1; then \
		echo "Claude Code is already installed."; \
	else \
		npm install -g @anthropic-ai/claude-code; \
	fi

github-copilot: homebrew
	@echo "Ensuring GitHub CLI is installed..."
	@brew list --formula gh >/dev/null 2>&1 || brew install gh
	@echo "Ensuring GitHub Copilot CLI extension is installed..."
	@if gh extension list | grep -q 'github/gh-copilot'; then \
		echo "GitHub Copilot CLI is already installed."; \
	else \
		gh extension install github/gh-copilot; \
	fi

ollama: homebrew
	$(call install_formula,ollama)
	@echo "Starting Ollama service..."
	@brew services start ollama >/dev/null || true

postman: homebrew
	$(call install_app_cask,postman,Postman.app)

insomnia: homebrew
	$(call install_app_cask,insomnia,Insomnia.app)

postgresql: homebrew
	$(call install_formula,postgresql)
	@echo "Starting PostgreSQL service..."
	@brew services start postgresql >/dev/null || true

redis: homebrew
	$(call install_formula,redis)
	@echo "Starting Redis service..."
	@brew services start redis >/dev/null || true

mongodb: tap-mongodb
	@echo "Ensuring Homebrew formula 'mongodb-community' is installed..."
	@brew list --formula mongodb-community >/dev/null 2>&1 || brew install mongodb-community
	@echo "Starting MongoDB service..."
	@brew services start mongodb-community >/dev/null || true

doctor:
	@echo "Post-install summary:"
	@for cmd in brew git zsh eza zoxide aws terraform python3 dotnet gh ollama psql redis-cli; do \
		if command -v $$cmd >/dev/null 2>&1; then \
			echo "  [ok] $$cmd -> $$(command -v $$cmd)"; \
		else \
			echo "  [warn] $$cmd is not on PATH in this shell yet"; \
		fi; \
	done
	@export NVM_DIR="$(NVM_DIR)"; \
	if [ -s "$$(brew --prefix nvm 2>/dev/null)/nvm.sh" ]; then \
		. "$$(brew --prefix nvm)/nvm.sh"; \
		nvm use --silent default >/dev/null 2>&1 || true; \
		for cmd in node npm claude; do \
			if command -v $$cmd >/dev/null 2>&1; then \
				echo "  [ok] $$cmd -> $$(command -v $$cmd)"; \
			else \
				echo "  [warn] $$cmd is not on PATH in this shell yet"; \
			fi; \
		done; \
	fi
	@echo "Open a new terminal or run 'source ~/.zprofile && source ~/.zshrc' after installation."
