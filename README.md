# Tobias’s dotfiles

The goal is to keep this really simple (compare this with my [previous attempt](https://github.com/tobiasandersen/dotfiles-old)). I'm keeping a git repo in my home folder where I've disabled status tracking on non-repo files with:

```zsh
git config --local status.showUntrackedFiles no
```

*Note that this setting isn't stored inside the repo, so you need to run it again when setting up a new computer.*

To start tracking a file, simply add it:

```zsh
git add $FILE
```

I prefer this over ignoring all files with `.gitignore` since that messes with my Telescope fuzzy finder.
