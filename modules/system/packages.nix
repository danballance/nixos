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
  jetbrains.datagrip
  lazydocker
  lazygit
  obsidian
  proton-pass
  protonmail-desktop
  protonvpn-gui
  remmina
  typora
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
  jq
  lsd
  procs
  ripgrep
  xh
  zoxide

  # dev
  devenv
  poetry
  termshark
  tshark
  wireshark

  # Wayland/Hyprland
  kdePackages.polkit-kde-agent-1
  mako
  rofi-wayland
  waybar
  wl-clipboard
]
