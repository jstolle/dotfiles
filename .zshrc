# Leave if not interactive
[[ $- != *i* ]] && return

# Pretty colors
autoload -U colors && colors

# History
export HISTSIZE=1000000
export HISTFILE=$XDG_DATA_HOME/zsh/history_$$
export HIST_STAMPS="yyyy-mm-dd"

# Tab completion
autoload -U compinit
zstyle ':completion:*' menu select
# Auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

#zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Syntax highlighting
if [ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# emacs mode
bindkey -e

# Command line editing
autoload -z edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# Search history
#bindkey '^R' history-incremental-pattern-search-backward

# Source configs
for conf in $HOME/.config/shellconfig/*.zsh; do source "$conf" ; done

SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  exec_time     # Execution time
  line_sep      # Line break
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_RPROMPT_ORDER=(
  docker        # Docker section
  aws           # Amazon Web Services section
  pyenv         # Pyenv section
  terraform     # Terraform workspace section
  golang        # Go section
  node          # Node.js section
)
SPACESHIP_AWS_SHOW=true
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_CHAR_SYMBOL=❯
SPACESHIP_CONDA_SHOW=false
SPACESHIP_DOCKER_CONTEXT_SHOW=true
SPACESHIP_DOCKER_SHOW=true
SPACESHIP_DOTNET_SHOW=false
SPACESHIP_ELIXIR_SHOW=false
SPACESHIP_ELM_SHOW=false
SPACESHIP_EMBER_SHOW=false
SPACESHIP_GOLANG_SHOW=true
SPACESHIP_HG_SHOW=false
SPACESHIP_JOBS_SHOW=false
SPACESHIP_JULIA_SHOW=false
SPACESHIP_KUBECONTEXT_SHOW=false
SPACESHIP_NODE_SHOW=true
SPACESHIP_PACKAGE_SHOW=true
SPACESHIP_PHP_SHOW=false
SPACESHIP_PROMPT_ADD_NEWLINE=true
SPACESHIP_PROMPT_SEPARATE_LINE=true
SPACESHIP_PYENV_SHOW=true
SPACESHIP_RUBY_SHOW=false
SPACESHIP_RUST_SHOW=false
SPACESHIP_SWIFT_SHOW_LOCAL=false
SPACESHIP_TERRAFORM_SHOW=true
SPACESHIP_USER_SHOW=always
SPACESHIP_VENV_SHOW=false
SPACESHIP_VI_MODE_SHOW=false
SPACESHIP_XCODE_SHOW_LOCAL=false

autoload -U promptinit; promptinit
prompt spaceship

set -o emacs

# Random password generator
function genpass () {
  for word in $($HOME/bin//diceware 5); do
    firstletter=$(echo $word | cut -c1 | gtr '[:lower:]' '[:upper:]')
    otherletters=$(echo $word | cut -c2-)
    echo -n "$firstletter$otherletters"
  done | gtr 'i' '1' | gtr 'a' '@' | gtr 'o' '0'
  echo ""
}

gpg2 --homedir "$GNUPSHOME"

