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
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable Bluetooch
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  #services.blueman.enable = true;

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
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  
  fonts.packages = with pkgs; [
    font-awesome
    powerline-fonts
    powerline-symbols
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
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

  services.xserver.displayManager.gdm.enable = true;
  programs.hyprland = { enable = true; xwayland.enable = true; };

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "kadu";

  # Permitindo pacotes não livres
  nixpkgs.config.allowUnfree = true;

  # Instalando e ativando o flatpak
  services.flatpak.enable = true;
  
  services.power-profiles-daemon.enable = true;
  services.devmon.enable = true;
  services.gvfs.enable = true; 
  services.udisks2.enable = true;

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
     firefox
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
     power-profiles-daemon
     usbutils
     udiskie
     udisks
     blueberry
     gparted
     unrar
     unar
     networkmanagerapplet
     e2fsprogs
     appimage-run
     wget

     ### Hyprland ###
     waybar
     hyprpaper
     hyprpicker
     hyprshot
     grim
     slurp
     rofi
     kitty
     alacritty
     swww
     pywal

     ### Importantes ###
     kate
     ventoy-full
     nautilus
     cheese

     ### Biito ###
     neofetch

     ### Bão ###
     discord-ptb
     spotify

     ### Estudo ###
     obsidian
     anki-bin

     ### Escritorio ###
     libreoffice-qt
     hunspell
     krita
     evince

     ### Desenvolvimento ###
     gcc
     gnumake
     cmake
     arduino
     arduino-ide
     
     ### Wine ###
     wineWowPackages.waylandFull
     winetricks
  ];

  system.stateVersion = "24.11";

}
