#
# Executes commands at the start of an interactive session.
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi



# Added by the sourabhbajaj.com tutorial:
# Add env.sh
# source ~/Projects/config/env.sh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH="/usr/local/bin:/usr/local/python:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"

# needed by macbook air for brew python:
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export MANPATH="/usr/local/man:$MANPATH"
# broke python3: export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"

export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)


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
alias sp='pbp|xargs say -r 500'

function tb() { tensorboard --logdir "$1" --host=localhost }

# bash:
# if has('nvim')
#     alias vim=nvim
# endif

if test $(which nvim); then
    alias vim=nvim
fi

alias ipy="python -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"

# Added by jeromedalbert.com:

export LSCOLORS="exfxcxdxbxegedabagacad"

alias ll="ls -lh"
alias la="ls -A"


# Add shell integration for iterm2
# source ~/.iterm2_shell_integration.`basename $SHELL`
# if [ -f '/Users/anton/.iterm2_shell_integration.'`basename $SHELL` ]; then source '/Users/anton/.iterm2_shell_integration.'`basename $SHELL`; fi
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f ~'/Downloads/google-cloud-sdk/path.zsh.inc' ]; then source ~'/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
# This is too slow:
# if [ -f '/Users/anton/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/anton/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# activates fzf, use **<TAB> (or e.g. kill -9 <TAB>) to start searching:
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias nofzf="export FZF_CTRL_R_OPTS='--exact'"

#Fix python locale error
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

#Pyenv guide from: https://medium.com/@henriquebastos/the-definitive-guide-to-setup-my-python-workspace-628d68552e14
export WORKON_HOME=~/.ve
export PROJECT_HOME=~/coding
eval "$(pyenv init -)"
#pyenv virtualenvwrapper_lazy

export GOPATH=~/go

