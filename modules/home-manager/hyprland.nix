{ pkgs, ... }:
{
    wayland.windowManager.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
    };

    settings = {
      # Monitor configuration
      monitor = [
        ",preferred,auto,auto"
      ];

      # Input configuration
      input = {
        kb_layout = "gb";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
        };
      };

      # General settings
      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 2;
        layout = "dwindle";
      };

      # Window rules
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # Keybindings
      "$mainMod" = "SUPER";

      bind = [
        # Application shortcuts
        "$mainMod, B, exec, zen" # [B]rowser
        "$mainMod, D, exec, datagrip" # [D]atabase
        "$mainMod, F, exec, nautilus" # [F]ile explorer
        "$mainMod, G, exec, gitkraken" # [G]itkraken
        "$mainMod, L, exec, rofi -show drun" # app [L]auncher
        "$mainMod, Q, killactive" # [Q]uit window
        "$mainMod, T, execr, ghostty" # [T]erminal
        "$mainMod, V, execr, remmina" # [V]NC
        "$mainMod, X, exit" # e[X]it hyprland

        # Physical power button shows logout menu
        ", XF86PowerOff, exec, wlogout"

        # Switch workspaces
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

        # Move active window to workspace
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
      ];

      # Mouse bindings
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Autostart
      exec-once = [
        # start services
        "waybar"
        "swaync"
        "/usr/lib/polkit-kde-authentication-agent-1"
        "hyprpaper"
      ];
    };
  };

}
