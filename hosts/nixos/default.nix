{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/base.nix
    ../../modules/nixos/hyprland.nix
    inputs.nvf.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
  ];

  nixpkgs.overlays = [ inputs.nix-vscode-extensions.overlays.default ];

  networking.hostName = "nixos";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };
    users.anoni = import ../../home/anoni.nix;
  };
}
