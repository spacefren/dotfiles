#!/bin/bash

CURRENT_WALL=$(swww query | awk -F'image: ' '/currently displaying/ {print $2}')
matugen image "$CURRENT_WALL"

dunstctl reload
dunstify "It is $(date)"
