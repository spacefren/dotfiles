#!/bin/bash

# Don't judge, I'm new :sob:
selected=$(clipvault list | awk -F "\t" '{print $2 "\t\t\t\t\t\t\t\t\t" $1}' | rofi -dmenu -i -sync -p "Clipboard" | awk -F "\t" '{print $10}')
echo "$selected"
[ -n "$selected" ] && clipvault get "$selected" | wl-copy | ydotool key 29:1 47:1 47:0 29:0
