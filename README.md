# Antons dotfiles

setup.sh will symlink files from home folder to dotfiles in this repo, if they are in ~/dotfiles.

macos.macos needs to be sourced separately.

Neovim is assumed and alias `vim=nvim` is set.

prezto is assumed, but will use the submodule of this directory in the future.

there are some nice gitconfig aliases

## Updating things

Prezto: 

```bash
cd prezto
git pull --rebase 
```
or interactively and secure:
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

## Reinstall brew

From [http://zanshin.net/2012/07/31/uninstalling-brew-to-re-install-brew/].

```bash
cd `brew --prefix`
rm -rf Cellar
brew prune
rm -rf Library .git .gitignore bin/brew README.md share/man/man1/brew
rm -rf ~/Library/Caches/Homebrew
```

## Todo
- fix macosdefaults.sh from running when answer is no (test bash behaviour)
- vim command to split to zsh terminal
- fix markdown to render as html (as pycharm or vim-compose-markdown when server
is turned off)
- See if I missed any important vim config (eleoijon etc)
- Use personalized sorin theme (or other theme) that is not made for vim, and
does not shorten paths (unless necessary)
