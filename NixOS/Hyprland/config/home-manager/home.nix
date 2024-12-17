{ config, pkgs, ... }:

{
  home.username = "kadu";
  home.homeDirectory = "/home/kadu";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    #vim
  ];

  home.file = {

  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.vim = {
    enable = true;
    settings = {
      number = true;
    };
  };

  programs.git = {
    enable = true;
    userName = "Carlos Eduardo Porto Da Hora";
    userEmail = "carlosportomanduca@gmail.com";
  };

  programs.home-manager.enable = true;
}
