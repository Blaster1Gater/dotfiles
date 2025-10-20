{ config, pkgs, ... }:

{
  # Enable the KDE Desktop Environment.
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
  };
}
