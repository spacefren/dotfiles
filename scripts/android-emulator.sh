#!/usr/bin/bash

QT_QPA_PLATFORM=xcb \
__GLX_VENDOR_LIBRARY_NAME=nvidia \
GBM_BACKEND=nvidia-drm \
__GL_COLORSPACE_SRGB=1 \
ghostty -e emulator -avd "Pixel_9a" -gpu host -no-window -no-snapshot &
