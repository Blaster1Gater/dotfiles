#!/bin/bash

# Atualização do Sistema
sudo apt update && sudo apt upgrade -y

# Instalação de pacotes essenciais
sudo apt install -y \
    i3 i3status i3lock rofi alacritty \
    polybar cava neofetch arduino gcc \
    feh git brightnessctl

# Instalando as configurações personalizadas
cp -r ./config/* ~/.config/
mkdir ~/Imagens/Wall/
cp -r ../Wall/* ~/Imagens/Wall/

# Finalizando
sudo apt autoremove -y
sudo apt autoclean -y
