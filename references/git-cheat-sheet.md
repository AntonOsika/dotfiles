# Git Cheat Sheet

Although there are enough resources on the web about Git, I will keep this one for my own reference. Minimal Git version required 1.7.2.

## <a id="toc"></a>TOC

  * [Info](#info)
  * [Adding](#adding)
  * [Branching](#branching)
  * [Patching](#patching)
  * [Undoing](#undoing)
  * [Remotes](#remotes)
  * [Subtree](#subtree)
  * [Submodules](#submodules)
  * [Additional resources](#additional-resources)

----

### Legend

 - **index**: staging area (Imagine you are loading sand into the truck with bucket. Well, the bucket is like *index* and truck like a repository :)
 - **\<sha1\>**: sha1 hash of commit
 - **\<file\>**: path to the file (path/to/file.ext)
 - **\<branch\>**: branch name
 - **\<repository\>**: remote repository name

----

### <a id="info"></a>Info

#### Search the history for a change matching a pattern

    git log -G <regex> -- <path>
    git log -S <string> -- <path>

Useful options:

    -i, --regexp-ignore-case
        Match the regular expression limiting patterns without regard to letter case.

    -E, --extended-regexp
        Consider the limiting patterns to be extended regular expressions instead of the default basic regular expressions.

    -F, --fixed-strings
        Consider the limiting patterns to be fixed strings (don't interpret pattern as a regular expression).

    --perl-regexp
        Consider the limiting patterns to be Perl-compatible regular expressions. Requires libpcre to be compiled in.

#### Find commits where files were deleted

    git log --diff-filter=D --summary

#### Checkout deleted file in the working tree

    git checkout <sha1>^ <file>

#### Checkout a file from another branch into the working tree

    git checkout <branch> -- <file>

#### Only show the content of a file from a specific revision

    git show <sha1>^:<file>

#### Show diff between branches detecting renames

     git diff -M <branch>

#### Show file's history

    git log -p <file>

#### Show changes on a branch that is not merged upstream

    git cherry -v <upstream_branch> <new_branch>
    git log <upstream_branch>..<new_branch>

#### Show log with changed files

    git log --name-only
    git log --name-status
    git log --stat

#### Get latest tag in the current branch

    git describe --exact-match --abbrev=0
    git describe --abbrev=0 --tags

#### Find out if a change is part of a release

    git name-rev --name-only <sha1>

#### Find out which branch contains a change

    git branch --contains <sha1>

[TOC](#toc)


### <a id="adding"></a>Adding

#### Add changes to the index chunk by chunk

    git add --patch <file>

  * **y**: stage this chunk
  * **n**: do not stage this chunk
  * **s**: split this chunk into smaller chunks
  * **e**: edit this chunk

[TOC](#toc)


### <a id="branching"></a>Branching

####  Create local branch

If not provided, Git uses `HEAD` as the new branch start point.

    git checkout -b <branch>
    git checkout -b <branch> <start>

or

    git branch <branch>
    git checkout <branch>

    git branch <branch> <start>
    git checkout <branch> <start>


#### Delete local branch

Delete already merged branch

    git branch -d <branch>

Force branch deletion

    git branch -D <branch>

[TOC](#toc)


### <a id="patching"></a>Patching

#### Copy commit range from one branch to another

Pick from start `<sha1>` commit till end `<sha1>` commit.

    git cherry-pick <sha1>..<sha1>

#### Creating and applying patches

By default _Git_ will create a patch for every commit. Use `--stdout > <patch>.patch` for combined patch.

Create patches for the last `N` commits (each commit in it's own patch).

    git format-patch HEAD~<N>

Create patches containing all commits from the current branch against another `<branch>` branch (each commit in it's own patch).

    git format-patch <branch>

Creating combined patch.

    git format-patch HEAD~<N> --stdout > <patch>.patch
    git format-patch <branch> --stdout > <patch>.patch

Check what changes are in the patch

    git apply --stat <patch>.patch

Test the patch before applying

    git apply --check <patch>.patch

Apply patch

    git am [--signoff] < <patch>.patch

[TOC](#toc)


### <a id="undoing"></a>Undoing

[git reset](http://www.kernel.org/pub/software/scm/git/docs/git-reset.html) contains great explanation and [examples](http://www.kernel.org/pub/software/scm/git/docs/git-reset.html#_examples).

#### Split commit

`--soft` option will keep files in the index.

    git reset [--soft] HEAD^

#### Undo a merge or pull

    git reset --hard

#### Undo a merge or pull inside a dirty work tree

    git reset --merge ORIG_HEAD

#### Revert a bad commit

    git revert <sha1>

#### Checkout a deleted file into the work tree

    git checkout <sha1>^ -- <file>

[TOC](#toc)


### <a id="remotes"></a>Remotes

#### Crete a new local branch by pulling a remote branch

    git checkout -b <branch> <repository>/<branch>

#### Track a remote branch with an existing local

    git branch --set-upstream <branch> <repository>/<branch>

#### Delete remote branch

    git push <repository> :heads/<branch>
    git push <repository> :<branch>
    git push <repository> --delete <branch> 

#### Prune remote-tracking branches that are deleted from a remote repo

    git remote prune <repository>

#### Change remote URL

    git remote set-url <repository> https://example.com/repo.git

[TOC](#toc)


### <a id="subtree"></a>Subtree

 - `--squash` do not preserve history (squash history)

#### Add subtree as non-remote repository

Add subtree

    git subtree add --prefix <directory> <url> <branch> [--squash]

Pull subtree

    git subtree pull --prefix <directory> <url> <branch> [--squash]

#### Add subtree as remote repository

Add remote

     git remote add -f <name> <url>

Add subtree

    git subtree add --prefix <directory> <remote> <branch> [--squash]

Pull subtree changes

    git fetch <remote> <branch>
    git subtree pull --prefix <directory> <remote> <branch> [--squash]

Push subtree changes

    git subtree push --prefix=<directory> <remote> <branch>

[TOC](#toc)


### <a id="submodules"></a>Submodules

#### Update submodules

    git submodule foreach 'git checkout master && git pull origin master'

#### Update submodule's URL

Edit the *.gitmodules* file, then run:

    git submodule sync

#### Remove submodule

  * remove the submodule's entry in the .gitmodules file
  * remove the submodule's entry in the .git/config
  * run `git rm –cached path/to/module` - **without a trailing slash!**
  * remove the submodule from the filesystem, run `rm -rf path/to/module/`
  * commit changes

[TOC](#toc)


### <a id="additional-resources"></a>Additional resources

 - [Most commonly used git tips and tricks](https://github.com/git-tips/tips)
 - [Pull remote changes discarding local ala 1:1 copy](http://stackoverflow.com/questions/2665045/can-i-tell-git-pull-to-overwrite-instead-of-merge)
 - [Working with remotes (@github)](http://help.github.com/remotes/)
 - [Forking (@github)](http://help.github.com/forking/)

[TOC](#toc)