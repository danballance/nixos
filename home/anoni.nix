{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../modules/home-manager/broot.nix
    ../modules/home-manager/codex.nix
    ../modules/home-manager/direnv.nix
    ../modules/home-manager/fish.nix
    ../modules/home-manager/git.nix
    ../modules/home-manager/hyprland.nix
    ../modules/home-manager/lazydocker.nix
    ../modules/home-manager/neovim.nix
    ../modules/home-manager/packages.nix
    ../modules/home-manager/rofi.nix
    ../modules/home-manager/swaync.nix
    ../modules/home-manager/starship.nix
    ../modules/home-manager/vscode.nix
    ../modules/home-manager/waybar.nix
    ../modules/home-manager/zellij.nix
    ../modules/home-manager/zen-browser.nix
    ../modules/home-manager/catppuccin.nix
  ];

  home.stateVersion = "25.05";
  home.shell.enableFishIntegration = true;
  programs.home-manager.enable = true;
}
