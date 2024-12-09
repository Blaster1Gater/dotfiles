#!/usr/bin/env bash

killall swww-daemon
swww-daemon &

# Caminho para salvar o papel de parede atual
CACHE_WALLPAPER="$HOME/.cache/wal/wallpaper"

# Se o script for executado na inicialização, use o último esquema de cores
if [[ "$1" == "startup" ]]; then
    # Reaplicar o último esquema de cores salvo
    wal -R
    exit 0
fi

# Selecionar uma imagem aleatória
WALLPAPER=$(find ~/Imagens/Wall -type f | shuf -n 1)

# Definir o papel de parede com swww
swww img "$WALLPAPER" --transition-type center --transition-fps 60

# Atualizar o esquema de cores com Pywal
wal -i "$WALLPAPER"

# Salvar o caminho do papel de parede atual
echo "$WALLPAPER" > "$CACHE_WALLPAPER"
