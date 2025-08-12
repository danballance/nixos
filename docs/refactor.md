# Modular NixOS Configuration

This repository implements a modular layout that separates system configuration from user configuration.

## Layout

- `hosts/desktop/default.nix` – top-level NixOS definition for the `desktop` host. It imports hardware settings and individual service modules from `modules/nixos`.
- `home/anoni.nix` – Home Manager configuration for user `anoni` on `desktop` composed from modular program files in `modules/home-manager`.
- `modules/nixos/` – reusable NixOS modules split per program or service (e.g. `bootloader.nix`, `networking.nix`, `nixpkgs.nix`).
- `modules/home-manager/` – Home Manager modules providing Hyprland, Waybar, and individual user program settings.

## Usage

Build and activate the NixOS system:

```bash
sudo nixos-rebuild switch --flake .#desktop
```

Apply only the Home Manager configuration:

```bash
home-manager switch --flake .#anoni@desktop
```

The previous monolithic `home.nix` file has been removed. User settings now live in `home/anoni.nix` and are composed from modules in `modules/home-manager`.
