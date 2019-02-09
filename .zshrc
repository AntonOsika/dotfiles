#
# Executes commands at the start of an interactive session.
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH="$HOME/anaconda3/bin:/usr/local/bin:/usr/local/python:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"
export PYTHONPATH="$HOME/anaconda3/bin/lib/python3.6/site-packages:$PYTHONPATH"

export MANPATH="/usr/local/man:$MANPATH"

export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

# Find functions
function f() { find . -iname "*$1*" ${@:2} }
function fr() { grep "$1" ${@:2} -R . }

# Kill process listening on port
function killport { pid=$(lsof -i:"$1" -t); kill -TERM $pid || kill -KILL $pid }

# Get manual of builtin commands
function bashman { man bash | less -p "^       $1 "; }

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

alias g=git
alias pc='open -a /Applications/PyCharm\ CE.app'

# Creating tags for vim
alias ct='ctags -R .'

# TTS pasted content 500 wpm
alias sp='pbp|xargs say -r 500 --'

function tb() { tensorboard --logdir "$1" --host=localhost }

if test $(which nvim); then
  alias vim=nvim
  alias vimdiff='nvim -d'
fi

alias ipy="python -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"

# Style by jeromedalbert.com:

export LSCOLORS="exfxcxdxbxegedabagacad"

alias ll="ls -lh"
alias la="ls -A"

# activates fzf, use **<TAB> (or e.g. kill -9 <TAB>) to start searching:
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias nofzf="export FZF_CTRL_R_OPTS='--exact'"

#Fix python locale error
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export WORKON_HOME=~/.ve
export PROJECT_HOME=~/coding

# Pyenv guide from: https://medium.com/@henriquebastos/the-definitive-guide-to-setup-my-python-workspace-628d68552e14
# eval "$(pyenv init -)"
# pyenv virtualenvwrapper_lazy

export GOPATH=~/go

export PATH="$GOPATH/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/anton/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/anton/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud. Too slow to be practical
# if [ -f '/Users/anton/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/anton/google-cloud-sdk/completion.zsh.inc'; fi

# Matplotlib fix for virtualenvs:
function frameworkpython {
    if [[ ! -z "$VIRTUAL_ENV" ]]; then
        PYTHONHOME=$VIRTUAL_ENV /usr/local/opt/python/libexec/bin/python "$@"
    else
        /usr/local/opt/python/libexec/bin/python "$@"
    fi
}
function frameworkipython {
    if [[ ! -z "$VIRTUAL_ENV" ]]; then
        PYTHONHOME=$VIRTUAL_ENV /usr/local/bin/ipython "$@"
    else
        /usr/local/bin/ipython "$@"
    fi
}

alias ipy="python -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"

# Adds conda to current path:
# (the alternative that works is adding conda to path and using it like they suggest)

# function path_contains() {
#   [[ ":$PATH:" == *":$1:"* ]]
# }

# function remove_from_path() {
#   local remove="$1"
#   readonly remove
#   local work=:$PATH:
#   work=${work/:$remove:/:}
#   work=${work#:}
#   work=${work%:}
#   export PATH=$work
# }

# function prepend_path() {
#   path_contains "$1" || export PATH="$1${PATH:+":$PATH"}"
# }

# function condify() {
#   prepend_path "$HOME/anaconda3/bin"
# }

# function decondify() {
#   remove_from_path "$HOME/anaconda3/bin"
# }

. $HOME/anaconda3/etc/profile.d/conda.sh

# Kaggle submit
ksub() {
  C=`basename $(pwd)`
  S="$(pwd)/submission.csv" 
  kaggle competitions submit -c $C -f $S -m $1
}

kscore() {
  C=`basename $(pwd)`
  kaggle competitions submissions -c $C
}

# Edit and source dotfiles
ezh() {
  vim ~/.zshrc
}

szh() {
  source ~/.zshrc
}
