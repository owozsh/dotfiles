use ($nu.default-config-dir | path join mise.nu)
source ($nu.cache-dir       | path join carapace.nu)

source ($nu.default-config-dir | path join aliases.nu)
source ($nu.default-config-dir | path join tiendanube.nu)
source ($nu.default-config-dir | path join fdns.nu)
source ($nu.default-config-dir | path join hosts.nu)

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
