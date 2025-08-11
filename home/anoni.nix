{ pkgs, inputs, ... }:
{
  imports = [
    ../modules/home-manager/hyprland.nix
    ../modules/home-manager/programs.nix
  ];

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}
