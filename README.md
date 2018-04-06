# Anton dotfiles

This repo contains:
- macos setup scripts
- .vimrc
- .zshrc
- prezto (zsh setup) fork, as submodule
- gitconfig aliases
- iterm preferences

## Installation

setup.sh will create symbolic links in home folder targeting dotfiles in ~/dotfiles.

macos.macos confiugres mac and needs to be sourced separately.

Alias `vim=nvim` is set if possible.

This repo needs to be cloned recursively (our run `git submodule init; git submodule update`) to get prezto for zsh.

Iterm2 needs to manually be set to sync with this folder to use the settings.

## Updating things

Prezto: 

```bash
cd prezto
git pull --rebase 
```
or interactively to be safe:
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

### Browser extensions
- uBlock
- Pocket
- Evernote
- Snipe (search browser tabs with cmd+`)
- WasteNoTime
- Grammarly

### Useful mac apps
- Clipy
- Mendeley
- Rescue Time
- translate shell [github](https://github.com/soimort/translate-shell)
