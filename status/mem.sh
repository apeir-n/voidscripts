#!/bin/bash

source $HOME/scripts/status/notify.sh

case $BUTTON in
    1) notify 680 "$(free -h)" ;;
    3) setsid -f st -e btop ;;
esac

percent=$(free | awk '/Mem/ { printf("%.0f%%\n", $3/$2 * 100) }')
echo "  $percent"
