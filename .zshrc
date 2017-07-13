#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Set key repeat on os x :
# defaults write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
# defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)



# Added by the sourabhbajaj.com tutorial:
# Add env.sh
# source ~/Projects/config/env.sh

export PATH="/usr/local/python:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export PYTHONPATH=$PYTHONPATH
export MANPATH="/usr/local/man:$MANPATH"

# Find functions
function f() { find . -iname "*$1*" ${@:2} }
function fr() { grep "$1" ${@:2} -R . }

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vimr'
fi


alias up="git pull --rebase"
alias vim=nvim
alias pc='open -a /Applications/PyCharm\ CE.app'


# Added by jeromedalbert.com:

export LSCOLORS="exfxcxdxbxegedabagacad"

alias ll="ls -lh"
alias la="ls -A"


expand-or-complete-with-dots() {      # This bunch of code displays red dots when autocompleting
  echo -n "\e[31m......\e[0m"         # a command with the tab key, "Oh-my-zsh"-style.
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots



# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/anton/Downloads/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/anton/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/anton/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/anton/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
