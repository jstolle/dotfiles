fpath=(/usr/local/share/zsh-completions /usr/local/share/zsh/site-functions "${fpath[@]}")

# Path to your oh-my-zsh installation.
export ZSH=$XDG_CONFIG_HOME/oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="bullet-train"

HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$XDG_CONFIG_HOME/zsh/custom

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git terraform aws tmux jst-tmux)

source $ZSH/oh-my-zsh.sh

# User configuration


# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#     export EDITOR='nvim'
# else
#     ## Default text editor
#     ## 'em' is a custom wrapper for emacsclient. See '.bin/em'.
#     ## VISUAL is given priority by some programs like Mutt. This way we can separate
#     ## editors that wait from those that don't.
#     for i in emacsclient em emacs nvim vim vi nano; do
#         command -v $i >/dev/null 2>&1 && export EDITOR=$i && break
#     done
# fi

# Pyenv
eval "$(pyenv init -)"

# Autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# NVM
[ -s /usr/local/opt/nvm/nvm.sh ] && . /usr/local/opt/nvm/nvm.sh 

## Completions
# AWS
completer=$(whence aws_zsh_completer.sh)
[ -n "${completer}" ] && . "${completer}"

# Git Flow
[ -f /usr/local/share/zsh/site-functions/git-flow-completion.zsh ] && . /usr/local/share/zsh/site-functions/git-flow-completion.zsh

alias vim=nvim

# Syntax highlighting
highlights="/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[ -f $highlights ] && . $highlights
