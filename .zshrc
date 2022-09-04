# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/Users/tobiasandersen/.local/bin:$PATH

source ~/.zsh/prompt.zsh
source ~/.zsh/config.zsh
source ~/.zsh/alias.zsh

# Completion
autoload -U compinit
compinit

source ~/.zsh/completion.zsh

# Better history
# Credits to https://coderwall.com/p/jpj_6q/zsh-better-history-searching-with-arrow-keys
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# Path to your oh-my-zsh installation.
export ZSH="/Users/tobiasandersen/.oh-my-zsh"

# Path to nvm
export NVM_DIR=~/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Use pyenv for python
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# ZSH Theme
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  github
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Load bmux stuff
source ~/.bt_net.profile

# Set language
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Add ccache to path
path=('/usr/local/opt/ccache/libexec' $path)

