#!/usr/bin/bash

# Temporary files
IMG="$(mktemp --suffix=.png)"
OUTBASE="$(mktemp -u)"   # tesseract will append .txt

# Capture region using grimblast
grimblast save area "$IMG"

# Run OCR with english language and single-line mode
if ! tesseract "$IMG" "$OUTBASE" >/dev/null 2>&1; then
    echo "OCR failed (tesseract)."
    rm -f "$IMG"
    exit 1
fi

# Check output exists
OUTTXT="${OUTBASE}.txt"
if [ ! -f "$OUTTXT" ]; then
    echo "No text detected."
    rm -f "$IMG"
    exit 1
fi

# Copy text to clipboard
wl-copy < "$OUTTXT"
echo "OCR text copied to clipboard."

# Cleanup
rm -f "$IMG" "$OUTTXT"
