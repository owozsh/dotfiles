$env.config.show_banner = false

$env.PATH ++= [
  ($env.HOME | path join '/opt/homebrew/bin')
  ($env.HOME | path join '/usr/local/bin')
  ($env.HOME | path join '.opencode/bin')
  ($env.HOME | path join '.local/bin')
  ($env.HOME | path join '.cargo/bin')
]

$env.EDITOR = "nvim"
$env.config.buffer_editor = "nvim"

def ctrln [] {
  let note = eza ($env.HOME)/Notes | fzf --reverse --bind enter:accept-or-print-query | split row . | first

  if (($note | str length) > 0) {
    hx ($env.HOME)/Notes/($note).md; clear
  }
}

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
  {
    name: jump_to_project
    modifier: control
    keycode: char_n
    mode: [emacs vi_normal vi_insert]
    event: {
      send: executehostcommand
      cmd: "ctrln"
    }
  }
]

use ($nu.default-config-dir | path join prompt.nu)
$env.PROMPT_COMMAND = { (prompt).left_prompt }
$env.PROMPT_COMMAND_RIGHT = ""
$env.PROMPT_INDICATOR = " "

let mise_path = $nu.default-config-dir | path join mise.nu
^mise activate nu | save $mise_path --force

$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
mkdir $"($nu.cache-dir)"
carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"
