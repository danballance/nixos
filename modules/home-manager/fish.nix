{ ... }:
{
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
}

