# XDG Paths
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# System type
export MYSYSTYPE=$(uname -s | tr '[:upper:]' '[:lower:]')

# Go config
export GOPATH=$HOME/Go
export GOBIN=$GOPATH/bin

typeset -U PATH path
path=("$HOME/scripts" "$HOME/.local/bin" "$GOBIN" "$path[@]")
export PATH

export EDITOR="nvim"
export GIT_EDITOR="nvim"
export READER="zathura"
export VISUAL="nvim"
export CODEEDITOR="em"
export TERMINAL="alacritty"
export BROWSER="brave"
export COLORTERM="truecolor"
export OPENER="xdg-open"
export PAGER="less"
export WM="bspwm"

#export LESS_TERMCAP_mb=$'\e[1;32m'
#export LESS_TERMCAP_md=$'\e[1;32m'
#export LESS_TERMCAP_me=$'\e[0m'
#export LESS_TERMCAP_so=$'\e[01;33m'
#export LESS_TERMCAP_se=$'\e[0m'
#export LESS_TERMCAP_us=$'\e[1;4;31m'
#export LESS_TERMCAP_ue=$'\e[0m'

# Start blinking
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
# Start bold
export LESS_TERMCAP_md=$(tput bold; tput setaf 2) # green
# Start stand out
export LESS_TERMCAP_so=$(tput bold; tput setaf 3) # yellow
# End standout
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
# Start underline
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 1) # red
# End bold, blinking, standout, underline
export LESS_TERMCAP_me=$(tput sgr0)

# Vim config
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'

# Man path
export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

