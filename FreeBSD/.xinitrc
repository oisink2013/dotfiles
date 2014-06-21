xrdb ~.Xdefaults
xset b 0

xset +fp /usr/local/lib/X11/fonts/SourceCodePro
xset +fp /usr/local/lib/X11/fonts/SourceSansPro
xset +fp /usr/local/lib/X11/fonts/anonymous-pro
xset +fp /usr/local/lib/X11/fonts/dejavu
xset +fp /usr/local/lib/X11/fonts/ubuntu-font
xset +fp /usr/local/lib/X11/fonts/urwfonts-ttf
xset +fp /usr/local/lib/X11/fonts/webfonts
xset +fp /usr/local/lib/X11/fonts/FontAwesome
xset +fp /usr/local/lib/X11/fonts/Entypo
xset +fp /usr/local/lib/X11/fonts/artwiz-aleczapka-en
xset +fp /usr/local/lib/X11/fonts/stlarch
xset fp rehash

setxkbmap -model pc104 -layout de

~/.config/wallpaper.sh &
compton &
#exec i3
exec herbstluftwm --autostart /usr/home/ash/.config/herbstluftwm/autostart --locked
