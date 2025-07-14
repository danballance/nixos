{
  description = "Entrypoint flake";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    stylix.url = "github:nix-community/stylix";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = { self, home-manager, nixpkgs, nixvim, stylix, nix-vscode-extensions, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Overlays - packages installed via base.nix
        {
          nixpkgs.overlays = [
            nix-vscode-extensions.overlays.default
          ];
        }

        # Base config
        ./modules/system/base.nix
      
        # Enable Gnome + config
	./modules/system/gnome.nix

        # Home Manager
	home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
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

