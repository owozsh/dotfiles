#!/bin/bash

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

rm -rf ~/.config/zellij
ln -sf ~/Developer/dotfiles/.config/zellij ~/.config/zellij

rm -rf ~/.config/nvim
ln -sf ~/Developer/dotfiles/.config/nvim ~/.config/nvim

rm -rf ~/.config/kitty
ln -sf ~/Developer/dotfiles/.config/kitty ~/.config/kitty

if [ -f ~/.zshrc ]; then
	mv ~/.zshrc ~/.zshrc_old
fi
ln -sf ~/Developer/dotfiles/zshrc ~/.zshrc
