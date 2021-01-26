exec nitrogen --restore &
wal -R
setxkbmap -option caps:escape
picom -b --experimental-backends
xrandr --output DVI-D-0 --off --output HDMI-0 --mode 1920x1080 --pos 0x590 --rotate normal --output DP-0 --mode 1920x1080 --pos 1920x0 --rotate right --output DP-1 --off
dwmstatus 2>&1 >/dev/null &
exec ~/.config/dwm/dwm
