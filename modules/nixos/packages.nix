{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # system
    base16-schemes
    curl
    nh
    wget

    # apps
		aseprite
    brave
    claude-code
    code-cursor
    discord
    ghostty
    gitkraken
    jetbrains.datagrip
		jetbrains.pycharm-professional
    jetbrains.rust-rover
		libresprite
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
		atuin
    atop
		bandwhich
    bat
		below
    broot
    curlie
    delta
    doggo
    duf
    dust
    fd
    fzf
		gobang
    gping
    httpie
    jq
    lazydocker
    lazygit
		lazyjournal
		lazysql
		ldtk
		lnav
    lsd
    nmon
    procs
    ripgrep
		systemctl-tui
		unzip
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
		gcc
		rust-analyzer
		rustc
		rustfmt
  ];
}
