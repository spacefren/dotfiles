#!/bin/bash

# @vicinae.schemaVersion 1
# @vicinae.title Waybar Reload
# @vicinae.mode fullOutput
# @vicinae.exec ["/bin/bash"]

killall waybar
waybar &
