#!/usr/bin/env bash

# Caminho para o nível de bateria no NixOS (adapte se necessário)
BATTERY_PATH="/sys/class/power_supply/BAT0/capacity"

# Lê o nível da bateria
BATTERY_LEVEL=$(cat "$BATTERY_PATH")

# Se a bateria estiver em 5% ou menos, desliga o sistema
if [ "$BATTERY_LEVEL" -le 5 ]; then
    /run/current-system/sw/bin/systemctl poweroff
fi

