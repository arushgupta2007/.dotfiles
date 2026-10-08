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

---

## Pre-activation audit (Phase 6 remediation)

This section documents issues found during the pre-activation review and the
fixes applied. Sources used to verify corrections are listed for each item.

### Source-of-truth references

- **Nixpkgs** pinned at `151fa4e8ddfdd8dd25d945ad94ed54a13de9f6e4` (nixos-unstable).
- **Home Manager** pinned at `fae6e9e42c3b762ab47635cddcfaf6f52374a61b`.
- **Agenix** pinned at `3daa710894355fa2fad8243380af373a2b4046ef`.
- **Niri** `26.04` (Nixpkgs).
- **DMS** pinned at `4a87e8227daf0840b3376fd5e7f891f5900165a6`.
- **Ghostty** `1.3.1` (Nixpkgs).
- **Pi Coding Agent** `1.0.3` from `pkgs.pi-coding-agent`.

### Phase 1 — Hardware / state version

- ✅ Root UUID `f340430e-65df-4f77-b3d2-6f677803c6b2` matches the running system.
- ✅ Boot UUID `B678-E4D3` matches the running system.
- ✅ Both LUKS devices (`140a74ca-…`, `1973fde1-…`) preserved.
- ✅ Swap UUID `5c23159a-…` preserved.
- ✅ `stateVersion = "26.11"` preserved (matches `~/.dotfiles-bak`).
- ✅ Framework 11th Gen Intel `nixos-hardware` module applied.
- ✅ Kernel cmdline (`nvme.noacpi=1 root=fstab loglevel=4 lsm=landlock,yama,bpf`) preserved.

### Phase 2 — Niri / DMS integration

**1. Invalid Niri syntax for named workspaces.** Source of error: pinned Niri
26.04. The `workspace "X" { layout { focus-ring { ... } } }` form is not a
valid child of a named workspace — only `open-on-output` is accepted. Fixed
by removing the layout block and emitting the workspace declarations as
plain nodes (`workspace "Oxf"`).

**2. `Mod+L { lock; }` is not a valid Niri action.** Source of error: Niri
26.04 validation. The lock is implemented in user-space via
`dms ipc call lock lock` (see DMS `core/internal/config/embedded/niri-binds.kdl`).
Replaced with `spawn "dms" "ipc" "call" "lock" "lock"`.

**3. Duplicate `Mod+L` binding.** Niri 26.04 rejects duplicate keybindings
explicitly (`duplicate keybind later defined here`). After removing the lock
binding, the second `Mod+L { focus-column-right; }` was also removed and
column navigation via HJKL was re-keyed (`Mod+Semicolon` for right) to
preserve vim-style focus.

**4. Duplicate `Mod+Shift+E` binding.** Same Niri validation rejection.
Kept `Mod+Shift+E` bound to `codium` (editor) and removed the second
`Mod+Shift+E { quit; }` since `Ctrl+Alt+Delete { quit; }` already covers the
quit action.

**5. Stale Kitty alias** (`icat = "kitten icat"`). Removed — `kitten` is the
Kitty terminal helper, not available in Ghostty.

### Phase 3 — Pi + OpenRouter

**1. `OPENROUTER_API_KEY_FILE` is not a documented Pi variable.** Verified
against the pinned Pi's `docs/providers.md`: Pi recognises `OPENROUTER_API_KEY`
as an env var, and additionally supports loading the key via a `!command`
prefix in `<agent-dir>/auth.json`. Switched to that mechanism:
`xdg.configFile.".pi/agent/auth.json"` is generated with
`{ openrouter = { type = "api_key"; key = "!cat /run/agenix/<name>"; }; }`.
The decrypted key never lives in an environment variable or a plain-text
config file.

**2. `lib.mkIf hasSecret (...)` inside `home.packages`.** Verified against the
pinned Home Manager: the pattern is used by HM itself (e.g.
`modules/programs/astroid/default.nix`, `modules/programs/macchina/default.nix`).
**No fix required.**

**3. `defaultModel` / `enabledModels`.** Verified against the bundled
Pi 0.87.1 catalog (`dist/bundle/chunks/chunk-OJP47DM6.js`). Current IDs
in `pi/settings.json`: `moonshotai/kimi-k2.6` (default),
`moonshotai/kimi-k2-thinking`, `qwen/qwen3-coder-next`,
`qwen/qwen3-coder-plus`, `qwen/qwen3-coder-flash`,
`anthropic/claude-sonnet-4`, `anthropic/claude-haiku-4.5`,
`openai/gpt-4.1`, `openai/gpt-4.1-mini`, `google/gemini-2.5-pro`,
`google/gemini-2.5-flash`. Kimi K2.6 (verified by grep against the
bundled catalog) is now the default; Claude models are still in the
enabled list so `/model` can switch to them on demand.

### Phase 4 — Agenix + networking

**1. Self-referential `environment.etc."ssh/ssh_host_ed25519_key".source =
"/etc/ssh/ssh_host_ed25519_key"` in `nixos/core/agenix.nix`.** Verified against
the pinned agenix module (`modules/age.nix`): agenix derives
`age.identityPaths` from `services.openssh.hostKeys` when openssh is
enabled, and the default is `[]` when it is not. The self-reference is a
no-op that, if openssh is ever disabled at build time, would fail because
the source path does not yet exist. **Removed** and replaced with an
explanatory comment so future maintainers know what to set if they ever
add a NixOS-level secret.

**2. Firewall exposing ports 22, 80, 443 by default.** No service was
running on those ports; the rules added nothing and increased the attack
surface. Closed them; kept only the host-defined KDE Connect range
(1714–1764) and the system-level LocalSend port (53317) opened by
`programs.localsend.openFirewall`.

**3. Hardcoded DNS (`1.1.1.1`, `8.8.8.8`, `8.8.4.4`).** Replaced with
NetworkManager-managed DHCP DNS. The host can be moved between networks
that use different DNS resolvers (including split-horizon DNS) without
Nix-level changes. If a future network needs explicit resolvers, add them
back to the host config.

**4. LocalSend declared twice** (in `home/core/files.nix` and
`home/core/communication.nix`). Moved to the upstream NixOS module
(`programs.localsend.enable = true`) which correctly opens the firewall
port (53317 TCP+UDP) and pulls in the right package.

### Phase 5 — Performance / applications

**1. `services.nscd.enable = lib.mkForce true` in `nixos/core/security.nix`.**
The NixOS default already enables nscd with TTL=0 (used as a NSS proxy);
the `mkForce true` was redundant. Removed. (Effective behaviour unchanged.)

**2. Aggressive sysctl tuning.** `vm.swappiness = 10`,
`vm.dirty_ratio = 5`, `vm.dirty_background_ratio = 2`. With 16 GiB RAM and
a zram swap, the upstream defaults are appropriate; lower values can hurt
desktop write performance. Removed the three overrides.

**3. Zram size.** Was 50 % of RAM (8 GiB) on a 16 GiB system — too large,
would starve user applications. Reduced to 25 % (≈ 4 GiB).

**4. Ghostty `confirm-close-window = false`.** The actual option name in
Ghostty 1.3.1 is `confirm-close-surface`. Fixed.

**5. Ghostty `clipboard-paste-protection = false`.** Set to `true` to
mitigate copy-paste attacks in the browser.

**6. Podman / Lazydocker socket compatibility.** Lazydocker reads
`DOCKER_HOST`; the rootless podman socket is at
`/run/user/1000/podman/podman.sock`. Set `DOCKER_HOST` via
`home.sessionVariables`, enabled `systemd.user.sockets.podman` with
`WantedBy = [ "sockets.target" ]`, and moved lazydocker to the HM module
(`programs.lazydocker`).

**7. `hyprlock` PAM service referenced in `nixos/core/fingerprint.nix`.**
The user is on Niri + DMS, not Hyprland. Removed; kept `swaylock` PAM as a
fallback.

**8. Duplicate `restic` declaration** (in `home/core/files.nix` and
`home/core/backup.nix`). Removed from `files.nix`; backup module owns it.

### Successful validation commands

```
$ nix --extra-experimental-features 'nix-command flakes' flake check
all checks passed!

$ nix --extra-experimental-features 'nix-command flakes' build \
    .#nixosConfigurations.framework-laptop.config.system.build.toplevel --no-link
… → /nix/store/<hash>-nixos-system-framework-laptop-26.11.20261006.151fa4e

$ niri validate --config home/wayland/niri-config.kdl
… INFO config is valid

$ nix --extra-experimental-features 'nix-command flakes' eval \
    .#nixosConfigurations.framework-laptop.config.networking.firewall.allowedTCPPorts
[ 53317 ]

$ nix --extra-experimental-features 'nix-command flakes' eval \
    .#nixosConfigurations.framework-laptop.config.zramSwap.memoryPercent
25

$ nix --extra-experimental-features 'nix-command flakes' eval \
    .#nixosConfigurations.framework-laptop.config.programs.localsend.enable
true
```

### Skipped / not run

- `nixos-rebuild switch` / `boot` / `test` — not authorised; activation is
  an explicit user decision.
- Real-device tests for Niri keybindings, lock IPC, fingerprint PAM, etc.
  These require a running desktop.

### Runtime checks required after activation

1. `agenix -e secrets/openrouter-api-key.age` to encrypt the
   OpenRouter API key before first `home-manager switch` that needs it.
2. `sudo nixos-rebuild switch --flake .#framework-laptop` (requires
   user approval) and reboot.
3. After reboot:
   - Confirm Niri starts, `Super+L` toggles DMS lock screen.
   - Confirm Ghostty closes surfaces with a confirmation prompt and asks
     for confirmation on multi-line paste.
   - Confirm `lazydocker` connects to the rootless podman socket.
   - Confirm `dms ipc call lock lock` works from a terminal.
   - `fwupdmgr refresh --force && fwupdmgr get-updates && fwupdmgr update`
     to pull firmware updates through LVFS.
   - Confirm Wi-Fi connects via NetworkManager (DHCP-provided DNS).

### Remaining concerns

- Pi's `defaultModel` (`openrouter/moonshotai/kimi-k2.6`) is the
  Kimi K2.6 model via OpenRouter. Claude models remain selectable via
  `/model` if needed. If OpenRouter renames any slug, `defaultModel`
  will need updating.
- `DOCKER_HOST` is hardcoded to UID 1000; this matches the first non-root
  user NixOS creates. If you ever add a second user, they will need their
  own `home.sessionVariables.DOCKER_HOST`.
- Locale fallback (`C.UTF-8` / `en_US.UTF-8`) — see "Outstanding items".
