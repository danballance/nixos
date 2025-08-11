{ pkgs, ... }:
{
    programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 0;

        modules-left = ["hyprland/workspaces"];
        modules-center = ["hyprland/window"];
        modules-right = ["network" "cpu" "memory" "battery" "clock" "tray"];

        "hyprland/workspaces" = {
          disable-scroll = true;
          on-click = "activate";
          format = "{icon}";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "10" = "0";
          };
          "persistent-workspaces" = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
            "6" = [];
            "7" = [];
            "8" = [];
            "9" = [];
            "10" = [];
          };
        };

        "hyprland/window" = {
          format = "{}";
          max-length = 75;
        };

        tray = {
          icon-size = 14;
          spacing = 14;
        };

        cpu = {
          interval = 5;
          format = "󰍛";
          on-click = "alacritty -e btop";
        };

        clock = {
          format = "{:%A %H:%M}";
          format-alt = "{:%d %B W%V %Y}";
          tooltip = false;
          on-click-right = "~/.local/share/omarchy/bin/omarchy-cmd-tzupdate";
        };

        memory = {
          format = "/ M {}%";
        };

        battery = {
          format = "{capacity}% {icon}";
          format-discharging = "{icon}";
          format-charging = "{icon}";
          format-plugged = "";
          format-icons = {
            charging = [
              "󰢜"
              "󰂆"
              "󰂇"
              "󰂈"
              "󰢝"
              "󰂉"
              "󰢞"
              "󰂊"
              "󰂋"
              "󰂅"
            ];
            default = [
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
          };
          format-full = "󰂅";
          tooltip-format-discharging = "{power:>1.0f}W↓ {capacity}%";
          tooltip-format-charging = "{power:>1.0f}W↑ {capacity}%";
          interval = 5;
          states = {
            warning = 20;
            critical = 10;
          };
        };

        network = {
          format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          format = "{icon}";
          format-wifi = "{icon}";
          format-ethernet = "󰀂";
          format-disconnected = "󰖪";
          tooltip-format-wifi = "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-ethernet = "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-disconnected = "Disconnected";
          interval = 3;
          nospacing = 1;
          on-click = "alacritty --class=Impala -e impala";
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 4;
        min-height: 0px;
        font-family: CaskaydiaMono Nerd Font Propo;
        font-size: 16px;
      }

      .modules-left {
        margin-left: 8px;
      }

      .modules-right {
        margin-right: 8px;
      }

      window#waybar {
        background-color: rgba(0,0,0,0.8);
        border-bottom: 0px solid #ffffff;
        background-color: transparent;
        transition-property: background-color;
        transition-duration: .5s;
      }

      #workspaces button {
        padding: 0px 0.4em;
        background-color: transparent;
        color: #ffffff;
        box-shadow: inset 0px -3px transparent;
      }

      #workspaces button:hover {
        background: rgba(0,0,0,0.2);
        box-shadow: inset 0px -3px #ffffff;
      }

      #workspaces button:focus {
        background-color: #64727d;
      }

      #tray,
      #cpu,
      #battery,
      #network,
      #bluetooth,
      #pulseaudio,
      #clock {
        min-width: 12px;
        margin: 0px 7.5px;
      }

      tooltip {
        padding: 2px;
      }
    '';
  };

  #services.mako = {
  #  enable = true;
  #  defaultTimeout = 5000;
  #  ignoreTimeout = true;
  #  layer = "overlay";
  #  maxVisible = 5;
  #  sort = "-time";
  #};

  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      layer-shell = true;
      layer = "overlay";
      control-center-layer = "top";
      widgets = ["mpris" "dnd" "title" "notifications" "inhibitors" "backlight" "volume"];
      widget-config = {
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = "";
        };
        dnd = {
          text = " DND";
        };
        mpris = {
          image-size = 60;
          image-radius = 12;
        };
      };
    };
  };

}
