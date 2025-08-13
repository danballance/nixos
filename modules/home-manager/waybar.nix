{...}: {
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
        modules-right = ["wlr/taskbar" "network" "cpu" "memory" "battery" "clock" "tray"];

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

        "wlr/taskbar" = {
          format = "{icon}";
          all-outputs = true;
          active-first = true;
          tooltip-format = "{name}";
          on-click = "activate";
          on-click-middle = "close";
          ignore-list = [
            "rofi"
          ];
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
      /* -- Global rules -- */
      * {
        border: none;
        font-family: "JetbrainsMono Nerd Font";
        font-size: 15px;
        min-height: 10px;
      }

      window#waybar {
        background: rgba(34, 36, 54, 0.6);
      }

      window#waybar.hidden {
        opacity: 0.2;
      }

      /* - Genera rules for visible modules -- */
      #custom-archicon,
      #clock,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #idle_inhibitor,
      #pulseaudio,
      #pulseaudio_slider,
      #network,
      #language {
        color: #161320;
        margin-top: 6px;
        margin-bottom: 6px;
        padding-left: 10px;
        padding-right: 10px;
        transition: none;
      }

      /* Separation to the left */
      #custom-archicon,
      #cpu,
      #idle_inhibitor {
        margin-left: 5px;
        border-top-left-radius: 10px;
        border-bottom-left-radius: 10px;
      }

      /* Separation to the rigth */
      #clock,
      #temperature,
      #language {
        margin-right: 5px;
        border-top-right-radius: 10px;
        border-bottom-right-radius: 10px;
      }

      /* -- Specific styles -- */

      /* Modules left */
      #custom-archicon {
        font-size: 20px;
        color: #89B4FA;
        background: #161320;
        padding-right: 17px;
      }

      #clock {
        background: #ABE9B3;
      }

      #cpu {
        background: #96CDFB;
      }

      #memory {
        background: #DDB6F2;
      }

      #disk {
        background: #F5C2E7;
      }

      #temperature {
        background: #F8BD96;
      }

      /* Modules center */
      #workspaces {
        background: rgba(0, 0, 0, 0.5);
        border-radius: 10px;
        margin: 6px 5px;
        padding: 0px 6px;
      }

      #workspaces button {
        color: #B5E8E0;
        background: transparent;
        padding: 4px 4px;
        transition: color 0.3s ease, text-shadow 0.3s ease, transform 0.3s ease;
      }

      #workspaces button.occupied {
        color: #A6E3A1;
      }

      #workspaces button.active {
        color: #89B4FA;
        text-shadow: 0 0 4px #ABE9B3;
      }

      #workspaces button:hover {
        color: #89B4FA;
      }

      #workspaces button.active:hover {}

      /* Modules right */
      #taskbar {
        background: transparent;
        border-radius: 10px;
        padding: 0px 5px;
        margin: 6px 5px;
      }

      #taskbar button {
        padding: 0px 5px;
        margin: 0px 3px;
        border-radius: 6px;
        transition: background 0.3s ease;
      }

      #taskbar button.active {
        background: rgba(34, 36, 54, 0.5);
      }

      #taskbar button:hover {
        background: rgba(34, 36, 54, 0.5);
      }

      #idle_inhibitor {
        background: #B5E8E0;
        padding-right: 15px;
      }

      #pulseaudio {
        color: #1A1826;
        background: #F5E0DC;
      }

      #pulseaudio_slider {
        color: #1A1826;
        background: #E8A2AF;
      }

      #network {
        background: #CBA6F7;
        padding-right: 13px;
      }

      #language {
        background: #A6E3A1;
        padding-right: 15px;
      }

      /* === Optional animation === */
      @keyframes blink {
        to {
          background-color: #BF616A;
          color: #B5E8E0;
        }
      }

    '';
  };
}
