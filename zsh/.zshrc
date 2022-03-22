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

# If you come from bash you might have to change your $PATH.
export PATH=$PATH:/home/npr/.local/bin
export PATH=$PATH:/home/npr/go/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/.pyenv/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

HYPHEN_INSENSITIVE="true"
DISABLE_UPDATE_PROMPT="true"

# Python
export PYTHONDONTWRITEBYTECODE=1
export PIPENV_VENV_IN_PROJECT=1
eval "$(pyenv virtualenv-init -)"

# Node
export PATH="$PATH:${HOME}/.npm-packages/bin"
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

eval "$(zoxide init zsh)"

sources=(
    "isec"
    "aliases"
)

for s in "${sources[@]}"; do
  source $HOME/.config/zsh/include/${s}.zsh
done
