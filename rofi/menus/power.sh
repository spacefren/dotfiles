#!/bin/bash

declare -a OPTIONS

OPTIONS=(
    " Power | shutdown now"
    " Reboot | reboot"
    " Lock | sleep 0.2 && hyprlock"
    " Log out | hyprctl dispatch exit"
)

# Extract just the names for display
NAMES=$(printf "%s\n" "${OPTIONS[@]}" | cut -d '|' -f1)

CHOICE=$(echo "$NAMES" | rofi -dmenu -sync -i -p "Power")

[ -z "$CHOICE" ] && exit 0

# Find the matching entry and extract the command
for entry in "${OPTIONS[@]}"; do
    name="${entry%%|*}"
    command="${entry#*|}"
    if [ "$name" == "$CHOICE" ]; then
        eval "$command"
        break
    fi
done
