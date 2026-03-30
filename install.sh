#!/bin/bash

rm -rf ~/.config/nvim
ln -sf ~/Developer/dotfiles/.config/nvim ~/.config/nvim

rm -rf ~/.config/ghostty
ln -sf ~/Developer/dotfiles/.config/ghostty ~/.config/ghostty

rm -rf ~/Library/Application\ Support/nushell
ln -sf ~/Developer/dotfiles/nushell ~/Library/Application\ Support/nushell

if [ -f ~/.zshrc ]; then
	mv ~/.zshrc ~/.zshrc_old
  ln -sf ~/Developer/dotfiles/zshrc ~/.zshrc
fi

if [ -f ~/.aerospace.toml ]; then
	rm ~/.aerospace.toml
  ln -sf ~/Developer/dotfiles/aerospace.toml ~/.aerospace.toml
fi

