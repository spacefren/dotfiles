#!/bin/bash

selected=$(clipvault list | awk -F$'\t' '{print $2 "\t" $1}' | rofi -dmenu -i -sync -p "Clipboard")
id=$(printf '%s' "$selected" | awk -F$'\t' '{print $NF}')
[ -n "$id" ] && clipvault get --index "$id" | wl-copy && ydotool key 29:1 47:1 47:0 29:0
