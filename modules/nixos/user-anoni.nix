{ pkgs, ... }:
{
  users.users.anoni = {
    isNormalUser = true;
    description = "Anoni";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };
}

