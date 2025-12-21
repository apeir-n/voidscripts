#!/bin/bash

#   

title=$(mpc -f %title% current)
artist=$(mpc -f %artist% current)
state=$(mpc status %state%)
vol=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{ print $5; exit }')

case $state in
    "playing")  play="" ;;
    "paused")   play="" ;;
    "stopped")  play="" ;;
    *)          play=" " ;;
esac

lastsong="/tmp/lastsong.txt"
currentsong="$artist - $title"

if [[ "$currentsong" != "$(cat $lastsong 2>/dev/null)" && "$state" == "playing" ]]; then
    slsetsid -f herbe "$artist" "$title"
    echo "$currentsong" > "$lastsong"
fi

function toggle() {
    if [[ $state == "playing" ]]; then
        mpc pause
    else
        mpc play
    fi
}

case $BLOCK_BUTTON in
    1) slsetsid -f herbe "$artist" "$title" ;;
    #2) toggle && pkill -RTMIN+5 dwmblocks ;;
    2) toggle ;;
    3) slsetsid -f xterm -geometry 96x24 -fa "monospace:pixelsize=14" -e rmpc ;;
esac

echo "$play  $vol"
