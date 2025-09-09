{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/boot.nix
    ../../modules/nixos/docker.nix
    ../../modules/nixos/environment.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/graphics.nix
    ../../modules/nixos/hyprland.nix
    ../../modules/nixos/localization.nix
    ../../modules/nixos/logind.nix
    ../../modules/nixos/networking.nix
    ../../modules/nixos/nix-ld.nix
    ../../modules/nixos/nixpkgs.nix
    ../../modules/nixos/packages.nix
    ../../modules/nixos/pipewire.nix
    ../../modules/nixos/printing.nix
    ../../modules/nixos/shells.nix
    ../../modules/nixos/state.nix
    ../../modules/nixos/sudo.nix
    ../../modules/nixos/user-anoni.nix
    ../../modules/nixos/xserver.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  nixpkgs.overlays = [
    inputs.nix-vscode-extensions.overlays.default
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {inherit inputs;};
    users.anoni = import ../../home/anoni.nix;
  };
}
