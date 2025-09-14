#!/bin/bash

clock=$(date '+%I')

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

case $BUTTON in
    1) setsid -f st -g 100x20 -e /home/ch_rism_/.local/share/cargo/bin/tuime --format "%I:%M" -f font3d -c cyan -c green ;;
    3) setsid -f st -e /home/ch_rism_/.cargo/bin/clock-rs -tsBc green --fmt '%y%m%d' ;;
esac

date "+$icon  %I:%M%P ] "
