#!/bin/bash

source $HOME/scripts/status/notify.sh

output=$(curl -s 'https://wttr.in/Akron?format=1')
emoji=$(echo "$output" | awk '{print $1}')
temp=$(echo "$output" | awk '{print $2}' | tr -d '+F')

case "$emoji" in #                 
    "☀️") icon="" ;;
    "⛅") icon="" ;;
    "☁️") icon="" ;;
    "☁️☁️") icon="" ;;
    "⛈") icon="" ;;
    "🌨") icon="" ;;
    "🌧️") icon="" ;;
    "🌫") icon="" ;;
    "🌪") icon="" ;;
    "✨") icon="" ;;
    "❄️") icon="" ;;
    "🌦") icon="" ;;
    "🌩") icon="" ;;
    *) icon="󰖟" ;;
esac

case $BUTTON in
    1) notify 290 "$(curl 'https://wttr.in/Akron?0&T')" ;;
    #1) notify 290 "$(stormy --compact)" ;;
    3) setsid -f st -g 125x36 -e bash -c "curl -s https://wttr.in/Akron | head -n -3; read -n 1 -p 'q to close:' key; [ \"key\" = q ] && exit" ;;
esac

echo "$icon  $temp"
