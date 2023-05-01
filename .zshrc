# BELOW IS OHMYZSH

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-z)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# ABOVE IS FROM OHMYZSH

#
# Executes commands at the start of an interactive session.
#

# Source Prezto. Now using oh my zsh.
# if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
#   source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
# 
#   # Avoid double virtualenv names on linux
#   if [[ ! "$OSTYPE" == "darwin"* ]]; then
#     export VIRTUAL_ENV_DISABLE_PROMPT=true
#   fi
# fi

alias docker=podman

# ctrl n/p = downarrow/uparrow
bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

# Source locals
if [[ -s "$HOME/.localrc" ]]; then
  source "$HOME/.localrc"
fi

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export MANPATH="/usr/local/man:$MANPATH"

export EDITOR='vim'
if [[ $(which nvim) ]]; then
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


alias gcc="g++ -Wall -Wconversion -Wfatal-errors -g -std=c++14 -fsanitize=undefined,address"

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
function gp() { set -ex; git push origin HEAD:$1 }


# Creating tags for vim
alias ct='ctags -R .'

# TTS pasted content 500 wpm
alias sp='pbpaste | say -r 500'

function tb() { tensorboard --logdir "$1" --host=localhost }

alias ipy="python -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"

alias ll="ls -lh"
alias la="ls -A"

alias nofzf="export FZF_CTRL_R_OPTS='--exact'"

# Kaggle submit
function ksub() {
  C=`basename $(pwd)`
  S="$(pwd)/submission.csv" 
  kaggle competitions submit -c $C -f $S -m $1
}

function kscore() {
  C=`basename $(pwd)`
  kaggle competitions submissions -c $C
}

# Edit and source dotfiles
function ezh() {
  vim ~/.zshrc
}

function szh() {
  source ~/.zshrc
}

alias c1='g++ -Wall -Wconversion -Wfatal-errors -g -std=c++14 -fsanitize=undefined,address'
alias c2='g++ -Wall -g -std=c++14 -O2'

function kt() {
  DEST="/tmp/$(basename $1).jar"
  kotlinc $1 -include-runtime -d $DEST
  eval java -jar $DEST $2
}

function ktp() {
  DEST="/tmp/$(basename $1).jar"
  kotlinc $1 -include-runtime -d $DEST
  eval java -jar $DEST < $2
}

if [[ ! "$OSTYPE" == "darwin"* ]]; then
  alias nf='notify-send "Done."'

  # Use gnu sed on mac
  PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
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

alias pw="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"


# Mac specific stuff moved from .localrc
if [[ "$OSTYPE" == "darwin"* ]]; then
  # gsutil -m didnt support python 3.8 
  # export CLOUDSDK_PYTHON=/usr/local/opt/python@3.7/bin/python3
  # export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
  # Disable fork security feature for python multiprocessing
  export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

  source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
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
export DEPICT_ROOT=~/code/depict.ai
source ${DEPICT_ROOT}/depict.rc
export PATH=/opt/homebrew/bin:$PATH

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<



# JINA_CLI_BEGIN

## autocomplete
if [[ ! -o interactive ]]; then
    return
fi

compctl -K _jina jina

_jina() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(jina commands)"
  else
    completions="$(jina completions ${words[2,-2]})"
  fi

  reply=(${(ps:
:)completions})
}

# session-wise fix
ulimit -n 4096
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# JINA_CLI_END

DBT_PROFILES_DIR=~/.dbt

