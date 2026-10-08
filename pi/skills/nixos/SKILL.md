---
name: nixos-dev
description: NixOS and Home Manager development workflows. Use when editing Nix modules, evaluating flakes, or troubleshooting rebuild errors.
---

# NixOS / Home Manager Development

This skill covers working inside the user's NixOS + Home Manager dotfiles
repo. The repository uses flakes, modular NixOS / HM layouts, and pinned
inputs. The machine is a Framework Laptop 11th Gen Intel running
nixos-unstable.

## Module layout

- `hosts/<host>/` — host-specific entrypoints. Each host has
  `default.nix` + `hardware-configuration.nix`.
- `nixos/core/` — system modules imported by every host.
- `nixos/wayland/` — desktop stack (Niri + DMS).
- `home/core/` — Home Manager modules shared by every user.
- `home/wayland/` — Niri / DMS specific HM modules.
- `templates/` — per-project `shell.nix` files.

## Required validation steps

After non-trivial edits, run all three:

```bash
nix fmt
nix flake check --no-build
nixos-rebuild build --flake .#framework-laptop
```

If only Home Manager changed, evaluate the HM configuration directly:

```bash
nix build .#homeConfigurations.arush@framework-laptop --no-link
```

## Hard rules

- **Never modify UUIDs, LUKS mappings, boot entries, or `stateVersion`.**
- **Never put secrets in `/etc/nixos` or `/nix/store`.** Use agenix.
- **Never run `nixos-rebuild switch` or `boot` without explicit approval.**
- When unsure about a flag, read `man configuration.nix` or
  `/etc/nixos-options.json` on the live system.

## Useful references

- `man nixos-rebuild`
- `man configuration.nix`
- `nix-options` (interactive option browser)
