#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

PACKAGES=(nvim tmux ghostty zsh)

if ! command -v stow &>/dev/null; then
    echo "GNU Stow is not installed. Install it first (e.g. brew install stow)." >&2
    exit 1
fi

stow -t "$HOME" -v "${PACKAGES[@]}"
