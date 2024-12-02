#!/bin/bash

# Função para exibir mensagens formatadas
print_message() {
    echo -e "\n\033[1;34m$1\033[0m\n"
}

# 1. Atualizar os mirrors para os mais rápidos
print_message "⏳ Encontrando os melhores mirrors..."
reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist
if [ $? -eq 0 ]; then
    print_message "✅ Mirrors atualizados com sucesso!"
else
    echo "❌ Erro ao atualizar os mirrors. Continuando com os atuais..."
fi

# 2. Sincronizar os repositórios e atualizar o sistema
print_message "🔄 Atualizando os repositórios e o sistema..."
sudo pacman -Syu --noconfirm

# 3. Verificar e instalar o `yay`
print_message "🛠️ Verificando se o 'yay' está instalado..."
if ! command -v yay &>/dev/null; then
    print_message "🔧 'yay' não encontrado. Instalando..."
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay || exit
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
    print_message "✅ 'yay' instalado com sucesso!"
else
    print_message "✅ 'yay' já está instalado."
fi

# 4. Lista de aplicativos essenciais para o Hyprland
apps=(
    # Gerenciadores de Janelas e Compositores
    hyprland               # Gerenciador de janelas Wayland
    swaybg                 # Gerenciador de fundo de tela para Wayland
    swaylock               # Bloqueio de tela para Wayland
    alacritty              # Terminal para Wayland
    # Utilitários gráficos e de rede
    thunar                 # Gerenciador de arquivos gráfico
    kitty                  # Terminal leve e moderno
    nmtui                  # Interface de rede no terminal
    networkmanager         # Gerenciador de rede
    # Utilitários e sistemas
    git                    # Controle de versões
    vim                    # Editor de texto
    htop                   # Monitor de sistema no terminal
    pavucontrol            # Controle de áudio
    blueman                # Gerenciador Bluetooth
    rofi                   # Menu de aplicativos
    feh                    # Configuração de papel de parede
    lxappearance           # Ajuste de temas GTK
    pacman-contrib         # Ferramentas extras para pacman
    # Outros
    firefox                # Navegador web
    steam                  # Plataforma de jogos
    obsidian               # Editor de notas
    4kvideodownloader      # Download de vídeos 4K
    ventoy                 # Ferramenta para criar USBs bootáveis
    waybar                 # Barra de status para Wayland
    swww                   # Ferramenta para definir o papel de parede no Wayland
    hyprpaper              # Definidor de papéis de parede para Hyprland
)

# 5. Instalar os aplicativos da lista
print_message "🚀 Iniciando a instalação dos aplicativos..."
for app in "${apps[@]}"; do
    if pacman -Qi "$app" &>/dev/null || yay -Q "$app" &>/dev/null; then
        echo "✅ '$app' já está instalado. Pulando..."
    else
        echo "🔄 Instalando '$app'..."
        yay -S --noconfirm "$app"
        if [ $? -eq 0 ]; then
            echo "✅ '$app' instalado com sucesso!"
        else
            echo "❌ Falha ao instalar '$app'."
        fi
    fi
done

# 6. Ativando o IloveCandy no pacman
print_message "✨ Ativando IloveCandy no pacman..."
echo 'ILoveCandy' | sudo tee -a /etc/pacman.conf

# 7. Otimizando a quantidade de downloads simultâneos
print_message "⚡ Otimizando downloads simultâneos..."
echo "ParallelDownloads = 5" | sudo tee -a /etc/pacman.conf

# 8. Finalização
print_message "🎉 Pós-instalação concluída com sucesso! Reinicie para iniciar o Hyprland."

