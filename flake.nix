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

  outputs = {
    self,
    home-manager,
    nixpkgs,
    #stylix,
    nix-vscode-extensions,
    nvf,
    ...
  } @ inputs: {
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
        #./modules/system/gnome.nix

        # hyprland
        ./modules/system/hyprland.nix

        # neovim
        nvf.nixosModules.default

        # Home Manager
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.sharedModules = [];
          home-manager.extraSpecialArgs = {
            inherit inputs;
          };
          home-manager.users.anoni = ./home.nix;
        }

        # Stylix - make it pretty
        #stylix.nixosModules.stylix
        #./modules/system/stylix.nix
      ];

      specialArgs = {inherit inputs;};
    };
  };
}
