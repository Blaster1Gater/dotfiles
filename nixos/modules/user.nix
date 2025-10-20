{ config, pkgs, ... }:

{
  users.users.kadu = {
    isNormalUser = true;
    description = "Kadu";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.fish;
    packages = with pkgs; [
    #  thunderbird
    ];
  };
}
