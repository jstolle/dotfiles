fpath=(/usr/local/share/zsh-completions $fpath)

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
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    ## Default text editor
    ## 'em' is a custom wrapper for emacsclient. See '.bin/em'.
    ## VISUAL is given priority by some programs like Mutt. This way we can separate
    ## editors that wait from those that don't.
    for i in emacsclient em emacs vim vi nano; do
	command -v $i >/dev/null 2>&1 && export EDITOR=$i && break
    done
fi

GIT_EDITOR="$EDITOR"
VISUAL="$EDITOR"
[ "$GIT_EDITOR" = em ] && GIT_EDITOR=emc
[ "$VISUAL" = em ] && VISUAL=emw
export GIT_EDITOR
export VISUAL

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"
