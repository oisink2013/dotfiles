#!/usr/bin/env bash

# disable path name expansion or * will be expanded in the line
# cmd=( $line )

# easter eggs
sep_m="%{B#d854152B}%{F#ffC33A3A}  %{F-}%{B-}"
sep_v="%{B#d854152B}%{F#ffC33A3A}  %{F-}%{B-}"
sep_d="%{B#d854152B}%{F#ffC33A3A}  %{F-}%{B-}"
sep_c="%{B#d854152B}%{F#ffC33A3A}  %{F-}%{B-}"

set -f

if awk -Wv 2>/dev/null | head -1 | grep -q '^mawk'; then
    # mawk needs "-W interactive" to line-buffer stdout correctly
    # http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=593504
    uniq_linebuffered() {
      awk -W interactive '$0 != l { print ; l=$0 ; fflush(); }' "$@"
    }
else
    # other awk versions (e.g. gawk) issue a warning with "-W interactive", so
    # we don't want to use it there.
    uniq_linebuffered() {
      awk '$0 != l { print ; l=$0 ; fflush(); }' "$@"
    }
fi

monitor=${1:-0}

herbstclient pad $monitor 16 

{
    # events:
    mpc idleloop player | cat &
    
    # date
    while true ; do
        date +$'date_min %H:%M'
        sleep 1 || break
    done > >(uniq_linebuffered) &
    date_pid=$!
    
    while true ; do
	echo "vol $(mixer pcm | tail -1 | sed -E 's/[A-Za-z ]*([0-9]*).*/\1/') %%"
	sleep 1 || break
    done > >(uniq_linebuffered) &
    volume_pid=$!

    # hlwm events
    herbstclient --idle

    # exiting; kill stray event-emitting processes
    kill $date_pid $volume_pid
} 2> /dev/null | {
    TAGS=( $(herbstclient tag_status $monitor) )
    unset TAGS[${#TAGS[@]}]
    date_min="--"
    nowplaying="nanimo"
    windowtitle=""

    visible=true

    while true ; do
        echo -n "%{l}"
        for i in "${TAGS[@]}" ; do
            case ${i:0:1} in
                '#') # current tag
                    echo -n "%{B#d86A1226}"
                    ;;
                '+') # active on other monitor
                    echo -n "%{B#d8917154}"
                    ;;
                ':')
                    echo -n "%{B-}"
                    ;;
                '!') # urgent tag
                    echo -n "%{B#d8917154}"
                    ;;
                *)
                    echo -n "%{B-}"
                    ;;
            esac
            echo -n " ${i:1} "
        done
	
        if [ -n "$windowtitle" ] ; then 
            echo -n "%{c}$sep_c%{B#d854152B} ${windowtitle//^/^^} %{B-}"
        fi
	
        # align right
        echo -n "%{r}"
	echo -n "$sep_m"
	echo -n " $nowplaying "
        echo -n "$sep_v"
        echo -n " $volume "
        echo -n "$sep_d"
        echo -n " $date_min "
        echo " "
        # wait for next event
        read line || break
        cmd=( $line ) 
        # find out event origin
        case "${cmd[0]}" in
            tag*)
                TAGS=( $(herbstclient tag_status $monitor) )
                unset TAGS[${#TAGS[@]}]
                ;;
            vol)
                volume="${cmd[@]:1}"
                ;;
            date_min)
                date_min="${cmd[@]:1}"
                ;;
	    mpd_player|player)
                nowplaying="$(mpc current -f '%artist% - %title%')"
                ;;
		focus_changed|window_title_changed)
                windowtitle="${cmd[@]:2}"
                ;;
            quit_panel)
                exit
                ;;
            reload)
                exit
                ;;
        esac
    done
} 2> /dev/null | bar -d -g x16 -B "#d832192E" -F '#ffF6C79E' -f '*-stlarch-medium-r-*-*-10-*-*-*-*-*-*-*,-*-cure-medium-r-*-*-11-*-*-*-*-*-*-*' $1

