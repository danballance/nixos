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
        "$mainMod, T, execr, zellij a default || zellij -s default" # [T]erminal
        "$mainMod, B, exec, zen-twilight" # [B]rowser
        "$mainMod, F, exec, nautilus" # [F]ile explorer
        "$mainMod, N, execr, zellij a nixos || zellij -s nixos -n nixos" # [N]ixos
        "$mainMod, L, exec, rofi -show drun" # app [L]auncher
        "$mainMod, Q, killactive" # [Q]uit window
        "$mainMod, X, exit" # e[X]it hyprland

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
        spacing = 4;

        modules-left = ["hyprland/workspaces"];
        modules-center = ["hyprland/window"];
        modules-right = ["network" "cpu" "memory" "battery" "clock" "tray"];

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "6" = "";
            "7" = "";
            "8" = "";
            "9" = "";
            "10" = "";
            default = "";
          };
        };

        "hyprland/window" = {
          format = "{}";
          max-length = 75;
        };

        tray = {
          spacing = 10;
        };

        clock = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };

        cpu = {
          format = "CPU|{usage}% ";
          tooltip = false;
        };

        memory = {
          format = "RAM|{}% ";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = ["" "" "" "" ""];
        };

        network = {
          format-wifi = "{essid}|{signalStrength}% ";
          format-ethernet = "{ipaddr}/{cidr} ";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
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
  ];

  stylix.targets.vscode.profileNames = [
    "default"
    "js"
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
          fill-labs.dependi
          mkhl.direnv
        ];
        userSettings = {
          "editor.formatOnSave" = true;
          "[typescriptreact]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
        };
      };
      rust = {
        extensions = with pkgs.vscode-marketplace; [
          anthropic.claude-code
          esbenp.prettier-vscode
          redhat.vscode-yaml
          jnoortheen.nix-ide
          fill-labs.dependi
          tamasfe.even-better-toml
          rust-lang.rust-analyzer
          mkhl.direnv
        ];
        userSettings = {};
      };
    };
  };
}
