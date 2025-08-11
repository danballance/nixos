{ pkgs, inputs, ... }:
{
  imports = [ inputs.zen-browser.homeModules.beta ];

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
        dnd.text = " DND";
        mpris = {
          image-size = 60;
          image-radius = 12;
        };
      };
    };
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    kdePackages.polkit-kde-agent-1
    nerd-fonts.jetbrains-mono
    swaybg
    swaynotificationcenter
    waybar
    wl-clipboard
    wlogout
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

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zellij = {
    enable = true;
    enableFishIntegration = false;
    attachExistingSession = true;
    layouts = {
      "nixos" = ../../assets/zellij/layouts/nixos.kdl;
    };
  };

  programs.zen-browser = {
    enable = true;
    nativeMessagingHosts = [ pkgs.firefoxpwa ];
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
          Value = false;
          Status = "locked";
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
