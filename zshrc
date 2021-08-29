ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="bira"

ZSH_DISABLE_COMPFIX=true

plugins=(git; zsh-autosuggestions; zsh-syntax-highlighting; asdf)

source $ZSH/oh-my-zsh.sh

export EDITOR="nvim"

# NNN

export NNN_FIFO='/tmp/nnn.fifo'
export NNN_PLUG='p:preview-tui;a:preview-tabbed'
export NNN_FCOLORS='c1e2272e006033f7c6d6abc4'
export NNN_BMS=''
export NNN_OPENER="/usr/local/bin/nvim"

alias n="nnn -C -o -c"

# ORG

alias org="nvim ~/Migrator/Planner/org.md"

# CONFIG

alias czsh="nvim ~/.zshrc"
alias cnvim="nvim ~/.config/nvim/init.vim"
alias ckitty="nvim ~/.config/kitty/kitty.conf"

# GIT

alias ga="git add -A"
alias gc="git commit -a"
alias gP="git push"

# RUBY
export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"
export PATH="/usr/local/opt/ruby/bin:$PATH"
