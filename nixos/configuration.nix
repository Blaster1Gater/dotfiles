{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/config.nix
      ./modules/user.nix
      ./modules/pkgs.nix
      ./modules/fonts.nix
      ./modules/hypr.nix
      #./modules/kde_sddm.nix
      ./modules/gnome_gdm.nix
      #./modules/i3.nix
      ./modules/audio.nix
      ./modules/locate.nix
      ./modules/bootloader.nix
      ./modules/net.nix
      ./modules/keyboard.nix
      ./modules/flatpak.nix
    ];
}

