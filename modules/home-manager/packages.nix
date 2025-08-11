{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.polkit-kde-agent-1
    nerd-fonts.jetbrains-mono
    swaybg
    hyprpaper
    wl-clipboard
    wlogout
  ];
}
