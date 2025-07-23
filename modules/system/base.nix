{pkgs, ...}: {
  imports = [
    ../../hardware-configuration.nix
  ];

  # Set the packages to install system-wide
  environment.systemPackages = import ./packages.nix {inherit pkgs;};

  # --- Bootloader ---
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # --- Networking ---
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # --- Localization & Time ---
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };
  console.keyMap = "uk";

  # --- Core Services ---
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Enable sound with PipeWire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable printing.
  services.printing.enable = true;

  # Shells
  programs.fish.enable = true;
  environment.shells = with pkgs; [fish];

  # fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # --- User Account ---
  users.users.anoni = {
    isNormalUser = true;
    description = "Anoni";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.fish;
  };

  programs.nvf = {
    enable = true;
    settings = {
      vim.statusline.lualine.enable = true;

      # plugins
      vim.mini = {
        ai.enable = true;
        surround.enable = true;
        pairs.enable = true;
        bracketed.enable = true;
      };

      vim.telescope = {
        enable = true;
        extensions = [
          {
            name = "fzf";
            packages = [
              pkgs.vimPlugins.telescope-fzf-native-nvim
            ];
            setup = {
              fzf = {
                fuzzy = true;
              };
            };
          }
        ];
      };

      vim.treesitter = {
        enable = true;
        highlight.enable = true;
        indent.enable = true;
        context.enable = true;
      };

      vim.lsp = {
        enable = true;
        formatOnSave = true;
        lightbulb.enable = true;
        lspSignature.enable = true;
        trouble.enable = true;
        nvim-docs-view.enable = true;
        inlayHints.enable = true;
      };

      vim.utility.preview.markdownPreview = {
        enable = true;
        lazyRefresh = true;
      };

      # options
      vim.autocomplete.nvim-cmp.enable = true;
      vim.options.tabstop = 2;
      vim.options.shiftwidth = 2;
      vim.options.relativenumber = true;
      vim.options.termguicolors = true;
      vim.options.clipboard = "unnamedplus";
      vim.options.mouse = "v";
      vim.globals.mapleader = " ";
      vim.globals.maplocalleader = " ";

      vim.languages = {
        enableLSP = true;
        enableTreesitter = true;
        enableFormat = true;

        nix.enable = true;
        python.enable = true;
        ts.enable = true;
        clang.enable = true;
        rust.enable = true;
        zig.enable = true;
        markdown.enable = true;
        bash.enable = true;
        lua.enable = true;
      };
    };
  };

  # --- System-wide Packages & Settings ---
  nixpkgs.config.allowUnfree = true;

  # Global nix settings
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    download-buffer-size = 500000000; # 500 MB
    substituters = [
      "https://cache.nixos.org" # Default
      "https://claude-code.cachix.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" # Default NixOS
      "claude-code.cachix.org-1:YeXf2aNu7UTX8Vwrze0za1WEDS+4DuI2kVeWEE4fsRk=" # Claude Code
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" # Nix Community
    ];
  };

  # environment settings
  environment.variables.EDITOR = "vim";

  # --- System State ---
  # This should be set once and not changed.
  system.stateVersion = "25.05";

  # sudo
  security.sudo = {
    enable = true;
    extraRules = [
      {
        users = ["anoni"];
        commands = ["ALL"];
      }
    ];
  };
}
