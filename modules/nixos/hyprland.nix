{
  pkgs,
  inputs,
  ...
}: {
  programs.hyprland.enable = true;
	programs.hyprland.withUWSM = true;

  programs.hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  environment.systemPackages = with pkgs; [
    pyprland
    hyprpicker
    hyprcursor
    hyprlock
    hypridle
    hyprpaper
  ];
}
