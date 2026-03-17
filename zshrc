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
alias caero="nvim ~/.aerospace.toml"

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

bindkey -s '^k' '^ucd $HOME/Developer/$(ls $HOME/Developer | fzf --reverse --preview "eza -1 --icons --color=always $HOME/Developer/{}")\nclear\n'

bindkey -s '^f' '^ucd $(ls -p | grep / | cat | fzf)\nclear\n'
bindkey -s '^n' '^ucd ~/Home/Notes\nclear\nnvim\n'
# bindkey -s '^e' '^unvim $(ls -p | grep -v / | cat | fzf)\n'

eval "$(mise activate zsh)"

if [ -d "/Users/nuver/Developer/tiendanube" ]; then
  autoload -U +X bashcompinit && bashcompinit
  autoload -U +X compinit && compinit

  export NUBE_TIENDANUBE_ROOT="/Users/nuver/Developer/tiendanube"
  eval "$(/Users/nuver/.nube/bin/nube init -)"
  export DOCKER_CLIENT_TIMEOUT=300
  export COMPOSE_HTTP_TIMEOUT=300

  alias nns="yarn start:dev"
  alias nnf="yarn dev:local-api"
fi

gacp() {
  [[ -z "$1" ]] && echo "Usage: gacp <message>" && return 1
  git add . && git commit -am "$*" && git push
}

ping() {
  echo pong
}

fetch_dotfiles_updates() {
  local dir="$HOME/Developer/dotfiles"

  local reset="\033[0m"
  local bold="\033[1m"
  local dim="\033[2m"
  local green="\033[32m"
  local yellow="\033[33m"
  local blue="\033[34m"
  local red="\033[31m"
  local cyan="\033[36m"

  _step()  { echo -e "  ${blue}→${reset} ${bold}$*${reset}"; }
  _ok()    { echo -e "  ${green}✔${reset} $*"; }
  _warn()  { echo -e "  ${yellow}⚠${reset} $*"; }
  _error() { echo -e "  ${red}✖${reset} $*"; }
  _dim()   { echo -e "${dim}$*${reset}"; }

  echo ""
  echo -e "  ${cyan}${bold}dotfiles${reset}"
  _dim "  ─────────────────────────"

  _step "Checking repository..."
  if ! git -C "$dir" rev-parse --is-inside-work-tree &>/dev/null; then
    _error "Not a git repository: $dir"
    return 1
  fi

  _step "Checking working tree..."
  if [[ -n "$(git -C "$dir" status --porcelain)" ]]; then
    _warn "Uncommitted changes — push before updating"
    git -C "$dir" status --short | sed 's/^/     /'
    echo ""
    return 1
  fi
  _ok "Clean"

  _step "Fetching from remote..."
  git -C "$dir" fetch --all --quiet
  _ok "Fetched"

  _step "Checking for new commits..."
  local incoming
  incoming="$(git -C "$dir" log HEAD..origin/main --oneline)"

  if [[ -z "$incoming" ]]; then
    sleep 0.8 && clear
    echo ""
    echo -e "  ${cyan}${bold}dotfiles${reset}  ${green}✔ up to date${reset}"
    echo ""
    return 0
  fi

  local count
  count="$(echo "$incoming" | wc -l | tr -d ' ')"
  _ok "$count new commit(s) incoming"
  echo "$incoming" | sed "s/^/     ${dim}/" | sed "s/$/${reset}/"
  echo ""

  _step "Rebasing onto origin/main..."
  if git -C "$dir" rebase origin/main --quiet; then
    _ok "Done"
    echo ""
  else
    _error "Rebase failed — resolve conflicts and run: git rebase --continue"
    echo ""
    return 1
  fi
}

fetch_dotfiles_updates
