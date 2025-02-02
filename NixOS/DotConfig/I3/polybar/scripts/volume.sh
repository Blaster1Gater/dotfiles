#!/usr/bin/env bash

# Get the current volume
volume=$(amixer get Master | grep -oP '\d+%' | head -1)

# Get the mute status
mute=$(amixer get Master | grep -oP '\[on\]|\[off\]' | head -1)

if [ "$mute" == "[off]" ]; then
    echo "Mute"
else
    echo "$volume"
fi
