{ config, pkgs, ... }:

{
  users.users.kadu = {
    isNormalUser = true;
    description = "Kadu";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [
    #  thunderbird
    ];
  };
}
