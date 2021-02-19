export ZSH="/home/owozsh/.oh-my-zsh"

ZSH_THEME="lambda-gitster"

plugins=(git)

source $ZSH/oh-my-zsh.sh

alias org="nvim ~/茶/LIBRARY/org/.org.md"
alias cnvim="nvim ~/.config/nvim/init.vim"
alias ga="git add ."
alias gc="git commit -a -m"
alias gP="git push"
alias gp="git pull"
