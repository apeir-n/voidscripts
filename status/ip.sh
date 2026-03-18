#!/bin/sh

. "$HOME/scripts/status/notify.sh"

ipgetter () {
    ip address                 \
        | grep "inet "         \
        | grep -v "127.0.0.1"  \
        | awk '{print $2}'     \
        | sed 's/\/.*//'
}

iplong="$(ipgetter)"
ipshort="$(ipgetter | sed 's/192.168.//')"

case $BLOCK_BUTTON in
    1) notify 140 "$iplong" ;;
    # 3) slsetsid -f xterm -fa "monospace:pixelsize=14" -e btop ;;
esac

printf "  %s" "$ipshort"
