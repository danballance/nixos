{
  description = "Modular NixOS configuration";

  inputs = {
    # nixos
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # home-manager
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # others
    codex.url = "github:Castrozan/codex-flake";
    codex.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    kiro.url = "github:johnkferguson/kiro-linux-flake";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
  in {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./hosts/desktop/default.nix
      ];
      specialArgs = {inherit inputs;};
    };

    homeConfigurations."anoni@desktop" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {inherit inputs;};
      modules = [./home/anoni.nix];
    };
  };
}
