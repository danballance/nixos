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

			{
				plugin = lualine-nvim;
				config = toLuaFile ../../assets/nvim/plugin/lualine.lua;
			}

			{
				plugin = oil-nvim;
				config = toLua "require(\"oil\").setup()";
			}

			{
        plugin = telescope-nvim;
        config = toLuaFile ../../assets/nvim/plugin/telescope.lua;
      }
      telescope-fzf-native-nvim

		];
  };
}
