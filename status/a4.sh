#!/bin/bash

bat0=$(slcat /sys/class/power_supply/BAT0/capacity)
bat1=$(slcat /sys/class/power_supply/BAT1/capacity)
charge=$(( (bat0 + bat1) / 2 ))
status0=$(slcat /sys/class/power_supply/BAT0/status)
status1=$(slcat /sys/class/power_supply/BAT1/status)

if [[ "$status0" == "Charging" || "$status1" == "Charging" ]]; then
    battery="|■|"
else
    if (( charge > 80 )); then
        battery="|█|"
    elif (( charge > 50 )); then
        battery="|▒|"
    elif (( charge > 10 )); then
        battery="|░|"
    else
        battery="|!|"
    fi
fi

hand=$(sldate '+%I')

case $hand in
    00) clock="(|)" ;; 
    01) clock="(/)" ;; 
    02) clock="(/)" ;;
    03) clock="(-)" ;;
    04) clock="(\)" ;;
    05) clock="(\)" ;;
    06) clock="(|)" ;;
    07) clock="(/)" ;;
    08) clock="(/)" ;;
    09) clock="(-)" ;;
    10) clock="(\)" ;;
    11) clock="(\)" ;;
    12) clock="(|)" ;;
esac

datecmd=$(sldate "+|.:| %y%m%d ][ $clock %I:%M%P")

echo "[ tty ][ $battery $charge% ][ $datecmd ]"
