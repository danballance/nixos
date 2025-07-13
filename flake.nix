{
  description = "Entrypoint flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    stylix.url = "github:nix-community/stylix/release-25.05";
  };

  outputs = { self, home-manager, nixpkgs, nixvim, stylix, ... }@inputs: {

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Base config
        ./modules/system/base.nix
      
        # Enable Gnome + config
	./modules/system/gnome.nix

        # Home Manager
	home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.sharedModules = [
            nixvim.homeManagerModules.nixvim
          ];
	  home-manager.extraSpecialArgs = {
	    inherit inputs;
	  };
          home-manager.users.anoni = ./home.nix;
        }

        # Stylix - make it pretty
        stylix.nixosModules.stylix
        ./modules/system/stylix.nix
      ];
    };

  };
}

