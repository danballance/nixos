{ pkgs, ... }:
{
  programs.zellij = {
    enable = true;
    enableFishIntegration = false;
    attachExistingSession = true;
    layouts = {
      "nixos" = ../../assets/zellij/layouts/nixos.kdl;
    };
  };
}

