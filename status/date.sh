#!/bin/bash

source $HOME/scripts/status/notify.sh

case $BUTTON in
    1) notify 200 "$(cal)" ;;
    3) setsid -f st -e calcurse ;;
esac

date '+  %a_%y%m%d' | tr '[:upper:]' '[:lower:]'
