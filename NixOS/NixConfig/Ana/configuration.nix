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
  users.users.ana = {
    isNormalUser = true;
    description = "Ana Clara Batista da Silva";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  # Habilitando o GDM
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable automatic login for the user.
  services.displayManager.autoLogin = { enable = true; user = "ana"; };

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

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.nix-ld.enable = true;

  # Instalando aplicativos
  environment.systemPackages = with pkgs; [    
     ### Essencial para o funcionamento ###
     home-manager
     firefox
     brave
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

     ### Importantes ###
     kate
     htop
     btop
     qbittorrent

     ### Biito ###
     neofetch
     papirus-icon-theme
     adwaita-icon-theme

     ### Bão ###
     discord-ptb
     spotify
     thokr
     telegram-desktop

     ### Estudo ###
     obsidian
     anki-bin

     ### Escritorio ###
     libreoffice-qt
     hunspell
     evince

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
