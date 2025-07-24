{pkgs, ...}:
with pkgs; [
  # core
  base16-schemes
  claude-code
  curl
  ghostty
  gitkraken
  obsidian
  remmina
  ripgrep
  wget
  wrangler
  # dev
  devenv
  poetry
  # Wayland/Hyprland
  kdePackages.polkit-kde-agent-1
  mako
  rofi-wayland
  waybar
  wl-clipboard
]
