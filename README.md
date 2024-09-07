# Anton dotfiles

This repo contains:
- macos setup scripts
- .vimrc
- .zshrc
- prezto (zsh setup) fork, as submodule
- gitconfig aliases
- iterm preferences
- (deprecated files for windows etc)

## Installation

- `setup_symlinks.sh` will create symbolic links in home folder targeting dotfiles in ~/dotfiles
- `setup_brew_installs.sh` installs useful apps with brew and pip
- `macosdefaults.sh` confiugres mac

To change shell to `zsh` use: 
   
    chsh -s /usr/local/bin/zsh

This repo needs to be cloned recursively (or run `git submodule init; git submodule update`) to get prezto for zsh.

Iterm2 needs to manually be set to sync with this folder to use the settings.

Note that `.zsh` will set `vim=nvim` if it exists.

### Manual steps

- If using alfred 3 you need to point the config file to the dotfiles directory.

## Updating things

Prezto: 

```bash
cd prezto
git pull --rebase 
```
or interactively (for security reasons):
```bash
git pull --no-commit --strategy=recursive -X ours upstream master
git add --patch
```

Brew and pip:
```bash
brew outdated
brew upgrade --all
```

```bash
pip list --outdated
pip install --upgrade pip
```

## Manual installations
Useful things that are not installed with these scripts.

### Browser extensions
- uBlock
- Pocket
- The Great Discarder

### Useful mac apps
- Alfred 3, with snippets for math utf8 characters.
- (copyq or Alfred PowerPack), clipboard history
- Rescue Time
- Context for switching between windows in one app
- Notion
