#!/bin/bash

# this script is run by a signal in dwmblocks, triggered by `pkill -RTMIN+5 dwmblocks`
# that signal is executed on the volume ctrl keybinds defined in ~/.xbindkeysrc,
# and from an event returned by `mpc idle player` in the script ~/scripts/mpc_watch
#   

title=$(mpc -f %title% current)
artist=$(mpc -f %artist% current)
state=$(mpc status %state%)
vol=$(amixer get Master | awk -F'[][]' '/%/ { print $2; exit }')

case $state in
    "playing")  play="" ;;
    "paused")   play="" ;;
    "stopped")  play="" ;;
    *)          play=" " ;;
esac

lastsong="/tmp/lastsong.txt"
currentsong="$artist - $title"

if [[ "$currentsong" != "$(cat $lastsong 2>/dev/null)" && "$state" == "playing" ]]; then
    setsid -f herbe "$artist" "$title"
    echo "$currentsong" > "$lastsong"
fi

function toggle() {
    if [[ $state == "playing" ]]; then
        mpc pause
    else
        mpc play
    fi
}

case $BUTTON in
    1) setsid -f herbe "$artist" "$title" ;;
    2) toggle ;;
    3) setsid -f st -g 96x24 -e rmpc -t ~/.config/rmpc/themes/pywalst.ron ;;
esac

echo "$play  $vol"
