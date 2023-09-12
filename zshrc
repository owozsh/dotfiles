# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

ZSH_DISABLE_COMPFIX=true

plugins=(git; zsh-syntax-highlighting; asdf)

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

alias org="nvim ~/today.md"

# CONFIG

alias czsh="nvim ~/.zshrc"
alias szsh="source ~/.zshrc"
alias cnvim="nvim ~/.config/nvim/init.vim"
alias ckitty="nvim ~/.config/kitty/kitty.conf"

# DOCKER

alias dcu="docker compose up"

# SHORTCUTS

alias cdd="cd Developer; clear"
alias cuni="cd Files/uni 🎓; clear"

# GIT

alias ga="git add ."
alias gcam="git commit -am"
alias gpull="git pull"
alias gpush="git push"
alias gb="git checkout"
alias gbb="git checkout -b"
alias gcz="npm run commit"

# NVM

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun completions
[ -s "/Users/owozsh/.bun/_bun" ] && source "/Users/owozsh/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

alias mysql=/usr/local/mysql/bin/mysql

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias t="todo.sh"

alias dcu="docker compose up"

eval "$(rbenv init - zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND="fd . ."
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d --hidden --follow --search-path $HOME/Developer"

# bindkey -s '^f' '^ucd ./**\t\nclear\n'
bindkey -s '^f' '^ucd $(ls -p | grep / | cat | fzf)\nclear\n'
bindkey -s '^e' '^unvim $(ls -p | grep -v / | cat | fzf)\n'

alias cc='cd ../'

alias pyvsct='python3 ~/Developer/pyvsct/main.py'
