# zmodload zsh/zprof

# Checking for updates slows down startup 
export DISABLE_AUTO_UPDATE="true"

# If you come from bash you might have to change your $PATH. export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/Users/tobiasandersen/.local/bin:$PATH
export PATH=/usr/local/opt/curl/bin:$PATH
export PATH=/Library/Frameworks/Python.framework/Versions/2.7/bin:$PATH
export PATH=~/Desktop/keylocker:$PATH

# curl-openssl
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/curl/lib"
export CPPFLAGS="-I/opt/homebrew/opt/curl/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/curl/lib/pkgconfig"

source ~/.zsh/prompt.zsh 
source ~/.zsh/alias.zsh
source ~/.zsh/config.zsh
source ~/.zsh/completion.zsh

# Zoxide 
eval "$(zoxide init zsh)"

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

# Use pyenv for python
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# ZSH Theme
ZSH_THEME="robbyrussell"

# Loading nvm slows down startup, so we tell zsh to load it lazily.
export NVM_LAZY=1

# Plugins
plugins=(
  nvm
  git
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

# Add stuff to path
path=('/usr/local/bin/fd' $path)

export PATH

# Load completion
# autoload -Uz compinit && compinit 


# zprofa
