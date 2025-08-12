{pkgs, ...}: {
  programs.zellij = {
    enable = true;
    layouts = {
      "nixos" = ../../assets/zellij/layouts/nixos.kdl;
    };
  };
}
