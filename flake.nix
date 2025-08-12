{
  description = "Entrypoint flake";

  inputs = {
    # nix
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # home-manager
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # others
    hyprland.url = "github:hyprwm/Hyprland";
    kiro.url = "github:johnkferguson/kiro-linux-flake";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nvf.url = "github:notashelf/nvf";
    #stylix.url = "github:nix-community/stylix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Overlays - packages installed via base.nix
        {
          nixpkgs.overlays = [
            inputs.nix-vscode-extensions.overlays.default
          ];
        }

        # Base config
        ./modules/system/base.nix

        # Enable Gnome + config
        #./modules/system/gnome.nix

        # hyprland
        ./modules/system/hyprland.nix

        # kiro
        ./modules/system/kiro.nix

        # neovim
        inputs.nvf.nixosModules.default

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
        #inputs.stylix.nixosModules.stylix
        #./modules/system/stylix.nix
      ];

      specialArgs = {inherit inputs;};
    };
  };
}
