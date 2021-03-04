export ZSH="/home/owozsh/.oh-my-zsh"

ZSH_THEME="lambda-gitster"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export EDITOR="nvim"

NNN_FIFO=/tmp/nnn.fifo
export NNN_PLUG='f:finder;o:fzopen;p:mocplay;d:diffs;t:nmount;v:imgview'

alias org="nvim ~/Desktop/茶/org/.org.md"
alias cnvim="nvim ~/.config/nvim/init.vim"
alias ga="git add ."
alias gc="git commit -a -m"
alias gP="git push"
alias sapi="sudo apt install"
