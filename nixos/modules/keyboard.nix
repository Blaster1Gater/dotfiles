{ config, pkgs, ... }:

{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk             # alternatively, kdePackages.fcitx5-qt
      fcitx5-chinese-addons  # table input method support
      fcitx5-nord            # a color theme
      fcitx5-rime
      fcitx5-mozc
      rime-data
      fcitx5-configtool
   ];
 };

 #i18n.inputMethod = {
 # enable = true;
 # type = "ibus";
 # ibus.engines = with pkgs.ibus-engines; [ /* any engine you want, for example */ anthy ];
 #};

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br, ru";
    variant = "abnt2, phonetic";
    model = "abnt2";
    options = "grp:alt_shift_toggle";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";
}
