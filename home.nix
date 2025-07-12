{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "anoni";
  home.homeDirectory = "/home/anoni";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    extraConfig = {
      user.name = "Anoni Mouse";
      user.email = "nixprivacy@pm.me";
      init.defaultBranch = "main";
    };
  };

  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;
    plugins.lualine.enable = true;
  };
}
