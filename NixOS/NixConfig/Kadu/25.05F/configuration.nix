# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./flatpak.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  #networking.wireless.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_PT.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };
  
  services.power-profiles-daemon.enable = true;
  services.devmon.enable = true;
  services.gvfs.enable = true; 
  services.udisks2.enable = true;
  
  # OPENGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ mesa.drivers ];
  };
  
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.nix-ld.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  
  # Habilitando o Hyprland
  programs.hyprland = { enable = true; xwayland.enable = true; };
  
  #environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw
  #services.xserver = {
  #  #enable = true;
  #  desktopManager = {
  #    #gnome.enable = true;
  #    xterm.enable = false;
  #  };

  #  displayManager = {
  #      #gdm.enable = true;
  #      defaultSession = "none+i3";
  #  };

  #  windowManager.i3 = {
  #    enable = true;
  #    extraPackages = with pkgs; [
  #      dmenu #application launcher most people use
  #      i3status # gives you the default i3 status bar
  #      i3lock #default i3 screen locker
  #      i3blocks #if you are planning on using i3blocks over i3status
  #      polybar
  #      cava
  #      feh
  #      kitty
  #      rofi
  #      picom
  #   ];
  #  };
  #};
  
  # Enable automatic login for the user.
  #services.displayManager.autoLogin = { enable = true; user = "kadu"; };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.kadu = {
    isNormalUser = true;
    description = "Carlos Eduardo Porto da Hora";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };
  
  # Instala o zsh
  programs.zsh.enable = true;

  #Instala o fish
  programs.fish.enable = true;
  
  # Flake
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Instalando e ativando o flatpak
  services.flatpak.enable = true;
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Install firefox.
  programs.firefox.enable = true;
  
  # Install Steam
  programs.steam = {
     enable = true;
     remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
     dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
     localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
   };

  # Instalando aplicativos
  environment.systemPackages = with pkgs; [    
     ### Essencial para o funcionamento ###
     home-manager
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

     ### Fish ###
     oh-my-fish
     fishPlugins.done
     fishPlugins.fzf-fish
     fishPlugins.forgit
     fishPlugins.hydro
     fishPlugins.grc
     grc

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

     ### Importantes ###
     kdePackages.kate
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

     ### Desenvolvimento ###
     arduino
     arduino-ide

     ### Jogos ###
     mgba
     snes9x-gtk
     pcsx2
     mangohud
     scanmem

     ### Wine ###
     lutris
     wineWowPackages.waylandFull
     winetricks
     vkd3d
     vulkan-tools
  ];
  
  system.stateVersion = "25.05"; # Did you read the comment?

}
