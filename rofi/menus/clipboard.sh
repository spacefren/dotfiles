#!/bin/bash
selected=$(clipvault list | \
    awk -F "\t" '{printf "%d | %s\n", NR, $2}' | \
    rofi -dmenu -i -sync -p "Clipboard" | \
    sed 's/^\([0-9]*\) |.*/\1/')

if [ -n "$selected" ]; then
    entry_id=$(clipvault list | awk -F "\t" -v line="$selected" 'NR==line {print $1}')

    # Use process substitution to avoid corrupting binary data
    wl-copy < <(clipvault get "$entry_id")

    sleep 0.15
    wtype -M ctrl v -m ctrl
fi
