#!/bin/bash
set -e

DOTFILES="$HOME/Developer/dotfiles"

link() {
  rm -rf "$2"
  ln -s "$DOTFILES/$1" "$2"
}

link nvim    "$HOME/.config/nvim"
link helix   "$HOME/.config/helix"
link ghostty "$HOME/.config/ghostty"
link nushell "$HOME/Library/Application Support/nushell"
link zshrc   "$HOME/.zshrc"
