def hosts [...args] {
  match ($args | first) {
    "bl" => {
      let l1 = $"127.0.0.1       ($args | last)\n"
      let l2 = $"::1             ($args | last)\n"
      $l1 | sudo tee -a /etc/hosts | ignore
      $l2 | sudo tee -a /etc/hosts | ignore
    },
    "edit" => (sudo nvim /etc/hosts)
  }
}

