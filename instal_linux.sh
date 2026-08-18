#!/bin/bash

rm -rf ~/.config/helix
ln -sf ~/Developer/dotfiles/helix ~/.config/helix

rm -rf ~/.config/ghostty
ln -sf ~/Developer/dotfiles/ghostty ~/.config/ghostty

rm -rf /home/owozsh/.config/nushell
ln -sf ~/Developer/dotfiles/nushell /home/owozsh/.config/nushell
