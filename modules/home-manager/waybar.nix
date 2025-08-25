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
        modules-right = ["wlr/taskbar" "network" "cpu" "memory" "battery" "clock"];

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

        cpu = {
          format = "󰍛";
        };

        clock = {
          format = "{:%A %H:%M}";
          format-alt = "{:%d %B W%V %Y}";
          tooltip = false;
        };

        memory = {
          format = "{}% ";
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
        	icon-size = 20;
          all-outputs = true;
          active-first = true;
          tooltip-format = "{title}";
          on-click = "activate";
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
			
			#battery,
      #cpu,
      #memory {
        color: #161320;
        margin-top: 6px;
        margin-bottom: 6px;
        margin-left: 0px;
        margin-right: 0px;
        padding-left: 10px;
        padding-right: 10px;
        transition: none;
        border-top-left-radius: 0px;
        border-bottom-left-radius: 0px;
        border-top-right-radius: 0px;
        border-bottom-right-radius: 0px;
      }

      /* Separation to the left */
      
			#network {
        color: #161320;
        margin-left: 5px;
        border-top-left-radius: 10px;
        border-bottom-left-radius: 10px;
      }

      /* Separation to the right */
      
			#clock {
        color: #161320;
        margin-right: 5px;
        border-top-right-radius: 10px;
        border-bottom-right-radius: 10px;
      }

      /* -- Specific styles -- */

      /* Modules left */
      
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
      
			#clock {
        background: #ABE9B3;
      }

      #cpu {
        background: #96CDFB;
      }

      #memory {
        background: #DDB6F2;
      }
      
			#network {
        background: #CBA6F7;
      }

			#taskbar {
        background: transparent;
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

    '';
  };
}
