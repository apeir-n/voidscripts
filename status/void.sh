#!/bin/sh

case $BLOCK_BUTTON in
    1) slsetsid -f $HOME/scripts/power ;;
    3) slsetsid -f xterm -geometry 107x32 -fa "monospace:pixelsize=14" -e wtfutil --config=~/.config/wtf/sys.yml ;;
esac

echo " [ void"
#echo " [  "
