#!/bin/bash

WALLPAPER_DIR="$HOME/.config/dotfiles/wallpapers"

NO_ANIM=false
for arg in "$@"; do
  case "$arg" in
    -no-animation)
      NO_ANIM=true
      ;;
    --help)
      echo "Usage: $(basename "$0") [-no-animation]"
      echo
      echo "Options:"
      echo "  -no-animation   Disable transition animation when setting the wallpaper."
      exit 0
      ;;
  esac
done

CURRENT_WALL=$(swww query | awk -F'image: ' '/currently displaying/ {print $2}')
WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

matugen image "$WALLPAPER"
ln -sf "$WALLPAPER" "$WALLPAPER_DIR/.current-wallpaper"

if [ "$NO_ANIM" = true ]; then
  swww img "$WALLPAPER" --transition-type none
else
  swww img "$WALLPAPER" --transition-type center --transition-fps 60
fi
