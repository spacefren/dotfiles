#!/bin/bash

# @vicinae.schemaVersion 1
# @vicinae.title Microsoft Rewards Farm
# @vicinae.mode silent
# @vicinae.exec ["/bin/bash"]

echo "🤖 Running..."
cd ~/Microsoft-Rewards-Script
ghostty -e npm start &
