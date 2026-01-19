#!/bin/bash

# Get list of removable mounted drives (USB/external) - only partitions
usb_drives=$(lsblk -nrpo "name,type,size,mountpoint,label,rm,hotplug" | awk '$2=="part" && $4!="" && ($6=="1" || $7=="1") {
    label = ($5 != "" ? $5 : "No Label")
    printf "%s | %s | %s | %s\n", label, $3, $4, $1
}')

# Check if any removable drives are mounted
if [ -z "$usb_drives" ]; then
    notify-send "USB Ejector" "No mounted removable drives found" -u normal -i drive-removable-media
    exit 0
fi

# Show rofi menu and get selection
selected=$(echo "$usb_drives" | rofi -dmenu -i -p "Select USB drive to eject" -theme-str 'window {width: 700px;}')

# Exit if no selection was made
if [ -z "$selected" ]; then
    exit 0
fi

# Extract device name from selection (last field after last |)
device=$(echo "$selected" | awk -F' \\| ' '{print $NF}')

# Get label and mount point for notification
label=$(echo "$selected" | awk -F' \\| ' '{print $1}')
mountpoint=$(echo "$selected" | awk -F' \\| ' '{print $3}')

# Attempt to unmount the device
if udisksctl unmount -b "$device" 2>/dev/null; then
    # If unmount successful, power off the device
    if udisksctl power-off -b "$device" 2>/dev/null; then
        notify-send "USB Ejector" "Successfully ejected: $label ($mountpoint)" -u normal -i drive-removable-media
    else
        notify-send "USB Ejector" "Unmounted but couldn't power off: $label ($mountpoint)" -u normal -i drive-removable-media
    fi
else
    notify-send "USB Ejector" "Failed to eject: $label ($mountpoint)" -u critical -i dialog-error
    exit 1
fi
