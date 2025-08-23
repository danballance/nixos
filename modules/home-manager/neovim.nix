{
  config,
  pkgs,
	inputs,
  ...
}: {

  programs.neovim = let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = ''
      ${builtins.readFile ../../assets/nvim/options.lua}
      ${builtins.readFile ../../assets/nvim/keybinds.lua}
    '';

    plugins = with pkgs.vimPlugins; [
      {
        plugin = claude-code-nvim;
        config = toLuaFile ../../assets/nvim/plugin/claude-code.lua;
      }
      cmp-nvim-lsp
      cmp-buffer
      cmp_luasnip
      cmp-path
      friendly-snippets
      {
        plugin = lualine-nvim;
        config = toLuaFile ../../assets/nvim/plugin/lualine.lua;
      }
      luasnip
			mini-icons
      {
        plugin = nvim-lspconfig;
        config = toLuaFile ../../assets/nvim/plugin/lsp.lua;
      }
      {
        plugin = nvim-cmp;
        config = toLuaFile ../../assets/nvim/plugin/cmp.lua;
      }
      {
        plugin = (nvim-treesitter.withAllGrammars);
        config = toLuaFile ../../assets/nvim/plugin/treesitter.lua;
      }
      {
        plugin = oil-nvim;
        config = toLua "require(\"oil\").setup()";
      }
			telescope-fzf-native-nvim
      {
        plugin = telescope-nvim;
        config = toLuaFile ../../assets/nvim/plugin/telescope.lua;
      }
			which-key-nvim
    ];
  };
}
