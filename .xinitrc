exec nitrogen --restore &
wal -R
setxkbmap -option caps:escape
picom -b --experimental-backends
dwmstatus 2>&1 >/dev/null &
exec ~/.config/dwm/dwm
