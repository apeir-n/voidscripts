#!/bin/bash

case $BUTTON in
    1) setsid -f st -g 107x32 -e wtfutil --config=~/.config/wtf/sys.yml ;;
    3) setsid -f $HOME/scripts/power ;;
esac

echo " [ void"
#echo " [  "
