ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="lambda-gitster"

ZSH_DISABLE_COMPFIX=true

plugins=(git; zsh-autosuggestions; zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

#export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export EDITOR="nvim"

export NNN_FIFO='/tmp/nnn.fifo'
export NNN_PLUG='p:preview-tui;a:preview-tabbed'
export NNN_FCOLORS='c1e2272e006033f7c6d6abc4'
export NNN_BMS=''
export NNN_OPENER="/usr/local/bin/nvim"

alias n="nnn -C -o -c"

alias org="nvim ~/Migrator/org/org.md"

alias czsh="nvim ~/.zshrc"
alias cnvim="nvim ~/.config/nvim/init.vim"
alias ckitty="nvim ~/.config/kitty/kitty.conf"
alias cdwm="nvim ~/Developer/dotfiles/dwm-6.1/config.h"

alias ga="git add ."
alias gc="git commit -a -m"
alias gP="git push"

alias ai="sudo apt install"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# RUBY
export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"
export PATH="/usr/local/opt/ruby/bin:$PATH"
