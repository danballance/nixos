{pkgs, ...}:
with pkgs; [
  # system
  base16-schemes
  curl
  nh
  wget

  # apps
  claude-code
  code-cursor
  discord
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
  zed-editor

  # modern cli tools
  atop
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
  nmon
  procs
  ripgrep
  xh
  yazi

  # dev
  devenv
  poetry
]
