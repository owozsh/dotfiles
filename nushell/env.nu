$env.config.show_banner = false

$env.PATH ++= [
  ($env.HOME | path join '/opt/homebrew/bin')
  ($env.HOME | path join '/usr/local/bin')
  ($env.HOME | path join '.opencode/bin')
  ($env.HOME | path join '.cargo/bin')
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
