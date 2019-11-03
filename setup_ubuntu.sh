
# Repeat speed
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 11
gsettings set org.gnome.desktop.peripherals.keyboard delay 200

# ctrl tab in terminal
# (this might have broken fn backspace functionality?)
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ next-tab '<Primary>Tab'
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ prev-tab '<Primary><Shift>Tab'

# Tweak tool for caps esc remap, compose key (shift + " + a -> ae)
sudo apt install -y gnome-tweak-tool

# Necessities
sudo apt-get install -y \
    build-essential \
    curl \
    libssl-dev \
    git \ 
    docker.io \
    tmux \
    silversearcher-ag

# Install google chrome!

# Neovim
sudo apt-get install -y software-properties-common
# sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install -y neovim
sudo apt-get install -y \
	vim-python-jedi \ 
	pylint

sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir $HOME/config
mkdir $HOME/config/nvim
ln -sv $HOME/.vimrc $HOME/config/nvim/init.vim
# then run :PlugInstall from neovim

sudo apt-get install exuberant-ctags


# Utils
sudo apt install -y copyq
sudo apt install -y anki
sudo apt-get install -y xsel

# Python
sudo apt-get install python3-dev python3-pip python-dev python-pip 
sudo apt-get install python3-distutils
sudo apt-get install -y python3-virtualenv
sudo pip3 install virtualenvwrapper
sudo pip3 install black yapf
sudo pip3 install ipython jupyterlab


# zsh
sudo apt-get update && sudo apt-get -y install zsh
chsh -s $(which zsh)

# snap
sudo apt install snapd
snap install intellij-idea-ultimate --classic

# Git credentials
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=604800'  # = 1 week

# Java
sudo apt install openjdk-8-jdk

# Gcloud
# Add the Cloud SDK distribution URI as a package source
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
# Import the Google Cloud Platform public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
# Update the package list and install the Cloud SDK
sudo apt-get update && sudo apt-get install google-cloud-sdk

# AWS
sudo apt-get install awscli

# Create swap file 
# (https://linuxize.com/post/how-to-add-swap-space-on-ubuntu-18-04/)
# sudo fallocate -l 16G /swapfile
# sudo chmod 600 /swapfile
# sudo mkswap /swapfile
# sudo swapon /swapfile
# sudo bash -c "echo '/swapfile swap swap defaults 0 0' >> /etc/fstab"
# sudo swapon --show

# Minimal swapiness recommended
# sysctl vm.swappiness=1

# Hibernate after 10 minutes
# Might be this that forces me to restart on plugging out display:
# echo "[Sleep]
# HibernateDelaySec=600" >> /etc/systemd/sleep.conf

# zram, takes battery (compression) ...

# power management
# sudo apt install powertop
# sudo apt install pm-utils  # pm-powersave true
# sudo apt install tlp tlp-rdw  # tlp start, tlp fullcharge
# Used gui to setup thinkpad battery policy

# Shift + scroll = horizontal
sudo apt install xbindkeys xautomation
echo "; bind shift + vertical scroll to horizontal scroll events\
  (xbindkey '(shift \"b:4\") \"xte 'mouseclick 6'\")\
  (xbindkey '(shift \"b:5\") \"xte 'mouseclick 7'\")" >> .xbindkeysrc.scm


# sudo apt-get install konsole
# sudo update-alternatives --config x-terminal-emulator  # -> Select default
# sudo apt-get install autokey
# sudo apt-get install festival
