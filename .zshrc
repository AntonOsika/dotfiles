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



# Added by the sourabhbajaj.com tutorial:
# Add env.sh
# source ~/Projects/config/env.sh

export PATH="/usr/local/bin:/usr/local/python:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"
# needed by macbook air for brew python:
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
# broke python3: export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"
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

alias g=git
alias pc='open -a /Applications/PyCharm\ CE.app'
alias ct='ctags -R .'

function tb() { tensorboard --logdir "$1" --host=localhost }

# if has('nvim')
#     alias vim=nvim
# endif

if test $(which nvim); then
    alias vim=nvim
fi


# Added by jeromedalbert.com:

export LSCOLORS="exfxcxdxbxegedabagacad"

alias ll="ls -lh"
alias la="ls -A"


# Add shell integration for iterm2
# source ~/.iterm2_shell_integration.`basename $SHELL`
# if [ -f '/Users/anton/.iterm2_shell_integration.'`basename $SHELL` ]; then source '/Users/anton/.iterm2_shell_integration.'`basename $SHELL`; fi
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/anton/Downloads/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/anton/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/anton/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/anton/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# source fzf:
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
