{ ... }:
{
  services.xserver = {
    enable = true;
    xkb.layout = "gb";
    xkb.variant = "";
    dpi = 116; # change depending on resolution
  };
}

