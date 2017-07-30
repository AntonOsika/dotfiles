# Antons dotfiles

setup.sh will symlink files from home folder to dotfiles in this repo, if they are in ~/dotfiles.

macos.macos needs to be sourced separately.

Neovim is assumed and alias `vim=nvim` is set.

prezto is assumed, but will use the submodule of this directory in the future.

there are some nice gitconfig aliases

## Reinstall brew

From [http://zanshin.net/2012/07/31/uninstalling-brew-to-re-install-brew/].

````$ cd `brew --prefix`
$ rm -rf Cellar
$ brew prune
$ rm -rf Library .git .gitignore bin/brew README.md share/man/man1/brew
$ rm -rf ~/Library/Caches/Homebrew
````

