{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../hardware-configuration.nix
  ];

  # Set the packages to install system-wide
  environment.systemPackages = import ./packages.nix {inherit pkgs;};

  # --- Bootloader ---
  boot.loader = {
    grub = {
      gfxmodeEfi = "1024x768";
    };
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

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
  services.xserver = {
    enable = true;
    xkb = {
      layout = "gb";
      variant = "";
    };
    dpi = 116; # change depending on resolution
  };

  # Enable sound with PipeWire.
  #services.pulseaudio.enable = false;
  #security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    #  alsa.enable = true;
    #  alsa.support32Bit = true;
    #  pulse.enable = true;
    #  jack.enable = true;
  };

  # Enable printing.
  services.printing.enable = true;

  # Ignore the physical power key to avoid unintended sleeps when it's hit;
  # this lets Hyprland remap XF86PowerOff in userland to show a dialog
  services.logind.extraConfig = ''
    HandlePowerKey=ignore
  '';

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
      vim.utility.oil-nvim.enable = true;
      vim.utility.undotree.enable = true;

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

        # standard / default lsp configs for languages
        lspconfig.enable = true;

        lspSignature.enable = true;
        inlayHints.enable = true;
        formatOnSave = true;
        trouble.enable = true;

        lightbulb.enable = false;
        nvim-docs-view.enable = false;
      };

      vim.diagnostics = {
        enable = true;
        config = {
          signs.text = lib.generators.mkLuaInline ''
            {
              [vim.diagnostic.severity.ERROR] = "󰅚 ",
              [vim.diagnostic.severity.WARN] = "󰀪 ",
            }
          '';
          underline = false;
          virtual_lines = false;
          virtual_text = true;
        };
      };

      vim.autocomplete.nvim-cmp.enable = true;

      # vim options
      ## globals
      vim.globals.mapleader = " ";
      vim.globals.maplocalleader = " ";
      vim.globals.have_nerd_font = false;
      ## keymaps
      vim.keymaps = [
        # navigation
        {
          key = "H";
          mode = ["n" "v"];
          action = "^";
          desc = "Go to start of line";
        }
        {
          key = "L";
          mode = ["n" "v"];
          action = "$";
          desc = "Go to end of line";
        }
        # split nav
        {
          key = "<leader>t";
          mode = ["n"];
          lua = true;
          action = ''
            function()
              vim.cmd.vnew()
              vim.cmd.term()
            end
          '';
          desc = "Split to terminal";
        }
        {
          key = "<C-j>";
          mode = ["n"];
          action = "<C-W><C-j>";
          desc = "Move to split below";
        }
        {
          key = "<C-k>";
          mode = ["n"];
          action = "<C-W><C-k>";
          desc = "Move to split above";
        }
        {
          key = "<C-l>";
          mode = ["n"];
          action = "<C-W><C-l>";
          desc = "Move to split on the right";
        }
        {
          key = "<C-h>";
          mode = ["n"];
          action = "<C-W><C-h>";
          desc = "Move to split on the left";
        }
        # terminal
        {
          key = "<Esc><Esc>";
          mode = ["t"];
          action = "<C-\\><C-n>";
          desc = "Exit terminal mode";
        }
        # search
        {
          key = "<leader>/";
          mode = ["n"];
          action = ":noh<CR>";
          desc = "Clear search highlight";
        }
        {
          key = "<Esc>";
          mode = ["n"];
          action = ":noh<CR>";
          desc = "Clear search highlight";
        }
        # edit
        {
          key = "K";
          mode = ["v"];
          action = ":m '<-2<CR>gv=gv";
          desc = "Move line UP";
        }
        {
          key = "J";
          mode = ["v"];
          action = ":m '>+1<CR>gv=gv";
          desc = "Move line UP";
        }
      ];
      # auto commands
      vim.autocmds = [
        {
          event = ["TextYankPost"];
          callback = lib.generators.mkLuaInline ''
            function()
              vim.hl.on_yank()
            end
          '';
          desc = "Visual indication of yanked content";
        }
      ];
      ## options
      vim.options.tabstop = 2;
      vim.options.shiftwidth = 2;
      vim.options.relativenumber = true;
      vim.options.termguicolors = true;
      vim.options.clipboard = "unnamedplus";
      vim.options.mouse = "";
      vim.options.undofile = true;
      vim.options.ignorecase = true;
      vim.options.smartcase = true;
      vim.options.signcolumn = "yes";
      vim.options.updatetime = 250;
      vim.options.timeoutlen = 300;
      vim.options.scrolloff = 10;

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
      "https://devenv.cachix.org"
      "https://nixpkgs-python.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" # Default NixOS
      "claude-code.cachix.org-1:YeXf2aNu7UTX8Vwrze0za1WEDS+4DuI2kVeWEE4fsRk=" # Claude Code
      "nix-devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=" # Nix Community
      "community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU="
    ];
  };

  # environment settings
  environment.variables.EDITOR = "vim";
  ##  Allow ozone support for electron apps
  environment.variables.ENIXOS_OZONE_WL = "1";

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
