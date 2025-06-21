#!/usr/bin/env bash

# Get the current brightness
brightness=$(brightnessctl get)
max_brightness=$(brightnessctl max)
percentage=$(echo "($brightness * 100) / $max_brightness" | bc)

echo "${percentage}%"
