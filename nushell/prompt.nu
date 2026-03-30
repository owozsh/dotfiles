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

def get_branch_name [gs] {
  let br = ($gs | get branch)
  if $br == "no_branch" {
    ""
  } else {
    $br
  }
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

def left_prompt [gs os] {
  let display_path = home_abbrev $os.name | split row "/" | last
  let branch_name = (get_branch_name $gs)

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

export def main [] {
  let gs = (gstat)
  let os = $nu.os-info
  let left_prompt = (left_prompt $gs $os)
  let use_ansi = (config use-colors)

  {
    left_prompt: (if $use_ansi { $left_prompt } else { $left_prompt | ansi strip })
  }
}
