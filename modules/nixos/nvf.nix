{
  pkgs,
  lib,
  ...
}: {
  programs.nvf = {
    enable = true;
    settings = {
      vim.statusline.lualine.enable = true;

      # plugins
      vim.utility.oil-nvim.enable = true;
      vim.utility.undotree.enable = true;

      vim.extraPlugins = {
        claude-code = {
          package = pkgs.vimPlugins.claude-code-nvim;
          setup = ''
            require("claude-code").setup({
              window = {
                split_ratio = 0.4,
                position = "vertical",
              }
            })
          '';
        };
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
      vim.globals.have_nerd_font = true;
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
        # claude code
        {
          key = "<leader>cc";
          mode = ["n"];
          action = "<cmd>ClaudeCode<CR>";
          desc = "Toggle Claude Code";
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
        enableTreesitter = true;
        enableFormat = true;

        nix.enable = true;
        python = {
          enable = true;
          format.type = "ruff";
        };
        ts.enable = true;
        clang.enable = true;
        rust.enable = true;
        zig.enable = true;
        markdown = {
          enable = true;
          format.type = "prettierd";
        };
        bash.enable = true;
        lua.enable = true;
      };
    };
  };
}
