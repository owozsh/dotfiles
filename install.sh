#!/bin/bash

rm -rf ~/.zshrc
rm -rf ~/.config/nvim/init.vim

mkdir ~/.config/nvim

ln -sf ~/Developer/gitclones/dotfiles/zshrc ~/.zshrc
ln -sf ~/Developer/gitclones/dotfiles/init.vim ~/.config/nvim/init.vim
