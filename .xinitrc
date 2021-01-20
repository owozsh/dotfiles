exec nitrogen --restore &
setxkbmap -option caps:escape
dwmstatus 2>&1 >/dev/null &
exec ~/dwm/dwm
