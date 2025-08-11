{ pkgs, inputs, ... }:
{
  imports = [
    ../modules/home-manager/hyprland.nix
    ../modules/home-manager/programs.nix
    ../modules/home-manager/packages.nix
  ];

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}
