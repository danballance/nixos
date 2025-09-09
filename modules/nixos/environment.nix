{ ... }:
{
  environment.variables.EDITOR = "vim";
  ##  Allow ozone support for electron apps
  environment.variables.NIXOS_OZONE_WL = "1";
  environment.variables.OZ_ENABLE_WAYLAND = "1";
}

