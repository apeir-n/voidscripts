#!/bin/sh

. $HOME/scripts/status/notify.sh

clock="$(sldate '+%I')"

case $clock in
    00) icon="󱑊" ;; 
    01) icon="󱐿" ;;
    02) icon="󱑀" ;;
    03) icon="󱑁" ;;
    04) icon="󱑂" ;;
    05) icon="󱑃" ;;
    06) icon="󱑄" ;;
    07) icon="󱑅" ;;
    08) icon="󱑆" ;;
    09) icon="󱑇" ;;
    10) icon="󱑈" ;;
    11) icon="󱑉" ;;
    12) icon="󱑊" ;;
esac

case $BLOCK_BUTTON in
    1) notify 260 "$(sldate)" ;;
    3) slsetsid -f xterm -geometry 100x20 -fa "terminus:pixelsize=14" -e /home/ch_rism_/.local/share/cargo/bin/tuime --format "%I:%M" -f font3d -c cyan -c green ;;
esac

datecmd="$(sldate "+%I:%M%p" | sltr '[:upper:]' '[:lower:]')"

printf "%s  %s ] " "$icon" "$datecmd"
