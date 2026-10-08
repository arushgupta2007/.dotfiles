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

The new host is named `framework-laptop` in the flake even though the live hostname
is currently `desktop`. Changing the hostname is documented in the README and is
considered low risk; if you prefer to keep `desktop`, set `networking.hostName`
in `hosts/framework-laptop/default.nix`.

## Phase 1 — Audit (complete)

### Identified active components in `~/.dotfiles-bak`

* `nixpkgs` (nixos-unstable), `nur`, `agenix`, `home-manager`, `nixos-hardware`,
  `alejandra`, `hyprland` (git input, but unused), `hyprland-plugins`,
  `hypr-contrib`, `hyprpicker`, `pyprland`, `spicetify-nix`, `nvchad4nix`,
  `dms` (DankMaterialShell), `danksearch`.
* `hyprland*` and `pyprland` inputs are **not imported** anywhere — leftover from
  the previous Hyprland era. They are removed.
* `alejandra 3.0.0` pin is very old and superseded. Use `nixfmt-rfc-style`.
* `hosts/desktop` (the live host) actually carries the
  `framework-11th-gen-intel` `nixos-hardware` module despite being named "desktop".
  This is the machine to migrate.

### Active services and packages

* Bluetooth, NetworkManager + applet, PipeWire, Upower, `power-profiles-daemon`,
  `fprintd`, agenix (system + user), Podman (rootless, dockerCompat),
  `libvirtd`, `virt-manager`, `virtio-win`, `distrobox`, `swaylock-effects`.
* Home packages include many GUI/CLI tools — see `home/packages.nix` for the full
  list.

### Duplicate / obsolete components

| Component              | Decision                                                  |
| ---------------------- | --------------------------------------------------------- |
| Hyprland configs       | **Remove** — replaced by Niri                             |
| `programs.hyprland.*`  | **Remove** — was already disabled                         |
| `waybar`               | **Remove** — DMS provides bar + widgets                   |
| `rofi`                 | **Remove** — DMS provides launcher                        |
| `swaync`               | **Remove** — DMS provides notifications                   |
| `kitty`                | **Replace** with Ghostty                                  |
| `cliphist` + `wl-clipboard` hooks | **Replace** with DMS clipboard manager         |
| `fzf` widget-driven `rofi`-style picker | **Replace** with DMS launcher + `fzf`        |
| `nvchad`               | **Remove** — replaced by LazyVim-free Neovim config       |
| `floorp-bin`           | **Remove** — secondary browser is Firefox                 |
| `audacious`, `cava`    | **Keep** (music / audio visualizer)                       |
| `vesktop`, `discord`   | **Keep** but use `discord.override { withVencord = true }`|
| `ollama`               | **Keep disabled by default**, opt-in toggle               |
| `rclone` systemd units | **Keep** but mark as opt-in                               |
| `kitty`-bound scripts  | **Port to Ghostty**                                       |
| `gaming.nix`           | **Keep** for non-steam games, drop heavy Steam bits       |

### Decisions

1. Use `nixos-unstable` (matches existing repo).
2. Replace `alejandra` formatter with `nixfmt-rfc-style`.
3. Use the `nixos-hardware` module `framework-11th-gen-intel` for the host.
4. Add `home-unstable` channel for Home Manager (matches flake-utils input).
5. Remove `hyprland*` and `pyprland` inputs from the new flake.
6. Use the new `dms` Home Manager module (already proven) and DMS via `systemd`
   user service for autostart.
7. Pin `pi-coding-agent` via a maintained Nix package; treat OpenRouter key as
   agenix-managed.
8. Keep Wayland + XWayland, drop X11/X server entirely.
9. Provide development shells under `templates/` using `nix develop` and
   `direnv` integration via `nix-direnv`.

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
│   │   ├── bootloader.nix
│   │   ├── kernel.nix
│   │   ├── locale.nix
│   │   ├── networking.nix
│   │   ├── pipewire.nix
│   │   ├── bluetooth.nix
│   │   ├── power.nix
│   │   ├── nix.nix
│   │   ├── services.nix       # gvfs, dbus, keyring, fstrim, upower
│   │   ├── security.nix
│   │   ├── virtualization.nix
│   │   ├── podman.nix
│   │   ├── fingerprint.nix
│   │   ├── agenix.nix
│   │   └── session.nix        # display manager + seat
│   └── wayland/
│       ├── default.nix
│       ├── niri.nix
│       ├── dms.nix
│       ├── portals.nix
│       └── xwayland.nix
├── home/
│   ├── core/
│   │   ├── default.nix
│   │   ├── shell.nix          # zsh, zoxide, fzf, atuin, starship
│   │   ├── git.nix
│   │   ├── editor.nix         # neovim
│   │   ├── terminal.nix       # ghostty
│   │   ├── browsers.nix       # brave + firefox
│   │   ├── files.nix          # nautilus, yazi, papers, loupe, mpv, etc.
│   │   ├── dev-tools.nix      # bruno, httpie, podman-tui, lazydocker, ...
│   │   ├── communication.nix  # kde-connect, localsend
│   │   ├── backup.nix         # restic
│   │   ├── security.nix       # gnome-keyring, swaylock-effects
│   │   ├── theming.nix        # GTK / Qt / cursor / fonts
│   │   ├── agenix.nix
│   │   ├── ai.nix             # pi-coding-agent, claude-code
│   │   └── platform/
│   │       └── linux.nix      # distrobox, etc.
│   └── wayland/
│       ├── default.nix
│       ├── niri-bindings.kdl
│       ├── niri-config.kdl
│       ├── dms-bindings.kdl
│       └── ...
├── templates/
│   ├── python/flake.nix
│   ├── node/flake.nix
│   ├── rust/flake.nix
│   ├── go/flake.nix
│   ├── cpp/flake.nix
│   └── nix/flake.nix
├── secrets/
│   ├── secrets.nix
│   └── *.age
├── pi/
│   ├── AGENTS.md
│   ├── settings.json
│   └── skills/
│       ├── nixos/
│       ├── python/
│       ├── typescript/
│       ├── rust/
│       ├── go/
│       ├── git-review/
│       └── nix-validate/
├── scripts/                   # personal scripts committed declaratively
├── wallpapers/                # wallpaper assets
├── MIGRATION.md               # this file
└── README.md                  # final documentation
```

## Phase 3 — Implementation

Tracked in `git log` inside the new repo and below.

### Status

- [x] Audit
- [x] Architecture
- [ ] Flake + host foundation
- [ ] Hardware / system modules
- [ ] Niri + DMS desktop
- [ ] Terminal + shell
- [ ] Editors + dev tools
- [ ] Pi + OpenRouter
- [ ] Containers + utilities
- [ ] Development templates
- [ ] Formatting + linting
- [ ] Validation
- [ ] Documentation

## Phase 4 — Validation

See `nix flake check` and `nix build` results in the commit log.

## Phase 5 — Documentation

See `README.md` once finalised.

## Outstanding items

* None at this time.
