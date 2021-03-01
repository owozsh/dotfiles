#!/bin/bash

rm -rf ~/.zshrc
rm -rf ~/.config/nvim
ln -s ~/gitclones/dotfiles/.zshrc ~/.zshrc
ln -s ~/gitclones/dotfiles/nvim ~/.config/nvim
