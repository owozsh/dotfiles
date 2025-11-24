# oh-my-zsh

ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
ZSH_DISABLE_COMPFIX=true
plugins=(git; zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# services

eval "$(direnv hook zsh)"
# eval "$(zellij setup --generate-auto-start zsh)"

export EDITOR="nvim"

# config aliases
alias czsh="nvim ~/.zshrc"
alias szsh="source ~/.zshrc"
alias cnvim="nvim ~/.config/nvim/init.lua"
alias ckitty="nvim ~/.config/kitty/kitty.conf"

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
alias grh="git reset --hard"

# other aliases
alias cdd="cd ~/Developer; clear"
alias cc='cd ../'
alias dcu="docker compose up"
alias pyvsct='python3 ~/Developer/pyvsct/main.py'

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="fd . ."
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d --hidden --follow --search-path $HOME/Developer"
#
# bindkey -s '^k' 'cd $(fd -t d --hidden --follow --search-path $HOME/Developer | fzf)\nclear\n'

fzf-dev-cd() {
  local dir
  dir=$(fd -t d --max-depth 1 --hidden --follow . $HOME/Developer | fzf --height 40% --reverse --preview 'ls -la {}')
  if [[ -n $dir ]]; then
    cd "$dir"
    zle reset-prompt
  fi
  clear
}
zle -N fzf-dev-cd

bindkey '^k' fzf-dev-cd

bindkey -s '^f' '^ucd $(ls -p | grep / | cat | fzf)\nclear\n'
bindkey -s '^n' '^ucd ~/Home/Notes\nclear\nnvim\n'
# bindkey -s '^e' '^unvim $(ls -p | grep -v / | cat | fzf)\n'

eval "$(mise activate zsh)"
# nube autocomplete fix for zsh
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit

### Added by nube
export NUBE_TIENDANUBE_ROOT="/Users/nuver/Developer/tiendanube"
eval "$(/Users/nuver/.nube/bin/nube init -)"
export DOCKER_CLIENT_TIMEOUT=300
export COMPOSE_HTTP_TIMEOUT=300


alias nns="yarn start:dev"
alias nnf="yarn dev:local-api"
