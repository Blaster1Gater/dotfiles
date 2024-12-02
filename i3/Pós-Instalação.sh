#!/bin/bash

# Função para exibir mensagens formatadas
print_message() {
    echo -e "\n\033[1;34m$1\033[0m\n"
}

# 1. Atualizar os mirrors para os mais rápidos
print_message "⏳ Encontrando os melhores mirrors..."
reflector --country Brazil --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
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

# 4. Lista de aplicativos essenciais para o i3
apps=(
    # i3 Window Manager
    i3-wm                  # Gerenciador de janelas
    i3status               # Barra de status
    i3lock                 # Bloqueio de tela
    dmenu                  # Menu de aplicativos
    rofi                   # Menu alternativo ao dmenu
    picom                  # Compositor para transparências
    feh                    # Configuração de papel de parede
    lxappearance           # Ajuste de temas GTK
    xorg                   # Servidor gráfico
    xorg-xinit             # Inicialização do X
    xclip                  # Gerenciador de área de transferência
    # Terminal e gerenciador de arquivos
    kitty                  # Terminal leve e moderno
    ranger                 # Gerenciador de arquivos no terminal
    thunar                 # Gerenciador de arquivos gráfico
    # Aplicativos essenciais
    firefox                # Navegador web
    git                    # Controle de versões
    htop                   # Monitor de sistema no terminal
    vim                    # Editor de texto
    pavucontrol            # Controle de áudio
    blueman                # Gerenciador Bluetooth
    nitrogen               # Gerenciador de papéis de parede
    network-manager-applet # Applet de rede
    polybar                # Barra de Status
    # Adicione mais aplicativos conforme necessário
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

print_message "🎉 Pós-instalação concluída com sucesso! Reinicie para iniciar o i3."
