{pkgs, ...}:
with pkgs; [
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

  # Wayland/Hyprland
  kdePackages.polkit-kde-agent-1
  mako
  rofi-wayland
  waybar
  wl-clipboard
]
