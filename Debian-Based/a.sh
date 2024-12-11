#!/bin/bash

# Atualização do Sistema
sudo apt update && sudo apt upgrade -y

# Instalação de pacotes essenciais
sudo apt install -y \
    i3 i3status i3lock rofi dex \
    alacritty polybar xss-lock \
    nm-applet pactl \
    feh git

# Removendo a configuração padrão
rm ~/.config/i3 ~/.config/polybar ~/.config/alacritty ~/.config/rofi

# Instalando as configurações
cp ./config/* ~/.config/
