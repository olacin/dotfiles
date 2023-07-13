export SHELL=/bin/zsh
export EDITOR='nvim'

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export HISTSIZE=100000000
export SAVEHIST=$HISTSIZE
export HISTFILE=$HOME/.zsh_history

# Plugins
ANTIGEN="$HOME/antigen/antigen.zsh"
if [[ ! -f "$ANTIGEN" ]]; then
    echo "Downloading antigen..."
    mkdir -p "$HOME/antigen"
    touch $ANTIGEN
    curl -s -L git.io/antigen -o $ANTIGEN
fi
source $ANTIGEN

antigen use oh-my-zsh

antigen bundle aliases
antigen bundle command-not-found
antigen bundle docker
antigen bundle docker-compose
antigen bundle git
antigen bundle zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle marlonrichert/zsh-autocomplete --branch=main

antigen apply

eval "$(starship init zsh)"

# Path
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/.local/share/nvim/lsp_servers/rust"
export PATH=$PATH:./node_modules/.bin

# Vim mode
bindkey -v
# Switch to command mode with jk
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M vicmd "v" edit-command-line
# Incremental search in insert mode
bindkey "^R" history-incremental-search-backward

# fzf theme
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Bat theme
export BAT_THEME="Catppuccin-mocha"

HYPHEN_INSENSITIVE="true"
DISABLE_UPDATE_PROMPT="true"

# Golang
export GO111MODULE=on

# Node
export PATH="$PATH:${HOME}/.npm-packages/bin"
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

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

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$PATH:/home/npr/.temporalio/bin"

source "$HOME/.asdf/asdf.sh"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

# pnpm
export PNPM_HOME="/home/npr/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end