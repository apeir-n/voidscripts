#!/bin/bash

source "$HOME/scripts/status/notify.sh"
source "$HOME/scripts/status/wearray.sh"

weather=$(yr now akron --json)
temp=$(echo "$weather" | jq -r '"\((.forecast[0].temperature * 9 / 5) + 32 | round)°"')
symbol=$(echo "$weather" | jq -r '.forecast[0].symbolCode')

icon="${icons[$symbol]}"
[ -z "$icon" ] && icon=""
[ -z "$temp" ] && temp="o.0"

case $BLOCK_BUTTON in
    1) notify 290 "$(stormy --compact | sed 's/―/-/g')" ;;
    3) slsetsid -f xterm -geometry 125x37 -fa "terminus:pixelsize=14" -e sh -c "wego | tail -n +3 | less -R" ;;
esac

printf "%s  %s" "$icon" "$temp"
