{ config, pkgs, ... }:

{
  services.xserver.displayManager.gdm.enable = true;

  # Habilitando o Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
