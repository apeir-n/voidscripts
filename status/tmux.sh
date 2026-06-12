#!/bin/sh

hand=$(date '+%I')

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

line="$(date "+ [ tmux ][ |.:| %y%m%d_%a ][ $clock %I:%M%p ] " | tr '[:upper:]' '[:lower:]')"

printf "%s" "$line"
