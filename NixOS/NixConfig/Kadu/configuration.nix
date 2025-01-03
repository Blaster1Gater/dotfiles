{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable Bluetooch
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_BR.UTF-8";

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

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # services.xserver.libinput.enable = true;
  
  # Flake
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  fonts.packages = with pkgs; [
    font-awesome
    powerline-fonts
    powerline-symbols
    (nerdfonts.override { fonts = ["JetBrainsMono"]; })
    
  ];

  # Instala o zsh
  programs.zsh.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kadu = {
    isNormalUser = true;
    description = "Carlos Eduardo Porto da Hora";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  services.getty.autologinUser = "kadu";

  
  #services.accounts-daemon.enable = true;

  # Habilitando o xserver
  #services.xserver.enable = true;

  # Habilitando o GDM
  #services.xserver.displayManager.gdm = { enable = true; };
    
  # Habilitando o Hyprland
  programs.hyprland = { enable = true; xwayland.enable = true; };
    
  # Enable automatic login for the user.
  #services.displayManager.autoLogin = { enable = true; user = "kadu"; };

  # Permitindo pacotes não livres
  nixpkgs.config.allowUnfree = true;

  # Instalando e ativando o flatpak
  services.flatpak.enable = true;
  
  services.power-profiles-daemon.enable = true;
  services.devmon.enable = true;
  services.gvfs.enable = true; 
  services.udisks2.enable = true;

  # OPENGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = ["amdgpu" "modesetting"];

  # Install Steam
  programs.steam = {
     enable = true;
     remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
     dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
     localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
   };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.nix-ld.enable = true;

  #programs.nix-ld.libraries = with pkgs; [
  #  glibc
  #  libgcc
  #];

  # Instalando aplicativos
  environment.systemPackages = with pkgs; [    
     ### Essencial para o funcionamento ###
     home-manager
     firefox
     mesa
     vim
     git
     curl
     vlc
     zip
     unzip
     brightnessctl
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

     ### Hyprland ###
     waybar
     hyprpaper
     hyprpicker
     hyprshot
     grim
     slurp
     rofi
     kitty
     swww
     pywal

     ### Importantes ###
     kate
     ventoy-full
     nemo
     ranger
     htop
     btop
     cheese
     qbittorrent

     ### Biito ###
     neofetch
     papirus-icon-theme

     ### Bão ###
     discord-ptb
     spotify
     thokr

     ### Estudo ###
     obsidian
     anki-bin
     #blender

     ### Escritorio ###
     libreoffice-qt
     hunspell
     #krita
     evince

     ### Desenvolvimento ###
     gcc
     gnumake
     cmake
     python313
     arduino
     arduino-ide

     ### Jogos ###
     mgba
     snes9x-gtk
     pcsx2
     mangohud

     ### Wine ###
     wineWowPackages.waylandFull
     winetricks
     vkd3d
     vulkan-tools
  ];

  system.stateVersion = "24.11";

}
