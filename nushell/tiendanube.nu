let tiendanube_path = "/Users/nuver/Developer/tiendanube"

if ($tiendanube_path | path exists) {
  $env.NUBE_TIENDANUBE_ROOT = $tiendanube_path
  $env.DOCKER_CLIENT_TIMEOUT = "300"
  $env.COMPOSE_HTTP_TIMEOUT = "300"

  $env.PATH ++= ["/Users/nuver/.nube/bin"]
}

def nube-theme [...args] {
  if ($tiendanube_path | path exists) {
    bash -c $"source ~/.local/bin/nube-theme.sh; theme ($args | str join ' ')"
  }
}
