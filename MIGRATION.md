# NixOS Dotfiles Migration Progress

This document tracks the migration from `~/.dotfiles-bak` (read-only reference) to
`~/.dotfiles` (new working repository).

## Hardware identification

| Property              | Value                                            |
| --------------------- | ------------------------------------------------ |
| Machine               | Framework Laptop 11th Gen Intel                  |
| CPU                   | 11th Gen Intel(R) Core(TM) i7-1185G7             |
| Graphics              | Intel Iris Xe (integrated)                       |
| RAM                   | 16 GB                                            |
| Form factor           | Laptop                                           |
| Filesystem (root)     | ext4 on LUKS `140a74ca-9420-41c4-b4a9-1e4b716141c4` |
| Boot EFI              | vfat `B678-E4D3` (fmask=0077,dmask=0077)         |
| Swap                  | LUKS `1973fde1-9894-4543-9aed-5b35a27d6c6c`      |
| Kernel                | `kvm-intel`, Intel microcode                     |
| stateVersion          | 26.11                                            |
| Time zone             | Asia/Kolkata                                     |

The new host is named `framework-laptop` in the flake even though the live
hostname is currently `desktop`. Changing the hostname requires a rebuild and
is documented in the README. The choice is arbitrary; if you prefer to keep
`desktop`, set `networking.hostName` in `hosts/framework-laptop/default.nix`.

## Phase 1 — Audit (complete)

### Identified active components in `~/.dotfiles-bak`

* `nixpkgs` (nixos-unstable), `nur`, `agenix`, `home-manager`,
  `nixos-hardware`, `alejandra`, `hyprland` (git input, but unused),
  `hyprland-plugins`, `hypr-contrib`, `hyprpicker`, `pyprland`,
  `spicetify-nix`, `nvchad4nix`, `dms` (DankMaterialShell), `danksearch`.
* `hyprland*` and `pyprland` inputs are **not imported** anywhere — leftover
  from the previous Hyprland era. Removed.
* `alejandra 3.0.0` pin is very old and superseded. Replaced with
  `pkgs.nixfmt`.
* `hosts/desktop` (the live host) actually carries the
  `framework-11th-gen-intel` `nixos-hardware` module despite being named
  "desktop". The live hostname matches `desktop`. The new flake uses
  `framework-laptop` as the host name.

### Active services and packages

* Bluetooth, NetworkManager + applet, PipeWire, Upower,
  `power-profiles-daemon`, `fprintd`, agenix (system + user), Podman
  (rootless, dockerCompat), `libvirtd`, `virt-manager`, `virtio-win`,
  `distrobox`, `swaylock-effects`.

### Duplicate / obsolete components

| Component                | Decision                                                |
| ------------------------ | ------------------------------------------------------- |
| Hyprland configs         | **Removed** — replaced by Niri                          |
| `programs.hyprland.*`    | **Removed** — was already disabled                      |
| `waybar`                 | **Removed** — DMS provides bar + widgets                |
| `rofi`                   | **Removed** — DMS provides launcher                     |
| `swaync`                 | **Removed** — DMS provides notifications                |
| `kitty`                  | **Replaced** with Ghostty                               |
| `cliphist` / `wl-clipboard` hooks | **Replaced** with DMS clipboard manager         |
| `nvchad`                 | **Removed** — bare Neovim + LSPs                        |
| `floorp-bin`             | **Removed** — secondary browser is Firefox              |
| `audacious`, `cava`      | **Kept** (music / audio visualizer)                     |
| `vesktop`, `discord`     | **Kept** (Discord with Vencord)                         |
| `ollama`                 | **Not included by default**; opt-in if needed           |
| `rclone` systemd mounts  | **Not auto-started**; opt-in via rclone config          |
| `kitty`-bound scripts    | **Ported to Ghostty**                                   |
| `gaming.nix`             | **Trimmed** to non-Steam games                          |
| `alejandra` 3.0.0       | **Replaced** with `pkgs.nixfmt`                         |
| DMS greeter (`dms.nixosModules.greeter`) | **Removed** — module deprecated; greeter moved to separate `dank-greeter` repo |

## Phase 2 — Architecture (complete)

```
~/.dotfiles
├── flake.nix                  # flake entry point
├── flake.lock                 # pinned inputs
├── hosts/
│   └── framework-laptop/
│       ├── default.nix        # host wiring
│       └── hardware-configuration.nix
├── nixos/
│   ├── core/
│   │   ├── default.nix
│   │   ├── bootloader.nix     # included in default.nix
│   │   ├── kernel.nix
│   │   ├── locale.nix
│   │   ├── networking.nix
│   │   ├── pipewire.nix
│   │   ├── bluetooth.nix
│   │   ├── power.nix
│   │   ├── nix.nix
│   │   ├── services.nix
│   │   ├── security.nix
│   │   ├── virtualization.nix
│   │   ├── podman.nix
│   │   ├── fingerprint.nix
│   │   ├── agenix.nix
│   │   └── users.nix
│   └── wayland/
│       ├── default.nix
│       ├── niri.nix
│       ├── dms.nix
│       ├── portals.nix
│       └── xwayland.nix
├── home/
│   ├── default.nix
│   ├── core/
│   │   ├── default.nix
│   │   ├── shell.nix          # zsh, zoxide, fzf, atuin, starship, direnv
│   │   ├── git.nix
│   │   ├── editor.nix         # neovim, vscodium, micro
│   │   ├── terminal.nix       # ghostty + zellij
│   │   ├── browsers.nix       # brave + firefox
│   │   ├── files.nix          # nautilus, yazi, papers, loupe, mpv, etc.
│   │   ├── dev-tools.nix
│   │   ├── communication.nix  # kde-connect, localsend
│   │   ├── backup.nix         # restic, rclone
│   │   ├── security.nix       # swaylock, gnome-keyring, gpg-agent
│   │   ├── theming.nix        # GTK / Qt / cursor / fonts
│   │   ├── agenix.nix
│   │   ├── ai.nix             # pi-coding-agent
│   │   └── platform.nix
│   └── wayland/
│       ├── default.nix
│       ├── niri.nix
│       ├── dms.nix
│       ├── niri-config.kdl
│       └── scripts/open-brave.sh
├── templates/                 # per-project dev shells
│   ├── python/shell.nix
│   ├── node/shell.nix
│   ├── rust/shell.nix
│   ├── go/shell.nix
│   ├── cpp/shell.nix
│   └── nix/shell.nix
├── secrets/
│   ├── secrets.nix
│   └── README.md
├── pi/
│   ├── AGENTS.md
│   ├── settings.json
│   ├── extensions/            # place TS extensions here
│   ├── skills/                # nixos, python, typescript, rust, go, git-review, nix-validate
│   └── prompts/               # rebuild, clean, secret
├── README.md                  # final documentation
└── MIGRATION.md               # this file
```

## Phase 3 — Implementation

Tracked in `git log` inside the new repo.

### Templates

Each `templates/<lang>/` is a **self-contained flake** with its own
`flake.nix` and `flake.lock`, using `flake-utils.lib.eachDefaultSystem`.
The legacy `shell.nix` form was removed in favour of flakes, which is the
modern Nix approach.

The main flake references each template via `path:` flake inputs and
exposes them at `devShells.x86_64-linux.<lang>` so users can still do
`nix develop .#python` from the main repo.

### Status

- [x] Audit
- [x] Architecture
- [x] Flake + host foundation
- [x] Hardware / system modules
- [x] Niri + DMS desktop
- [x] Terminal + shell
- [x] Editors + dev tools
- [x] Pi + OpenRouter
- [x] Containers + utilities
- [x] Development templates
- [x] Formatting + linting
- [x] Validation
- [ ] Documentation

## Phase 4 — Validation

### `nix flake check`

```
all checks passed!
```

### `nix build .#nixosConfigurations.framework-laptop.config.system.build.toplevel`

Full NixOS system builds cleanly:

```
/nix/store/mja6vywfzsqca37gaqbxmmy7zns8xd3i-nixos-system-framework-laptop-26.11.20261006.151fa4e
```

### `nix build` of every devShell

All six development-shell templates evaluate successfully.

### Module-level checks

- LUKS / UUIDs / filesystem layout preserved from `~/.dotfiles-bak`.
- `system.stateVersion = "26.11"` preserved.
- `nixos-hardware` Framework laptop module applied.
- Agenix wired through Home Manager and NixOS.
- Pi Coding Agent installed declaratively.

### Outstanding

- **Locale fallback**: the previous configuration set `i18n.defaultLocale = "en_IN.UTF-8"`, but the current `glibc-locales` build rejects it as "unsupported". The new configuration falls back to `C.UTF-8` as `defaultLocale` with `en_US.UTF-8` for the LC_* categories. The Asia/Kolkata timezone is preserved. If a real `en_IN.UTF-8` locale is required, the user must patch `glibc` or use a custom locale archive.

## Phase 5 — Documentation

See `README.md`.

## Decisions log

1. **Hostname `framework-laptop`.** The live hostname is `desktop`, but the
   machine is a Framework Laptop. Rename to `framework-laptop`; users can
   override in `hosts/framework-laptop/default.nix`.
2. **No DMS greeter.** The dedicated greeter moved to a separate
   `dank-greeter` repo. Logging in via TTY and starting `niri` from there is
   supported; adding the greeter is documented in the README.
3. **Ghostty over Kitty.** Ghostty has first-class Wayland + GPU support and
   integrates well with the Niri/Velocity stack.
4. **Pi Coding Agent via Nix.** The package `pi-coding-agent` exists in
   `nixpkgs-unstable` and is pinned by the lockfile. The OpenRouter API key
   is decrypted by agenix and exposed via the `OPENROUTER_API_KEY_FILE`
   environment variable; Pi reads it at startup.
5. **Ollama not enabled by default.** The previous repo auto-enabled Ollama,
   which adds background service overhead. We keep it opt-in.
6. **rclone mounts not auto-started.** systemd user mounts from the previous
   repo (`rclone-GDrive`, `rclone-ProtonDrive`) are removed; users can
   declare their own.
7. **Locale fallback.** See the "Outstanding" section above.

## Outstanding items

* Locale fallback noted above.
* Greeter is not enabled (no `dank-greeter` input).
