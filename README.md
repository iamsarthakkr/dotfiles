# dotfiles

Personal config files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Layout

Each top-level directory is a stow package whose internal path mirrors `$HOME`:

```
dotfiles/
├── nvim/.config/nvim/...
├── tmux/.config/tmux/tmux.conf
├── ghostty/.config/ghostty/config
├── zsh/.zshrc
├── vs-code/...
```

Stowing a package symlinks its contents into place, e.g. `nvim/.config/nvim` -> `~/.config/nvim`.
`~/.config` itself stays a real directory — only the specific subfolders below are
symlinked, so unrelated tools (`gh`, `git`, `github-copilot`, etc.) can write their own
config there without ever touching this repo.

## Usage

```bash
./install.sh
```

This stows `nvim`, `tmux`, `ghostty`, and `zsh` into `$HOME`. Requires `stow`
(`brew install stow`).

To stow/unstow a single package manually:

```bash
stow -t ~ nvim      # link
stow -t ~ -D nvim   # unlink
```

## Adding a new package

1. Create the directory mirroring its `$HOME` path, e.g. for `alacritty`:
   `mkdir -p alacritty/.config/alacritty` and put its config files there.
2. Add the package name to `PACKAGES` in `install.sh`.
3. Run `stow -t ~ alacritty` (or `./install.sh`).
