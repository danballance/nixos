{pkgs, ...}:
with pkgs; [
  # system
  base16-schemes
  curl
  nh
  wget

  # apps
  claude-code
  ghostty
  gitkraken
  lazydocker
  lazygit
  obsidian
  remmina
  wrangler

  # modern cli tools
  bat
  broot
  curlie
  delta
  doggo
  duf
  dust
  fd
  fzf
  glances
  gping
  httpie
  lsd
  procs
  ripgrep
  xh
  zoxide

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
