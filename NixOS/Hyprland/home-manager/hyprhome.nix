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
  
  wayland.windowManager.hyprland.settings = {
    enable = true;
    "$mod" = "SUPER";

    # Monitor configuration
    monitor = [
        "eDP-1, 1920x1080@60, 0x0, 1"
        # "HDMI-A-1, preferred, 0x0, 1"
        # "HDMI-A-1, 1920x1080, 0x0, 1, mirror, eDP-1"
    ];

    exec-once = [
        "nm-applet &"
        "waybar & hyprpaper &"
    ];

    env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
    ];

    bind = [
        # APPS
        "$mainMod, T, exec, $terminal"
        "$mainMod, RETURN, exec, $terminal"
        "$mainMod, BACKSPACE, killactive"
        "$mainMod, X, killactive"
        "$mainMod, M, exit"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating"
        "$mainMod, D, exec, $menu"
        "$mainMod, F, exec, firefox"
        "$mainMod, Q, exec, $web"
        "$mainMod, R, exec, $power"
        "$mainMod, P, pseudo"
        "$mainMod, J, togglesplit"
        "$mainMod, C, exec, grim -g \"$(slurp)\""
        "$mainMod, O, exec, hyprshot -m output -m active -f \"$(date).png\""
        "$mainMod, A, exec, hyprpicker -a"
        "$mainMod, W, exec, ~/.scripts/randwall.sh"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Example special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Move windows with SUPER + SHIFT + arrow keys
        "SUPER SHIFT, left, movewindow, l"
        "SUPER SHIFT, right, movewindow, r"
        "SUPER SHIFT, up, movewindow, u"
        "SUPER SHIFT, down, movewindow, d"

        # Resize active window with mainMod + CTRL + arrow keys
        "$mainMod CTRL, right, resizeactive, 10 0"
        "$mainMod CTRL, left, resizeactive, -10 0"
        "$mainMod CTRL, up, resizeactive, 0 -10"
        "$mainMod CTRL, down, resizeactive, 0 10"
      ];

    bindel = [
        # Laptop multimedia keys for volume and LCD brightness
        ",XF86AudioRaiseVolume, exec, amixer set Master 5%+"
        ",XF86AudioLowerVolume, exec, amixer set Master 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    general = {
      gaps_in = 0;
      gaps_out = 0;

      border_size = 4;

      # Configuração de cores para bordas ativas e inativas
      "col.active_border" = "rgba(ff0000ff) rgba(ff0000ff) 45deg";
      "col.inactive_border" = "rgba(595959aa)";

      # Permite redimensionar janelas clicando nas bordas
      resize_on_border = true;

      # Evita tearing
      allow_tearing = false;

      # Define o layout padrão
      layout = "dwindle";
    };

    decoration = {
      rounding = 0;

      # Transparência das janelas
      active_opacity = 1.0;
      inactive_opacity = 1.0;

      # Configuração do blur
      blur = {
        enabled = false;
        size = 3;
        passes = 1;
        vibrancy = 0.1696;
      };
    };

    animations = {
        enabled = true;

        # Curva Bezier personalizada
        bezier = [ "myBezier, 0.05, 0.9, 0.1, 1.05" ];

        # Animações padrão
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

    dwindle = { pseudotile = true; preserve_split = true; };
    master = { new_status = "master"; };
    misc = { force_default_wallpaper = -1; disable_hyprland_logo = false; };

    input = {
        kb_layout = "br";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";

        follow_mouse = 1;

        sensitivity = 0;  # -1.0 - 1.0, 0 significa sem modificação

        touchpad = {
          natural_scroll = false;
        };
      };
    gestures = {
        workspace_swipe = false;  # Desativa o gesto para troca de workspace
      };

    device = [
      { name = "epic-mouse-v1"; sensitivity = -0.5; }
    ];

    extraConfig = ''
      $terminal = kitty
      $fileManager = nemo
      #$menu = rofi -show drun
      $menu = ~/.config/rofi/scripts/launcher_t3
      $power = ~/.config/rofi/scripts/powermenu_t1
      $web = bash ~/.config/rofi/web.sh
    '';

  };

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

  programs.kitty = {
    enable = true;
    extraConfig = "
      background_opacity 0.5
      \n
      confirm_os_window_close 0
    ";
  };

  programs.home-manager.enable = true;
}
