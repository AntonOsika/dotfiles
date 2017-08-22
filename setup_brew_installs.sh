echo ""
echo "Have you read through the script you're about to run and " $red
echo "understood that it will make changes to your computer? (y/n)" $red
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  CONTINUE=true
fi

if ! $CONTINUE; then
  # Check if we're continuing and output a message if not
  echo "Please go read the script, it only takes a few minutes" $red
  exit
fi

# Check for Homebrew,
# Install if we don't have it
if test $(which brew); then
	echo "Installing homebrew..."
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "brew doctor"
brew doctor

echo "do you want to continue?"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  CONTINUE=true
fi

if ! $CONTINUE; then
  # Check if we're continuing and output a message if not
  echo "skipping more installs, please brew health and fix with brew doctor" $red
  exit
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
# brew upgrade --all

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
#sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Need to back this up before uncommenting:
#ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum


# Install some other useful utilities like `vidir` (https://joeyh.name/code/moreutils/)
brew install moreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils

# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names


brew install zsh 
brew install zsh-completions

echo "" 
echo "Setting zsh as default shell"
chsh -s /usr/local/bin/zsh

# cli tools
brew install tree
brew install fzf
brew install the_silver_searcher # like ack but faster (ack codesnippet .)

# Install git
brew install git

brew install git-flow 		# very strict aliases for developing with feature branches https://danielkummer.github.io/git-flow-cheatsheet/
# brew install git-lfs 		# large file storage
# brew install git-extras 	# too many (useful) commands, e.g. 'git fork', https://github.com/tj/git-extras/blob/master/Commands.md
# brew install ssh-copy-id

brew install vim --override-system-vi

# install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
brew tap neovim/neovim
brew install neovim

brew install ctags

# XML parsers:
#brew install libxml2
#brew install libxslt
#brew link libxml2 --force
#brew link libxslt --force

# frontend tools
brew install node
brew install rust

# database
brew install postgresql

# Install Cask
echo "Installing Applications"

# Install quick look plugins for developers; see
# https://github.com/sindresorhus/quick-look-plugins
brew cask install qlimagesize 
brew cask install qlcolorcode
brew cask install qlstephen
brew cask install qlmarkdown
brew cask install quicklook-json
brew cask install qlprettypatch
brew cask install quicklook-csv
brew cask install betterzipql
brew cask install webpquicklook
brew cask install suspicious-package

brew cask install --appdir="/Applications" iterm2
brew cask install --appdir="/Applications" google-chrome
brew cask install --appdir="/Applications" evernote
brew cask install --appdir="/Applications" spectacle #panes for mac
brew cask install --appdir="/Applications" flux
brew cask install --appdir="/Applications" vlc
brew cask install --appdir="/Applications" latexian         # ?
brew cask install --appdir="/Applications" anki
brew cask install --appdir="/Applications" spotify
brew cask install --appdir="/Applications" vimr
brew cask install --appdir="/Applications" disk-inventory-x
brew cask install --appdir="/Applications" MacDown          # markdown
#brew cask install --appdir="/Applications" virtualbox
#brew cask install --appdir="/Applications" vagrant

brew cask install caskroom/fonts/font-hack
brew cask install caskroom/fonts/font-source-code-pro

echo "installing python with brew, should end up in /usr/local/bin/python."
brew install python
brew install python3

echo "python and pip ended up in:"
which python
which pip

echo "do you want to continue? You can use pyenv instead (recommended) to manage python installations."

read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  CONTINUE=true
fi

if ! $CONTINUE; then
  # Check if we're continuing and output a message if not
  echo "skipping further python installs, might be good to brew uninstall python and use pyenv (and brew doctor)" $red
  exit
fi

# brew install pyenv

# pip and setuptools was installed with python, upgrade it:
pip install --upgrade setuptools
pip install --upgrade pip

pip install --upgrade vim
pip install --upgrade neovim

#from @eleijonmarck:
#pip install gsutil #google cloud
#pip install ansible #automate apps and infrastructure

# Installing Qt4 for matplotlib
brew tap cartr/qt4
brew tap-pin cartr/qt4
brew install qt
brew install pyside


pip install virtualenv
pip install nose
pip install pyparsing
pip install python-dateutil
pip install pep8

pip install notedown

brew tap samueljohn/python
brew tap homebrew/science

brew install gcc 

echo ""
echo "Building numpy and scipy from source with brew..."
brew install numpy
brew install scipy
brew install matplotlib
echo "done."
