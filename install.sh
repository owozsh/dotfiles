#!/bin/bash

mkdir ~/.config/nvim

ln -sf ~/Developer/dotfiles/zshrc ~/.zshrc
ln -sf ~/Developer/dotfiles/init.vim ~/.config/nvim/init.vim

git clone https://github.com/ergenekonyigit/lambda-gitster.git
cd lambda-gitster
cp lambda-gitster.zsh-theme ~/.oh-my-zsh/custom/themes
cd ..
rm -rf lambda-gitster

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

