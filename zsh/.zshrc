export SHELL=/bin/zsh
export EDITOR='nvim'

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_COLLATE=C

export HISTSIZE=100000000
export SAVEHIST=$HISTSIZE
export HISTFILE=$HOME/.zsh_history

# Plugins
ZGENOM_HOME="$HOME/.zgenom"
ZGENOM="$ZGENOM_HOME/zgenom.zsh"
if [[ ! -f "$ZGENOM" ]]; then
    echo "Downloading zgenom..."
    git clone https://github.com/jandamm/zgenom.git "${ZGENOM_HOME}"
fi
source "${ZGENOM}"

zgenom autoupdate

# if the init script doesn't exist
if ! zgenom saved; then

  # specify plugins here
  zgenom ohmyzsh

  zgenom ohmyzsh plugins/aliases
  zgenom ohmyzsh plugins/command-not-found
  zgenom ohmyzsh plugins/docker
  zgenom ohmyzsh plugins/docker-compose
  zgenom ohmyzsh plugins/git
  zgenom ohmyzsh plugins/zsh-autosuggestions

  zgenom load zsh-users/zsh-syntax-highlighting

  # generate the init script from plugins above
  zgenom save
fi

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


#compdef temporal
_cli_zsh_autocomplete() {
  local -a opts
  local cur
  cur=${words[-1]}
  if [[ "$cur" == "-"* ]]; then
    opts=("${(@f)$(_CLI_ZSH_AUTOCOMPLETE_HACK=1 ${words[@]:0:#words[@]-1} ${cur} --generate-bash-completion)}")
  else
    opts=("${(@f)$(_CLI_ZSH_AUTOCOMPLETE_HACK=1 ${words[@]:0:#words[@]-1} --generate-bash-completion)}")
  fi
  if [[ "${opts[1]}" != "" ]]; then
    _describe 'values' opts
  else
    _files
  fi
  return
}
compdef _cli_zsh_autocomplete temporal
