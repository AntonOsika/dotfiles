# Repeat speed
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 15
gsettings set org.gnome.desktop.peripherals.keyboard delay 250

# Tweak tool for caps esc remap, compose key (shift + " + a -> ae)
sudo apt install gnome-tweak-tool

# Necessities
sudo apt-get install -y \
    build-essential \
    chromium-browser \
    curl \
    libssl-dev \
    git

sudo apt-get install -y python-pip python-dev python-virtualenv
sudo pip install virtualenvwrapper
sudo apt-get install -y tmux

# Neovim
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim

sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir $HOME/config/nvim
ln -sv $HOME/.vimrc $HOME/config/nvim/init.vim
# then run :PlugInstall from neovim

sudo apt-get install exuberant-ctags

# Python
sudo apt-get install python-dev python-pip python3-dev python3-pip

# zsh
sudo apt-get update && sudo apt-get -y install zsh
chsh -s $(which zsh)

# snap
sudo apt install snapd
snap install intellij-idea-ultimate --classic


