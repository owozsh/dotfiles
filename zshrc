# ──────────────────────────────────────────────────────────────
# Environment
# ──────────────────────────────────────────────────────────────
export PATH="/opt/homebrew/bin:/usr/local/bin:$HOME/.opencode/bin:$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
export EDITOR="hx"
export VISUAL="hx"

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS

# mise
eval "$(mise activate zsh)"

# Completions
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select

# Edit the current command line in $EDITOR (nushell's buffer_editor) with Ctrl-X Ctrl-E
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# ──────────────────────────────────────────────────────────────
# Prompt: last path segment + git branch (cyan clean, yellow dirty)
# ──────────────────────────────────────────────────────────────
_prompt_git() {
  local branch
  branch="$(git symbolic-ref --short HEAD 2>/dev/null)" || return
  branch="${branch//\%/%%}"
  if [[ -n "$(git status --porcelain --untracked-files=no 2>/dev/null)" ]]; then
    print -n "%F{yellow}${branch}%f"
  else
    print -n "%F{cyan}${branch}%f"
  fi
}

_set_prompt() {
  local git_seg
  git_seg="$(_prompt_git)"
  PROMPT="%1~${git_seg:+ $git_seg} "
}
precmd_functions+=(_set_prompt)
RPROMPT=""

# ──────────────────────────────────────────────────────────────
# Aliases
# ──────────────────────────────────────────────────────────────
alias lsa='ls -a'

# Config editing
alias cnvim='hx ~/.config/nvim/init.lua'
alias chx='hx ~/.config/helix/config.toml'
alias cghostty='hx ~/.config/ghostty/config'
alias czsh='hx ~/.zshrc'
alias szsh='source ~/.zshrc'

# Git
alias g='git'
alias glo='git log --oneline'
alias ga='git add .'
alias gfa='git fetch --all'
alias gcam='git commit -am'
alias gpull='git pull'
alias gpush='git push'
alias gb='git checkout'
alias gd='git diff'
alias gbb='git checkout -b'
alias gcz='npm run commit'
alias gpf='git push --force-with-lease'
alias grh='git reset --hard'
alias grb='git rebase'
alias gcp='git cherry-pick'

# Navigation
alias cdd='cd ~/Developer'

# Docker
alias dcu='docker compose up'

# ──────────────────────────────────────────────────────────────
# Commands
# ──────────────────────────────────────────────────────────────
gacp() {
  if [[ $# -eq 0 ]]; then
    echo "Usage: gacp <message>"
    return 1
  fi
  git add . && git commit -am "$*" && git push
}

ping() {
  echo pong
}

# Flush macOS DNS cache
fdns() {
  sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder
}

# hosts bl <domain>  → blackhole a domain in /etc/hosts
# hosts edit         → open /etc/hosts in the editor
hosts() {
  case "$1" in
    bl)
      if [[ -z "$2" ]]; then
        echo "Usage: hosts bl <domain>"
        return 1
      fi
      printf '127.0.0.1       %s\n::1             %s\n' "$2" "$2" | sudo tee -a /etc/hosts >/dev/null
      ;;
    edit)
      sudo hx /etc/hosts
      ;;
    *)
      echo "Usage: hosts bl <domain> | hosts edit"
      return 1
      ;;
  esac
}

# yazi wrapper: cd into the directory yazi was in on exit
y() {
  local tmp cwd
  tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  command yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [[ -n "$cwd" && "$cwd" != "$PWD" && -d "$cwd" ]]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# Pick (or create) a note in ~/Notes and open it in hx
ctrln() {
  local note
  note="$(eza "$HOME/Notes" | fzf --reverse --bind enter:accept-or-print-query)"
  note="${note%%.*}"
  if [[ -n "$note" ]]; then
    hx "$HOME/Notes/$note.md"
    clear
  fi
}

# ──────────────────────────────────────────────────────────────
# Keybindings
# ──────────────────────────────────────────────────────────────
# Ctrl-K: jump to a project in ~/Developer
_jump_to_project() {
  local proj
  proj="$(eza "$HOME/Developer" | fzf --reverse --preview 'eza -1 --icons --color=always ~/Developer/{}')"
  if [[ -z "$proj" ]]; then
    zle reset-prompt
    return
  fi
  zle push-line
  BUFFER="cd ${(q)HOME}/Developer/${(q)proj} && clear"
  zle accept-line
  zle reset-prompt
}
zle -N _jump_to_project
bindkey '^k' _jump_to_project

# Ctrl-N: jump to a note
_jump_to_note() {
  zle push-line
  BUFFER="ctrln"
  zle accept-line
  zle reset-prompt
}
zle -N _jump_to_note
bindkey '^n' _jump_to_note

# ──────────────────────────────────────────────────────────────
# Local, untracked config (work-specific, machine-specific)
# ──────────────────────────────────────────────────────────────
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# >>> granted (managed by Security) >>>
[ -f "$HOME/.granted-shell-init.sh" ] && . "$HOME/.granted-shell-init.sh"
# <<< granted (managed by Security) <<<
