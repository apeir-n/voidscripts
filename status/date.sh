#!/bin/sh

. $HOME/scripts/status/notify.sh

case $BLOCK_BUTTON in
    1) notify 200 "$(cal)" ;;
    3) slsetsid -f xterm -fa "monospace:pixelsize=14" -e calcurse ;;
esac

sldate '+  %a_%y%m%d' | tr '[:upper:]' '[:lower:]'
