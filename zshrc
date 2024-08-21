# oh-my-zsh

ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
ZSH_DISABLE_COMPFIX=true
plugins=(git; zsh-syntax-highlighting; asdf)

source $ZSH/oh-my-zsh.sh

# services

eval "$(direnv hook zsh)"
. "$HOME/.asdf/asdf.sh"
fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit && compinit

export EDITOR="nvim"

# config aliases
alias czsh="nvim ~/.zshrc"
alias szsh="source ~/.zshrc"
alias cnvim="nvim ~/.config/nvim/init.vim"
alias ckitty="nvim ~/.config/kitty/kitty.conf"
alias ls="exa --icons --git"

# git
alias ga="git add ."
alias gcam="git commit -am"
alias gpull="git pull"
alias gpush="git push"
alias gb="git checkout"
alias gd="git diff"
alias gbb="git checkout -b"
alias gcz="npm run commit"
alias gpf="git push --force-with-lease"

# other aliases
alias cdd="cd ~/Developer; clear"
alias cc='cd ../'
alias fd="fdfind"
alias dcu="docker compose up"
alias pyvsct='python3 ~/Developer/pyvsct/main.py'

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="fd . ."
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d --hidden --follow --search-path $HOME/Developer"
bindkey -s '^k' 'cd $(fd -t d --hidden --follow --search-path $HOME/Developer | fzf)\nclear\n'
bindkey -s '^f' '^ucd $(ls -p | grep / | cat | fzf)\nclear\n'
bindkey -s '^n' '^ucd ~/Home/Notes\nclear\nnvim\n'
bindkey -s '^e' '^unvim $(ls -p | grep -v / | cat | fzf)\n'


# do I need this?
export PATH="/usr/local/opt/postgresql/bin:$PATH"

# work utilities
source ~/Developer/rr.sh

# Created by `pipx` on 2024-08-04 14:52:05
export PATH="$PATH:/home/owozsh/.local/bin"
