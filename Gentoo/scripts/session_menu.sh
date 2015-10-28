#!/bin/bash
# a simple logout dialog
choice=`echo -e "Cancel\nLogout\nShutdown\nReboot\nLock" | dmenu -i -l 5 -h 30 -w 300 -x 0 -y 24 -fn "Ubuntu-10:Regular" -nb "#2b2b2b" -nf "#f7f7f7" -sb "#f7f7f7" -sf "#2b2b2b" -p "$USER" | cut -d ':' -f 1`
# execute the choice in background
case "$choice" in
    C*) exit ;;
    Log*) killall 2bwm;;
    S*) systemctl reboot;;
    R*) systemctl shutdown;;
    Loc*) i3lock -i ~/.config/lockscreen.png;;
esac
