{
  description = "Entrypoint flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    #stylix.url = "github:nix-community/stylix";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nvf.url = "github:notashelf/nvf";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, home-manager, nixpkgs, nix-vscode-extensions, nvf, ... } @ inputs:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [ ./hosts/nixos ];
      };

      homeConfigurations."anoni@nixos" = home-manager.lib.homeManagerConfiguration {
        inherit system;
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./home/anoni.nix ];
      };
    };
}
