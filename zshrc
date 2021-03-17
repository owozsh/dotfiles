export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="lambda-gitster"
ZSH_DISABLE_COMPFIX="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export EDITOR="nvim"

export NNN_FIFO='/tmp/nnn.fifo'
export NNN_PLUG='p:preview-tui;a:preview-tabbed'
export NNN_BMS=''

alias n="nnn -C -o -P a"

alias org="nvim ~/Migrator/org/.org.md"

alias czsh="nvim ~/.zshrc"
alias cnvim="nvim ~/.config/nvim/init.vim"
alias ckitty="nvim ~/.config/kitty/kitty.conf"

alias ga="git add ."
alias gc="git commit -a -m"
alias gP="git push"

alias sapi="sudo apt install"

