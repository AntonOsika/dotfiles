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
if test !$(which brew); then
	echo "Installing homebrew..."
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
# brew upgrade --all

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
#sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum
ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum


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
#brew install the_silver_searcher # like ack but faster (ack codesnippet .)

brew install vim --override-system-vi

# install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
brew tap neovim/neovim
brew install --HEAD neovim

brew install ctags

brew install python
brew install python3

# Install other useful binaries.
brew install git

# large file storage:
#brew install git-lfs

# too many by useful commands, e.g. fork https://github.com/tj/git-extras/blob/master/Commands.md
# brew install git-extras

# very strict aliases for developing with feature branches https://danielkummer.github.io/git-flow-cheatsheet/
brew install git-flow 

#brew install ssh-copy-id

# XML parsers:
#brew install libxml2
#brew install libxslt
#brew link libxml2 --force
#brew link libxslt --force

# frontend tools
brew install node

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

brew cask install --appdir="/Applications" google-chrome
brew cask install --appdir="/Applications" evernote
brew cask install --appdir="/Applications" spectacle #panes for mac
brew cask install --appdir="/Applications" flux
brew cask install --appdir="/Applications" vlc
brew cask install --appdir="/Applications" latexian
#brew cask install --appdir="/Applications" virtualbox
#brew cask install --appdir="/Applications" vagrant

brew cask install caskroom/fonts/font-hack

# pip and setuptools was installed with python, upgrade it:
pip install --upgrade setuptools
pip install --upgrade pip

#from @eleijonmarck:
#pip install gsutil #google cloud
#pip install ansible #automate apps and infrastructure

pip install virtualenv
pip install nose
pip install pyparsing
pip install python-dateutil
pip install pep8


brew tap samueljohn/python
brew tap homebrew/science

brew install gcc 

echo ""
echo "Building numpy and scipy from source with brew..."
brew install numpy
brew install scipy
brew install matplotlib
echo "done."
