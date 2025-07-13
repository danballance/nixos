{ config, pkgs, ... }:

{
  imports = [
    ../../hardware-configuration.nix
  ];

  # --- Bootloader ---
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # --- Networking ---
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # --- Localization & Time ---
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };
  console.keyMap = "uk";

  # --- Core Services ---
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Enable sound with PipeWire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable printing.
  services.printing.enable = true;

  # --- User Account ---
  users.users.anoni = {
    isNormalUser = true;
    description = "Anoni";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # --- System-wide Packages & Settings ---
  nixpkgs.config.allowUnfree = true;

  # Enable flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.download-buffer-size = 500000000; # 500 MB

  # Envrionment settings
  environment.systemPackages = with pkgs; import ./packages.nix { inherit pkgs; };
  environment.variables.EDITOR = "vim";

  # --- System State ---
  # This should be set once and not changed.
  system.stateVersion = "25.05";
}

