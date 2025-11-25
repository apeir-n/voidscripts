#!/bin/bash

source $HOME/scripts/status/notify.sh
source $HOME/scripts/status/wearray.sh

weather=$(yr now akron --json)
temp=$(echo "$weather" | jq -r '"\((.temperature * 9 / 5) + 32 | round)°"')
symbol=$(echo "$weather" | jq -r '.symbolCode')

icon="${icons[$symbol]}"
[ -z "$icon" ] && icon=""
[ -z "$temp" ] && temp="o.0"

case $BLOCK_BUTTON in
    1) notify 290 "$(stormy --compact | sed 's/―/-/g')" ;;
    3) setsid -f xterm -geometry 125x37 -fa "monospace:pixelsize=14" -e bash -c "wego | tail -n +3 | less -R" ;;
esac

echo "$icon  $temp"
