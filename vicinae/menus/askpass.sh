#!/bin/bash
#
# askpass.sh — rofi-based sudo askpass helper
# Works with: sudo -A, /etc/sudo.conf “Path askpass …”
#
# Requirements:
#   - rofi must be installed and usable under your current $DISPLAY
#   - Do not add debug output; sudo expects only the password on stdout

# Safety: fail if no display (prevents sudo hanging on non-GUI sessions)
if [ -z "$DISPLAY" ]; then
  echo "No DISPLAY available for askpass" >&2
  exit 1
fi

# Prompt the user — -password hides input, 2>/dev/null silences GTK warnings
password="$(rofi -dmenu -password -p 'Password' 2>/dev/null)"

# If rofi exited non-zero (user hit Esc or closed the window)
[ $? -ne 0 ] && exit 1

# Output the password exactly once with a single trailing newline
# sudo reads this from stdin; no extra spaces or characters allowed
printf '%s\n' "$password"
