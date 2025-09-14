#!/bin/bash

function notify(){
    local width="$1"
    local message="$2"

    touch /tmp/xres.bak
    xrdb -query > /tmp/xres.bak
    (
        grep -v '^herbe.width:' ~/.Xresources
        echo "herbe.width: $width"
    ) | xrdb -load

    setsid -f herbe "$message"
    sleep 1
    xrdb -load /tmp/xres.bak
}
