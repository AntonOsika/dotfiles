#
# Executes commands at the start of an interactive session.
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

  # Avoid double virtualenv names on linux
  if [[ ! "$OSTYPE" == "darwin"* ]]; then
    export VIRTUAL_ENV_DISABLE_PROMPT=true
  fi
fi

# Source locals
if [[ -s "$HOME/.localrc" ]]; then
  source "$HOME/.localrc"
fi

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export MANPATH="/usr/local/man:$MANPATH"

export EDITOR='vim'
if test $(which nvim); then
  alias vim=nvim
  alias vimdiff='nvim -d'

  # Preferred editor for local and remote sessions
  if [[ $SSH_CONNECTION ]]; then
    export EDITOR='nvim'
  fi
fi

# Style by jeromedalbert.com:

export LSCOLORS="exfxcxdxbxegedabagacad"

# activates fzf, use **<TAB> (or e.g. kill -9 <TAB>) to start searching:
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export WORKON_HOME=~/.ve
export PROJECT_HOME=~/coding

# Pyenv guide from: https://medium.com/@henriquebastos/the-definitive-guide-to-setup-my-python-workspace-628d68552e14
# eval "$(pyenv init -)"
# pyenv virtualenvwrapper_lazy

export GOPATH=~/go

export PATH="$GOPATH/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
  # zsh autocomplete can be enabled, but typically slow
if [ -f '$HOME/google-cloud-sdk/path.zsh.inc' ]; then source '$HOME/google-cloud-sdk/path.zsh.inc'; fi

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

# Ipython in virtualenv
alias ipy="python -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"


alias c="g++ -Wall -Wconversion -Wfatal-errors -g -std=c++14 -fsanitize=undefined,address"

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

# Find functions
function f() { find . -iname "*$1*" ${@:2} }
function fr() { grep "$1" ${@:2} -R . }

# Kill process listening on port
function killport { pid=$(lsof -i:"$1" -t); kill -TERM $pid || kill -KILL $pid }

# Get manual of builtin commands
function bashman { man bash | less -p "^       $1 "; }

alias g=git
alias gl='g l'
alias gs='g s'
alias gd='g d'

# push to remote branch
gp() { git push origin HEAD:refs/heads/$1 $2 }


# Creating tags for vim
alias ct='ctags -R .'

# TTS pasted content 500 wpm
alias sp='say -r 500 -- "$(pbp)"'

function tb() { tensorboard --logdir "$1" --host=localhost }

alias ipy="python -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"

alias ll="ls -lh"
alias la="ls -A"

alias nofzf="export FZF_CTRL_R_OPTS='--exact'"

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

alias c1='g++ -Wall -Wconversion -Wfatal-errors -g -std=c++14 -fsanitize=undefined,address'
alias c2='g++ -Wall -g -std=c++14 -O2'

kt() {
  DEST="/tmp/$(basename $1).jar"
  kotlinc $1 -include-runtime -d $DEST
  eval java -jar $DEST $2
}

ktp() {
  DEST="/tmp/$(basename $1).jar"
  kotlinc $1 -include-runtime -d $DEST
  eval java -jar $DEST < $2
}

if [[ ! "$OSTYPE" == "darwin"* ]]; then
  alias nf='notify-send "Done."'
else
  # banner is commented out:
  alias nf="afplay /System/Library/Sounds/Ping.aiff -v 2 && osascript -e $'display notification \'Job done\' with title \'Done\''"
fi


if [[ ! "$OSTYPE" == "darwin"* ]]; then
  gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 11
  gsettings set org.gnome.desktop.peripherals.keyboard delay 200

  alias go='/usr/lib/go-1.12/bin/go'
  alias idea='intellij-idea-ultimate'
  alias open=xdg-open

  # swap alt win for using mac keyboard:
  alias mk='noglob gsettings set org.gnome.desktop.input-sources xkb-options [\"caps:escape\",\"altwin:swap_lalt_lwin\",\"compose:sclk\"]'
  alias tk='noglob gsettings set org.gnome.desktop.input-sources xkb-options [\"caps:escape\",\"compose:sclk\"]'
fi


# Mac specific stuff moved from .localrc
if [[ "$OSTYPE" == "darwin"* ]]; then
  alias python=python3
  alias pip=pip3
  # gsutil -m didnt support python 3.8 
  export CLOUDSDK_PYTHON=/usr/local/opt/python@3.7/bin/python3
  # export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
  # Disable fork security feature for python multiprocessing
  export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
fi


if [[ ! "$OSTYPE" == "darwin"* ]]; then
  alias ss='systemctl suspend'
  alias hn='sudo systemctl hibernate'

  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

  alias togglecaps=xdotool key Caps_Lock
  # See time when command was executed, included in iterm2
  PROMPT='%{$fg[yellow]%}%D{%T} '$PROMPT
fi

[[ -f /usr/bin/kubectl ]] && source <(kubectl completion zsh)

# Used for e.g.  `npm config set prefix ~/.local`
PATH=~/.local/bin/:$PATH  

# Parallell docker build
# export DOCKER_BUILDKIT=1

# eval "$(direnv hook zsh)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
export DEPICT_ROOT=~/depict.ai
source ~/depict.ai/depict.rc
