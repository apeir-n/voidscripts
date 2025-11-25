#!/bin/sh

. $HOME/scripts/status/notify.sh

case $BLOCK_BUTTON in
    1) notify 700 "$(free -h)" ;;
    3) setsid -f xterm -fa "monospace:pixelsize=14" -e btop ;;
esac

percent=$(free | awk '/Mem/ { printf("%.0f%%\n", $3/$2 * 100) }')
echo "  $percent"
