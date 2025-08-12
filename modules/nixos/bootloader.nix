{ ... }:
{
  boot.loader = {
    grub.gfxmodeEfi = "1024x768";
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
}

