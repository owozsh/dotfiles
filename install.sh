#!/bin/bash

rm -rf ~/.config/nvim
ln -sf ~/Developer/dotfiles/.config/nvim ~/.config/nvim

if [ -f ~/.zshrc ]; then
	mv ~/.zshrc ~/.zshrc_old
fi

if [ -f ~/.aerospace.toml ]; then
	rm ~/.aerospace.toml
fi

ln -sf ~/Developer/dotfiles/zshrc ~/.zshrc

ln -sf ~/Developer/dotfiles/aerospace.toml ~/.aerospace.toml
