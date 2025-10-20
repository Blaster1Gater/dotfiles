{ config, pkgs, ... }:

{
    
  # Instala o zsh
  programs.zsh.enable = true;

  #Instala o fish
  programs.fish.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Install Steam
  programs.steam = {
     enable = true;
     remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
     dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
     localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
   };

  environment.systemPackages = with pkgs; [
  	### Essencial para o funcionamento ###
     home-manager
     firefox
     google-chrome
     mesa
     vim
     git
     curl
     vlc
     zip
     unzip
     brightnessctl
     bc
     alsa-utils
     lm_sensors
     procps
     psmisc
     libtool
     m4
     automake
     autoconf
     intltool
     readline
     file
     readline.dev
     power-profiles-daemon
     usbutils
     udiskie
     wl-clipboard
     udisks
     blueberry
     gparted
     unrar
     unar
     p7zip
     networkmanagerapplet
     e2fsprogs
     wget
     pamixer
     imv
     mpv
     kitty
     openvpn

	### Fish ###
     	oh-my-fish
     	fishPlugins.done
     	fishPlugins.fzf-fish
     	fishPlugins.forgit
     	fishPlugins.hydro
     	fishPlugins.grc
     	grc

	### Hyprland ###
     waybar
     hyprpaper
     hyprpicker
     hyprshot
     hyprlock
     grim
     slurp
     rofi
     kitty
     swww
     pywal
     hellwal
     wlogout
     ncspot

	### Importantes ###
     kdePackages.kate
     marktext
     wlsunset

     #ventoy-full
     nemo
     ranger
     htop
     btop
     cheese
     foliate
     qbittorrent
     qalculate-gtk
     guake
     xournalpp

	### Biito ###
     neofetch
     papirus-icon-theme
     adwaita-icon-theme

	### Bão ###
     discord-ptb
     spotify
     thokr
     telegram-desktop
     protonvpn-gui

	### Estudo ###
     anki-bin
     #blender

	### Escritorio ###
     libreoffice-qt
     hunspell
     #krita
     evince
     gimp

	### Desenvolvimento ###
     arduino
     arduino-ide
     vscode
     python311Full
     gcc
     cmake
     ninja

	### Wine ###
     lutris
     wineWowPackages.waylandFull
     winetricks
     vkd3d
     vulkan-tools
     wineWowPackages.stagingFull
     dxvk
     libva
     glxinfo

	### Scripts ###
     yajl
     pkg-config
     playerctl
     cairo
     pango
     gobject-introspection
     librsvg
     libjpeg
     zlib
     python3Packages.requests
     python3Packages.colorama

     fastfetch
     icu
  ];
}
