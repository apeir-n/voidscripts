#!/bin/sh

case $BLOCK_BUTTON in
    1) setsid -f $HOME/scripts/power ;;
    3) setsid -f xterm -geometry 107x32 -fa "monospace:pixelsize=14" -e wtfutil --config=~/.config/wtf/sys.yml ;;
esac

echo " [ void"
#echo " [  "
