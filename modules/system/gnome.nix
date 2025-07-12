{ lib, ... }:

{
  # Enable the GNOME Desktop Environment and its display manager (GDM).
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
}

