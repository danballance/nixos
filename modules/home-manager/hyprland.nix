{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
		systemd.enable = false;

    settings = {
      monitor = [ ",preferred,auto,auto" ];
      input = {
        kb_layout = "gb";
        follow_mouse = 1;
        touchpad = { natural_scroll = true; };
      };
      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 2;
        layout = "dwindle";
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      "$mainMod" = "SUPER";
      bind = [
        "$mainMod, B, exec, zen"
        "$mainMod, D, exec, datagrip"
        "$mainMod, F, exec, nautilus"
        "$mainMod, G, exec, gitkraken"
        "$mainMod, L, exec, rofi -show drun"
        "$mainMod, Q, killactive"
        "$mainMod, T, execr, ghostty"
        "$mainMod, V, execr, remmina"
        "$mainMod, X, exit"
        ", XF86PowerOff, exec, wlogout"
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
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      exec-once = [
        "waybar"
        "swaync"
        "/usr/lib/polkit-kde-authentication-agent-1"
        "hyprpaper"
      ];
    };
  };
}
