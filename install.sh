#!/bin/bash

# Run the script after installing oh-my-zsh

# set up neovim config
rm -rf ~/.config/nvim
ln -sf ~/Developer/dotfiles/nvim ~/.config/nvim

# set up zsh config
ln -sf ~/Developer/dotfiles/zshrc ~/.zshrc
