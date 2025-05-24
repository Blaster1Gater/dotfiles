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
    INPUT_METHOD = "fcitx5";
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
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
      background_opacity 1
      \n
      confirm_os_window_close 0
    ";
  };

  stylix = {
      enable = true;
      autoEnable = true;
      image = ./w.png;
      base16Scheme = {
        base00 = "2E3440";
        base01 = "3B4252";
        base02 = "434C5E";
        base03 = "4C566A";
        base04 = "D8DEE9";
        base05 = "E5E9F0";
        base06 = "ECEFF4";
        base07 = "8FBCBB";
        base08 = "88C0D0";
        base09 = "81A1C1";
        base0A = "5E81AC";
        base0B = "BF616A";
        base0C = "D08770";
        base0D = "EBCB8B";
        base0E = "A3BE8C";
        base0F = "B48EAD";
      };
      polarity = "dark";

      opacity.terminal = 0.5;

      targets.waybar.enable = true;
      targets.rofi.enable = true;
      targets.hyprland.enable = true;
      targets.gtk.enable = true;
      targets.gnome.enable = true;
    };

  programs.home-manager.enable = true;
}
