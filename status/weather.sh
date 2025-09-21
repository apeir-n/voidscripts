#!/bin/bash

source $HOME/scripts/status/notify.sh
source $HOME/scripts/status/wearray.sh

weather=$(yr now akron --json)
temp=$(echo "$weather" | jq -r '"\((.temperature * 9 / 5) + 32 | round)°"')
symbol=$(echo "$weather" | jq -r '.symbolCode')

icon="${icons[$symbol]}"

if [[ -z "$icon" ]]; then
    icon=""
fi

case $BUTTON in
    1) notify 290 "$(stormy --compact)" ;;
    3) setsid -f st -g 125x36 -e bash -c "wego | head -n -3; read -n 1 -p 'q to close:' key; [ \"key\" = q ] && exit" ;;
esac

echo "$icon  $temp"
