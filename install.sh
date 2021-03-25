#!/bin/bash

mkdir ~/.config/kitty
mkdir ~/.config/nvim

ln -sf ~/Developer/gitclones/dotfiles/zshrc ~/.zshrc
ln -sf ~/Developer/gitclones/dotfiles/init.vim ~/.config/nvim/init.vim
ln -sf ~/Developer/gitclones/dotfiles/kitty.conf ~/.config/kitty/kitty.conf
ln -sf ~/Developer/gitclones/dotfiles/mimeapps.list ~/.config/mimeapps.list
