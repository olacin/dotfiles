export SHELL=/bin/zsh
export EDITOR='nvim'

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export HISTSIZE=100000000
export SAVEHIST=$HISTSIZE
export HISTFILE=$HOME/.zsh_history

# Plugins
source "$HOME/antigen/antigen.zsh"

antigen use oh-my-zsh

antigen bundle aliases
antigen bundle command-not-found
antigen bundle docker
antigen bundle docker-compose
antigen bundle git
antigen bundle zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply

eval "$(starship init zsh)"

# Path
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/.local/share/nvim/lsp_servers/rust"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

HYPHEN_INSENSITIVE="true"
DISABLE_UPDATE_PROMPT="true"

# Node
export PATH="$PATH:${HOME}/.npm-packages/bin"
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# React Native
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools

# Python
export PYTHONDONTWRITEBYTECODE=1
export PIPENV_VENV_IN_PROJECT=1
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

eval "$(zoxide init zsh)"

sources=(
    "isec"
    "aliases"
)

for s in "${sources[@]}"; do
  source $HOME/.config/zsh/include/${s}.zsh
done
