# History configuration
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# Basic zsh completion
autoload -U compinit && compinit

# Path configuration
export PATH="$HOME/.local/bin:$PATH"
export PATH=~/.opencode/bin:$PATH

# Better editor integration
export VISUAL=${SHELL_EDITOR:-nvim}
export EDITOR=${SHELL_EDITOR:-nvim}
export BROWSER=${SHELL_BROWSER:-firefox}

# Aliases
alias p='cd ~/Documents/projects/'
alias s='cd ~/Documents/sandbox/'
alias ls='eza --icons'
alias ll='eza --icons -l'
alias la='eza --icons -la'
alias sl="wezterm cli split-pane --left"
alias sb="wezterm cli split-pane --bottom"
alias nt="wezterm cli set-tab-title"
alias gs="git status"
# Linux-specific alias
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    alias open='xdg-open'
fi

# Useful Functions
mkcd() { mkdir -p "$1" && cd "$1"; }

# Initialize tools
eval "$(zoxide init zsh)"

# Load zsh plugins from system locations
if [[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    # macOS (Apple Silicon)
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    # macOS (Intel)
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    # Linux (CachyOS/Arch)
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    # macOS (Apple Silicon)
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    # macOS (Intel)
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    # Linux (CachyOS/Arch)
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# p10k - Load from different locations depending on OS
if [[ -f /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]]; then
    # Linux (CachyOS/Arch)
    source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
elif [[ -f /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme ]]; then
    # macOS (Apple Silicon)
    source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
elif [[ -f /usr/local/share/powerlevel10k/powerlevel10k.zsh-theme ]]; then
    # macOS (Intel)
    source /usr/local/share/powerlevel10k/powerlevel10k.zsh-theme
fi
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
