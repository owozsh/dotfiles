#!/bin/bash

rm -rf ~/.config/nvim
ln -sf ~/Developer/dotfiles/.config/nvim ~/.config/nvim

if [ -f ~/.zshrc ]; then
	mv ~/.zshrc ~/.zshrc_old
fi

ln -sf ~/Developer/dotfiles/zshrc ~/.zshrc
