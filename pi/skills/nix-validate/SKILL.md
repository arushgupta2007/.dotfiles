---
name: nix-validate
description: Validate Nix flake or module changes locally. Use when modifying any Nix file in the dotfiles repo.
---

# Nix Validation Workflow

Before claiming a Nix change works, run the smallest meaningful check.

## Levels of validation

1. **Format**
   ```bash
   nix fmt
   ```
2. **Static analysis**
   ```bash
   nix flake check --no-build --show-trace
   ```
3. **System evaluation**
   ```bash
   nixos-rebuild build --flake .#framework-laptop
   ```
4. **Home Manager evaluation** (HM-only changes)
   ```bash
   nix build .#homeConfigurations.arush@framework-laptop --no-link
   ```
5. **Module dry-run**
   ```bash
   nix-instantiate --eval -E '(import ./hosts/framework-laptop).config.system.build.toplevel.drvPath'
   ```

## Common failure modes

- `error: attribute 'X' missing` — check the option name in
  `/etc/nixos-options.json` or the upstream source.
- `error: undefined variable` — confirm imports / `lib` / `pkgs` are
  in scope.
- `collision` between two modules defining the same option — use
  `lib.mkForce` or `lib.mkOverride`.

## After validation passes

Report:
- Which checks ran.
- The actual exit status of each.
- Any warnings, even if non-fatal.
