# ── Environment ──────────────────────────────────────────────────────────────

$env.EDITOR = "nvim"
$env.config.buffer_editor = "nvim"

$env.config.keybindings = [
  {
    name: jump_to_project
    modifier: control
    keycode: char_k
    mode: [emacs vi_normal vi_insert]
    event: {
      send: executehostcommand
      cmd: "cd ($env.HOME)/Developer/(eza ($env.HOME)/Developer| fzf --reverse --preview 'eza -1 --icons --color=always ~/Developer/{}'); clear"
    }
  }
]

# ── Aliases ───────────────────────────────────────────────────────────────────

# Config editing
alias cnvim   = nvim ~/.config/nvim/init.lua
alias ckitty  = nvim ~/.config/kitty/kitty.conf
alias caero   = nvim ~/.aerospace.toml
alias cghostty   = nvim ~/.config/ghostty/config
alias cnu     = nvim ($nu.config-path)

# Git
alias g     = git
alias glo   = git log
alias ga    = git add .
alias gfa    = git fetch --all
alias gcam  = git commit -am
alias gpull = git pull
alias gpush = git push
alias gb    = git checkout
alias gd    = git diff
alias gbb   = git checkout -b
alias gcz   = npm run commit
alias gpf   = git push --force-with-lease
alias grh   = git reset --hard
alias grb   = git rebase

# Navigation
alias cdd = cd ~/Developer

# Docker
alias dcu    = docker compose up

# ── Functions ─────────────────────────────────────────────────────────────────

def gacp [
    ...msg: string
] {
    if ($msg | is-empty) {
        print "Usage: gacp <message>"
        return
    }

    let message = ($msg | str join " ")

    git add .
    git commit -am $message
    git push
}

def ping [] {
    print "pong"
}

# ── Run on shell start ────────────────────────────────────────────────────────

use ($nu.default-config-dir | path join mise.nu)

source ($nu.cache-dir          | path join carapace.nu )
source ($nu.default-config-dir | path join tiendanube.nu)
source ($nu.default-config-dir | path join fdns.nu)
source ($nu.default-config-dir | path join hosts.nu)

