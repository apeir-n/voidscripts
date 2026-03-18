#!/bin/sh

case $BLOCK_BUTTON in
    1) slsetsid -f power ;;
    3) slsetsid -f xterm -geometry 107x32 -fa "terminus:pixelsize=14" -e wtfutil --config=~/.config/wtf/sys.yml ;;
esac

printf " [ void"
#printf " [  "
