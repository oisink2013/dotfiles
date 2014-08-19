xrdb -merge ~/.config/Xresources
xset b 0

xset +fp /usr/share/fonts/artwiz-fonts
xset +fp /usr/share/fonts/misc
xset fp rehash

xsetroot -cursor_name left_ptr &
xcalib -d : 0 ~/.config/LG_Flatron_W2261V.icc

setxkbmap -model pc104 -layout de

urxvtd &
~/.config/wallpaper.sh &
compton &
#exec i3
#exec herbstluftwm --locked
#~/.config/bspwm/wm
sxhkd &
[ -e "$PANEL_FIFO" ] && rm "$PANEL_FIFO"
mkfifo "$PANEL_FIFO"
exec ~/.config/bspwm/wm 
