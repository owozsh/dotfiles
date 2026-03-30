# REQUIREMENTS #
# you definitely need nerd fonts https://www.nerdfonts.com
# nerd fonts repo https://github.com/ryanoasis/nerd-fonts
# i use "FiraCode Nerd Font Mono" on mac
#
# you also must have the gstat plugin installed and registered

# ATTRIBUTION #
# A little fancier prompt with git information
# inspired by https://github.com/xcambar/purs
# inspired by https://github.com/IlanCosman/tide
# inspired by https://github.com/JanDeDobbeleer/oh-my-posh

# Abbreviate home path
def home_abbrev [os_name] {
  let is_home_in_path = ($env.PWD | str starts-with $nu.home-dir)
  if $is_home_in_path {
    if ($os_name =~ "windows") {
      let home = ($nu.home-dir | str replace -ar '\\' '/')
      let pwd = ($env.PWD | str replace -ar '\\' '/')
      $pwd | str replace $home '~'
    } else {
      $env.PWD | str replace $nu.home-dir '~'
    }
  } else {
    if ($os_name =~ "windows") {
      # remove the C: from the path
      $env.PWD | str replace -ar '\\' '/' | str substring 2..
    } else {
      $env.PWD
    }
  }
}

def path_abbrev_if_needed [apath term_width] {
  $apath | split row "/" | last
}

def get_index_change_count [gs] {
  let index_new = ($gs | get idx_added_staged)
  let index_modified = ($gs | get idx_modified_staged)
  let index_deleted = ($gs | get idx_deleted_staged)
  let index_renamed = ($gs | get idx_renamed)
  let index_typechanged = ($gs | get idx_type_changed)

  $index_new + $index_modified + $index_deleted + $index_renamed + $index_typechanged
}

def get_working_tree_count [gs] {
  let wt_modified = ($gs | get wt_modified)
  let wt_deleted = ($gs | get wt_deleted)
  let wt_typechanged = ($gs | get wt_type_changed)
  let wt_renamed = ($gs | get wt_renamed)

  $wt_modified + $wt_deleted + $wt_typechanged + $wt_renamed
}

def get_conflicted_count [gs] {
  ($gs | get conflicts)
}

def get_untracked_count [gs] {
  ($gs | get wt_untracked)
}

def get_branch_name [gs] {
  let br = ($gs | get branch)
  if $br == "no_branch" {
    ""
  } else {
    $br
  }
}

def get_ahead_count [gs] {
  ($gs | get ahead)
}

def get_behind_count [gs] {
  ($gs | get behind)
}

def get_icons_list [] {
  {
    AHEAD_ICON: (char branch_ahead) # "↑" 2191
    BEHIND_ICON: (char branch_behind) # "↓" 2193
    NO_CHANGE_ICON: (char branch_identical) # ≣ 2263
    HAS_CHANGE_ICON: "*"
    INDEX_CHANGE_ICON: "♦"
    WT_CHANGE_ICON: "✚"
    CONFLICTED_CHANGE_ICON: "✖"
    UNTRACKED_CHANGE_ICON: (char branch_untracked) # ≢ 2262
    INSERT_SYMBOL_ICON: "❯"
    HAMBURGER_ICON: (char hamburger) # "≡" 2261
    GITHUB_ICON: "" # f408
    BRANCH_ICON: (char nf_branch) # "" e0a0
    REBASE_ICON: "" # e728
    TAG_ICON: "" # f412
  }
}

def get_icon_by_name [name] {
  get_icons_list | get $name
}

def get_os_icon [os] {
  # f17c = tux, f179 = apple, f17a = windows
  if ($os.name =~ macos) {
    (char -u f179)
  } else if ($os.name =~ windows) {
    (char -u f17a)
  } else if ($os.kernel_version =~ WSL) {
    $'(char -u f17a)(char -u f17c)'
  } else if ($os.family =~ unix) {
    (char -u f17c)
  } else {
    ''
  }
}

# ╭─────────────────────┬───────────────╮
# │ idx_added_staged    │ 0             │ #INDEX_NEW
# │ idx_modified_staged │ 0             │ #INDEX_MODIFIED
# │ idx_deleted_staged  │ 0             │ #INDEX_DELETED
# │ idx_renamed         │ 0             │ #INDEX_RENAMED
# │ idx_type_changed    │ 0             │ #INDEX_TYPECHANGE
# │ wt_untracked        │ 0             │ #WT_NEW
# │ wt_modified         │ 0             │ #WT_MODIFIED
# │ wt_deleted          │ 0             │ #WT_DELETED
# │ wt_type_changed     │ 0             │ #WT_TYPECHANGE
# │ wt_renamed          │ 0             │ #WT_RENAMED
# │ ignored             │ 0             │
# │ conflicts           │ 0             │ #CONFLICTED
# │ ahead               │ 0             │
# │ behind              │ 0             │
# │ stashes             │ 0             │
# │ repo_name           │ nushell       │
# │ tag                 │ no_tag        │
# │ branch              │ main          │
# │ remote              │ upstream/main │
# ╰─────────────────────┴───────────────╯

def get_repo_status [gs os] {
  let display_path = (path_abbrev_if_needed (home_abbrev $os.name) (term size).columns)
  let branch_name = (get_branch_name $gs)
  let ahead_cnt = (get_ahead_count $gs)
  let behind_cnt = (get_behind_count $gs)
  let index_change_cnt = (get_index_change_count $gs)
  let wt_change_cnt = (get_working_tree_count $gs)
  let conflicted_cnt = (get_conflicted_count $gs)
  let untracked_cnt = (get_untracked_count $gs)
  let has_no_changes = (
    if ($index_change_cnt <= 0) and
    ($wt_change_cnt <= 0) and
    ($conflicted_cnt <= 0) and
    ($untracked_cnt <= 0) {
      true
    } else {
      false
    }
  )

  let GIT_BG = "#C4A000"
  let GIT_FG = "#93a1a1"

  let AHEAD_ICON = (get_icon_by_name AHEAD_ICON)
  let A_COLOR = (ansi { fg: ($GIT_FG) })

  let BEHIND_ICON = (get_icon_by_name BEHIND_ICON)
  let B_COLOR = (ansi { fg: ($GIT_FG) })

  let INDEX_CHANGE_ICON = (get_icon_by_name INDEX_CHANGE_ICON)
  let I_COLOR = (ansi { fg: ($GIT_FG) })

  let CONFLICTED_CHANGE_ICON = (get_icon_by_name CONFLICTED_CHANGE_ICON)
  let C_COLOR = (ansi { fg: ($GIT_FG) })

  let WT_CHANGE_ICON = (get_icon_by_name WT_CHANGE_ICON)
  let W_COLOR = (ansi { fg: ($GIT_FG) })

  let UNTRACKED_CHANGE_ICON = (get_icon_by_name UNTRACKED_CHANGE_ICON)
  let U_COLOR = (ansi { fg: ($GIT_FG) })

  let NO_CHANGE_ICON = (get_icon_by_name NO_CHANGE_ICON)
  let N_COLOR = (ansi { fg: ($GIT_FG) })

  let HAS_CHANGE_ICON = (get_icon_by_name HAS_CHANGE_ICON)
  let H_COLOR = (ansi { fg: ($GIT_FG) attr: b })

  let INSERT_SYMBOL_ICON = (get_icon_by_name INSERT_SYMBOL_ICON)
  let S_COLOR = (ansi { fg: ($GIT_FG) })

  let R = (ansi reset)

  let repo_status = (
    $"(
      if $has_no_changes {''} else {$'($H_COLOR)($HAS_CHANGE_ICON)($R)'}
    )"
  )

  $repo_status
}

def git_diff_stat [] {
  let stat = (git diff --stat | complete)

  if $stat.exit_code != 0 { return "" }

  let result = $stat.stdout
    | tail -n -1
    | parse --regex '(\d+) insertions?\(\+\).*?(\d+) deletions?\(-\)'
    | rename added removed

  if ($result | length) == 0 {
    return ""
  }

  let added = $result.added | first
  let removed = $result.removed | first

  if ($added == "0" and $removed == "0") {
    return ""
  }

  [
    "("
    (ansi green)
    "+"
    $added
    (char space)
    (ansi red)
    "-"
    $removed
    (ansi reset)
    ")"
  ] | str join
}

def git_left_prompt [gs os] {
  let display_path = (path_abbrev_if_needed (home_abbrev $os.name) (term size).columns)
  let branch_name = (get_branch_name $gs)
  let R = (ansi reset)

  let GIT_BG = "#C4A000"
  let GIT_FG = "#000000"
  let TERM_BG = "#0C0C0C"

  let repo_status = (get_repo_status $gs $os)

  let is_home_in_path = ($env.PWD | str starts-with $nu.home-dir)

  let path_segment = (
      [
        $display_path
      ] | str join
  )

  let modified = $gs | get wt_modified
  let deleted = $gs | get wt_deleted


  let git_segment = (
    if ($branch_name != "") {
      [
        (ansi cyan)
        ($branch_name)
        (ansi reset)
        (git_diff_stat)
      ] | str join
    }
  )

  let dotfiles_dir = $"($env.HOME)/Developer/dotfiles"

  do { git -C $dotfiles_dir fetch origin } | ignore

  let dotfiles_has_updates = (
    git -C $dotfiles_dir rev-list --count HEAD..origin/HEAD
    | into int
    | $in > 0
  )

  let dotfiles_has_uncommitted = (
    git -C $dotfiles_dir status --porcelain
    | is-not-empty
  )

  let dotfiles_indicator = (
      if ($dotfiles_has_uncommitted or $dotfiles_has_updates) {
        ansi yellow
      } else {
        ansi green
      }
  )

  let has_error = $env.LAST_EXIT_CODE != 0

  let dotfiles_segment = (
    [
      (ansi reset)
      (if $has_error { ansi red } else { $dotfiles_indicator })
      (char -u f0627)
      (ansi reset)
    ] | str join
  )

  [
    $dotfiles_segment
    $path_segment
    $git_segment
  ] | compact | str join (char space)
}

export def git_prompt [] {
  let gs = (gstat)
  let os = $nu.os-info
  let left_prompt = (git_left_prompt $gs $os)
  let use_ansi = (config use-colors)

  {
    left_prompt: (if $use_ansi { $left_prompt } else { $left_prompt | ansi strip })
  }
}
