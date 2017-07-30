
# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

    # Check for Homebrew,
    # Install if we don't have it
    if test !$(which brew); then
        echo "Installing homebrew..."
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    if test !$(which brew); then
	echo "Installing oh-my-zsh..."
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    fi

    # Make sure we’re using the latest Homebrew.
    brew update

    # Upgrade any already-installed formulae.
    brew upgrade --all

    # Install GNU core utilities (those that come with OS X are outdated).
    # Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
    brew install coreutils
    sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum


    # Install some other useful utilities like `sponge`.
    brew install moreutils
    # Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
    brew install findutils
    # Install GNU `sed`, overwriting the built-in `sed`.
    brew install gnu-sed --with-default-names
    # Install Bash 4.
    brew install bash
    brew tap homebrew/versions
    brew install bash-completion2
    # We installed the new shell, now we have to activate it
    echo "Adding the newly installed shell to the list of allowed shells"
    # Prompts for password
    sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
    # Change to the new shell, prompts for password
    chsh -s /usr/local/bin/bash

    # Install more recent versions of some OS X tools.
    brew install zsh
    brew install vim --override-system-vi
    brew install homebrew/dupes/grep
    brew install homebrew/dupes/openssh
    brew install homebrew/dupes/screen
    # cli tools
    brew install tree
    brew install the_silver_searcher
    brew install fzf
    # install Neovim
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    brew tap neovim/neovim
    brew install --HEAD neovim
    brew install ctags

    # download python
    # Install Python
    brew install python
    brew install python3

    # Install other useful binaries.
    brew install git
    brew install git-lfs
    brew install git-flow
    brew install git-extras
    brew install ssh-copy-id

    brew install libxml2
    brew install libxslt
    brew link libxml2 --force
    brew link libxslt --force

    # frontend tools
    brew install node

    # database
    brew install postgresql

    # Install Cask
    echo "Installing Applications"
    brew install caskroom/cask/brew-cask

    brew cask install --appdir="/Applications" vagrant
    brew cask install --appdir="/Applications" slack
    brew cask install --appdir="/Applications" virtualbox
    brew cask install --appdir="/Applications" visual-studio-code
    brew cask install --appdir="/Applications" iterm2
    brew cask install --appdir="/Applications" 1password
    brew cask install --appdir="/Applications" google-chrome
    brew cask install --appdir="/Applications" evernote
    brew cask install --appdir="/Applications" spectacle #panes for mac

    # Install developer friendly quick look plugins; see
    # https://github.com/sindresorhus/quick-look-plugins
    brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package
    brew cask install caskroom/fonts/font-hack

    # install fun
    brew install ponysay
    brew install cmatrix

    brew cleanup

    sudo pip install gsutil
    sudo pip install ansible