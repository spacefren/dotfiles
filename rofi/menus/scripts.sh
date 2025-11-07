#!/bin/bash

# Define the folder where your scripts are stored
SCRIPT_DIR="$HOME/Scripts/"

# List all executable files in that folder
SCRIPTS=$(find "$SCRIPT_DIR" -maxdepth 1 -type f -executable -printf "%f\n")

# If there are no scripts, exit
if [ -z "$SCRIPTS" ]; then
    notify-send "No executable scripts found in $SCRIPT_DIR"
    exit 1
fi

# Show them in a Rofi menu and capture the user's choice
CHOICE=$(rofi -dmenu -sync -i -p "Run script" <<< "$SCRIPTS")

# If the user cancelled or made no choice, exit
[ -z "$CHOICE" ] && exit 0

# Run the chosen script
"$SCRIPT_DIR/$CHOICE"
