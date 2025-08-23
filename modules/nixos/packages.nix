{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # system
    base16-schemes
    curl
    nh
    wget

    # apps
    brave
    claude-code
    code-cursor
    discord
    ghostty
    gitkraken
    jetbrains.datagrip
    lazydocker
    lazygit
    obsidian
    opencode
    proton-pass
    protonmail-desktop
    protonvpn-gui
    remmina
    typora
    wrangler
    zed-editor

    # modern cli tools
		atac
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
		awscli2
		aws-sam-cli
    devenv
		# python
    poetry
		# rust
		cargo
		clippy
		rust-analyzer
		rustc
		rustfmt
  ];
}
