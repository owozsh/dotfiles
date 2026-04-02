def fdns [] {
  (sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder)
}
