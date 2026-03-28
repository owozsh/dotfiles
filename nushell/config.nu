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
alias cnu   = nvim ($nu.config-path)

# def snu [] {
#   source ($nu.config-path)
# }

# Git
alias ga    = git add .
alias gcam  = git commit -am
alias gpull = git pull
alias gpush = git push
alias gb    = git checkout
alias gd    = git diff
alias gbb   = git checkout -b
alias gcz   = npm run commit
alias gpf   = git push --force-with-lease
alias grh   = git reset --hard

# Navigation
alias cdd = bash -c "cd ~/Developer && clear"

# Docker / misc
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

def fetch_dotfiles_updates [] {
    let dir = $"($env.HOME)/Developer/dotfiles"

    def step  [msg: string] { print $"  (ansi blue)→(ansi reset) (ansi bo)($msg)(ansi reset)" }
    def ok    [msg: string] { print $"  (ansi green)✔(ansi reset) ($msg)" }
    def warn  [msg: string] { print $"  (ansi yellow)⚠(ansi reset) ($msg)" }
    def fail  [msg: string] { print $"  (ansi red)✖(ansi reset) ($msg)" }

    print ""
    print $"  (ansi cyan)(ansi bo)dotfiles(ansi reset)"
    print $"  (ansi d)─────────────────────────(ansi reset)"

    step "Checking repository..."
    let is_repo = (do { git -C $dir rev-parse --is-inside-work-tree } | complete | get exit_code) == 0
    if not $is_repo {
        fail $"Not a git repository: ($dir)"
        return
    }

    step "Checking working tree..."
    let status = (git -C $dir status --porcelain | str trim)
    if not ($status | is-empty) {
        warn "Uncommitted changes — push before updating"
        git -C $dir status --short | lines | each { |l| print $"     ($l)" }
        print ""
        return
    }
    ok "Clean"

    step "Fetching from remote..."
    git -C $dir fetch --all --quiet
    ok "Fetched"

    step "Checking for new commits..."
    let incoming = (git -C $dir log HEAD..origin/main --oneline | str trim)

    if ($incoming | is-empty) {
        sleep 800ms
        clear
        print ""
        print $"  (ansi cyan)(ansi bold)dotfiles(ansi reset)  (ansi green)✔ up to date(ansi reset)"
        print ""
        return
    }

    let count = ($incoming | lines | length)
    ok $"($count) new commit(s) incoming"
    $incoming | lines | each { |l| print $"     (ansi d)($l)(ansi reset)" }
    print ""

    step "Rebasing onto origin/main..."
    let rebase = (do { git -C $dir rebase origin/main --quiet } | complete)
    if $rebase.exit_code == 0 {
        ok "Done"
        print ""
    } else {
        fail "Rebase failed — resolve conflicts and run: git rebase --continue"
        print ""
    }
}

# ── Run on shell start ────────────────────────────────────────────────────────

fetch_dotfiles_updates

$env.config.show_banner = false

use ($nu.default-config-dir | path join mise.nu)
use ($nu.default-config-dir | path join git.nu) git_prompt

$env.PROMPT_COMMAND = { (git_prompt).left_prompt }
$env.PROMPT_COMMAND_RIGHT = { (git_prompt).right_prompt }
$env.PROMPT_INDICATOR = " "
