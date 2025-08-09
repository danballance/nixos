{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

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
        "$mainMod, T, execr, ghostty" # [T]erminal
        "$mainMod, B, exec, zen-twilight" # [B]rowser
        "$mainMod, F, exec, nautilus" # [F]ile explorer
        "$mainMod, L, exec, rofi -show drun" # app [L]auncher
        "$mainMod, Q, killactive" # [Q]uit window
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
        "mako"
        "/usr/lib/polkit-kde-authentication-agent-1"
        "hyprpaper"
      ];
    };
  };

  # Waybar configuration
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

  # Mako notification daemon (styled by Stylix)
  services.mako = {
    enable = true;
    defaultTimeout = 5000;
    ignoreTimeout = true;
    layer = "overlay";
    maxVisible = 5;
    sort = "-time";
  };

  # Rofi configuration (styled by Stylix)
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    wlogout
  ];

  stylix.targets.vscode.profileNames = [
    "default"
    "js"
    "python"
    "rust"
  ];

  programs.broot = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.git = {
    enable = true;
    extraConfig = {
      user.name = "Anoni Mouse";
      user.email = "nixprivacy@pm.me";
      init.defaultBranch = "main";
    };
    delta.enable = true;
  };

  programs.fish = {
    enable = true;
    shellInit = ''
      set -gx EDITOR nvim
    '';
    plugins = [];
    shellAliases = {
      cat = "bat";
      ls = "lsd";
      find = "fd";
      ps = "procs";
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zellij = {
    enable = true;
    enableFishIntegration = false;
    attachExistingSession = true;
    layouts = {
      "nixos" = ./assets/zellij/layouts/nixos.kdl;
    };
  };

  programs.zen-browser = {
    enable = true;
    nativeMessagingHosts = [pkgs.firefoxpwa];
    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      Preferences = {
        "browser.tabs.warnOnClose" = {
          "Value" = false;
          "Status" = "locked";
        };
      };
    };
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium-fhs;
    mutableExtensionsDir = false;

    profiles = {
      js = {
        extensions = with pkgs.vscode-marketplace; [
          anthropic.claude-code
          esbenp.prettier-vscode
          redhat.vscode-yaml
          vitest.explorer
          mkhl.direnv
        ];
        userSettings = {
          "editor.formatOnSave" = true;
          "[typescriptreact]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "editor.tabSize" = 2;
        };
      };
      rust = {
        extensions = with pkgs.vscode-marketplace; [
          anthropic.claude-code
          redhat.vscode-yaml
          jnoortheen.nix-ide
          tamasfe.even-better-toml
          rust-lang.rust-analyzer
          mkhl.direnv
        ];
        userSettings = {
          #"editor.formatOnSave" = true;
          #"[rust]" = {
          #  "editor.defaultFormatter" = "esbenp.prettier-vscode";
          #};
          "editor.tabSize" = 2;
        };
      };
      python = {
        extensions = with pkgs.vscode-marketplace; [
          anthropic.claude-code
          redhat.vscode-yaml
          jnoortheen.nix-ide
          tamasfe.even-better-toml
          mkhl.direnv
          ms-python.python
          ms-python.debugpy
          ms-python.vscode-pylance
          charliermarsh.ruff
        ];
        userSettings = {
          "editor.formatOnSave" = true;
          "[python]" = {
            "editor.defaultFormatter" = "charliermarsh.ruff";
          };
          "editor.tabSize" = 4;
          "python.languageServer" = "Pylance";
          "python.analysis.autoImportCompletions" = true;
        };
      };
    };
  };
}
