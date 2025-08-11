# NixOS Configuration

This repository contains a modular NixOS and Home Manager setup.

## Structure

- `hosts/desktop/default.nix` – NixOS configuration for the desktop host.
- `home/anoni.nix` – Home Manager configuration for the `anoni` user.
- `modules/nixos/` – reusable NixOS modules.
- `modules/home-manager/` – reusable Home Manager modules.

## Usage

Rebuild the system:

```bash
sudo nixos-rebuild switch --flake .#desktop
```

Apply only the user configuration:

```bash
home-manager switch --flake .#anoni@desktop
```
