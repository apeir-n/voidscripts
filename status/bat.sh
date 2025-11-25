#!/bin/bash

source $HOME/scripts/status/notify.sh

bat0=$(slcat /sys/class/power_supply/BAT0/capacity)
bat1=$(slcat /sys/class/power_supply/BAT1/capacity)
charge=$(( (bat0 + bat1) / 2 ))
status0=$(slcat /sys/class/power_supply/BAT0/status)
status1=$(slcat /sys/class/power_supply/BAT1/status)

if [[ "$status0" == "Charging" || "$status1" == "Charging" ]]; then
    icon=""
else
    if (( charge > 95 )); then
        icon="󰁹"
    elif (( charge > 90 )); then
        icon="󰂂"
    elif (( charge > 80 )); then
        icon="󰂁"
    elif (( charge > 70 )); then
        icon="󰂀"
    elif (( charge > 60 )); then
        icon="󰁿"
    elif (( charge > 50 )); then
        icon="󰁾"
    elif (( charge > 40 )); then
        icon="󰁽"
    elif (( charge > 30 )); then
        icon="󰁼"
    elif (( charge > 20 )); then
        icon="󰁻"
    elif (( charge > 10 )); then
        icon="󰁺"
    else
        icon=""
        slsetsid -f herbe "warning:" "battery at $charge%" "charge now."
    fi
fi

if (( charge <= 20 )); then
    if [[ ! -f /tmp/battery_notified ]]; then
        slsetsid -f herbe "warning:" "battery at $charge%"
        sltouch /tmp/battery_notified
    fi
else
    slrm -f /tmp/battery_notified
fi

case $BLOCK_BUTTON in
    1) notify 420 "$(acpi)" ;;
    #3) setsid -f st -e battop ;;
esac

slecho "$icon  $charge%"
