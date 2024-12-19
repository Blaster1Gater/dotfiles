{ config, pkgs, ... }:

{
  home.username = "kadu";
  home.homeDirectory = "/home/kadu";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    #vim
    #git
    #kitty
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
    userName = "Blaster1Gater";
    userEmail = "carlosportomanduca@gmail.com";
  };

  programs.kitty = {
    enable = true;
    extraConfig = "
      background_opacity 0.5
      \n
      confirm_os_window_close 0
    ";
  };

  stylix = {
      enable = true;
      autoEnable = true;
      image = ./w.png;
      base16Scheme = {
        base00 = "282828";
        base01 = "3c3836";
        base02 = "504945";
        base03 = "665c54";
        base04 = "bdae93";
        base05 = "d5c4a1";
        base06 = "ebdbb2";
        base07 = "fbf1c7";
        base08 = "fb4934";
        base09 = "fe8019";
        base0A = "fabd2f";
        base0B = "b8bb26";
        base0C = "8ec07c";
        base0D = "83a598";
        base0E = "d3869b";
        base0F = "d65d0e";
      };
      polarity = "dark";

      iconTheme.enable = true;
      iconTheme.package = "papirus";

      opacity.terminal = 0.5;

      targets.waybar.enable = true;
      targets.rofi.enable = true;
      targets.hyprland.enable = true;
      targets.gtk.enable = true;
      targets.gnome.enable = true;
    };

  programs.home-manager.enable = true;
}
