#!/bin/sh

notify () {
    local width="$1"
    local message="$2"

    sltouch /tmp/xres.bak
    xrdb -query > /tmp/xres.bak
    (
        slgrep -v '^herbe.width:' ~/.Xresources
        echo "herbe.width: $width"
    ) | xrdb -load

    slsetsid -f herbe "$message"
    slsleep 1
    xrdb -load /tmp/xres.bak
}
