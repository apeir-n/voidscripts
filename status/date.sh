#!/bin/bash

source $HOME/scripts/status/notify.sh

case $BUTTON in
    1) notify 200 "$(cal)" ;;
    #3) setsid -f st -e calcurse ;;
    3) slsetsid -f xterm -fa "monospace:pixelsize=14" -e calcurse ;;
esac

sldate '+  %a_%y%m%d' | tr '[:upper:]' '[:lower:]'
