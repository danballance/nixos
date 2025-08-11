{
  description = "Modular NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nvf.url = "github:notashelf/nvf";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, home-manager, nvf, ... }@inputs:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./hosts/desktop/default.nix
        nvf.nixosModules.default
      ];
      specialArgs = { inherit inputs; };
    };

    homeConfigurations."anoni@desktop" =
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./home/anoni.nix ];
      };
  };
}
