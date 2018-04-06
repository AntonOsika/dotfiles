
#### Reinstall brew

From [http://zanshin.net/2012/07/31/uninstalling-brew-to-re-install-brew/].

```bash
cd `brew --prefix`
rm -rf Cellar
brew prune
rm -rf Library .git .gitignore bin/brew README.md share/man/man1/brew
rm -rf ~/Library/Caches/Homebrew
```
