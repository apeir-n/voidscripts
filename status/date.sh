#!/bin/sh

. $HOME/scripts/status/notify.sh

case $BLOCK_BUTTON in
    1) notify 200 "$(slcal | sed 's/[[:space:]]*$//')" ;;
    3) slsetsid -f xterm -fa "terminus:pixelsize=14" -e calcurse ;;
esac

datecmd="$(date '+  %a_%y%m%d' | tr '[:upper:]' '[:lower:]')"

printf "%s" "$datecmd"
