# XDG Paths
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# Go config
export GOPATH=$HOME/Go
export GOBIN=$GOPATH/bin

# ZSH config
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters
export HISTFILE=$XDG_DATA_HOME/zsh/history_$$

# Vim config
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'

# Path
export PATH=$GOBIN:$HOME/.local/bin:/usr/local/bin:$PATH
