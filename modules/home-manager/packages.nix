{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.polkit-kde-agent-1
    nerd-fonts.jetbrains-mono
    swaybg
    hyprpaper
    wl-clipboard
    wlogout

    # LSP servers
    nixd
    basedpyright
    nodePackages.typescript-language-server
    nodePackages.typescript
    rust-analyzer

    # Rust tooling
    cargo
    rustc
    rustfmt
    clippy
  ];
}
