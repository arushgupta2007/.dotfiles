# NixOS Developer Workstation

A modular, flake-based NixOS configuration for a Framework Laptop 11th Gen
Intel, built around the **Niri** scrolling Wayland compositor and
**DankMaterialShell (DMS)** desktop shell.

> **Before you switch:** this repository is the *new* configuration, located
> at `~/.dotfiles`. The previous repository at `~/.dotfiles-bak` is treated
> as read-only and is preserved unchanged.

## Highlights

- **Niri** — Wayland scrolling compositor (no X11).
- **DankMaterialShell** — desktop shell with bar, launcher, clipboard
  manager, notifications, quick settings, and Material theming.
- **Ghostty** — GPU-accelerated Wayland terminal.
- **Zsh + Starship + Atuin + Zellij + Yazi + Eza + Bat + Ripgrep + fd**.
- **Brave** — primary browser, configured for native Wayland.
- **VSCodium + Neovim** — GUI and terminal editors.
- **Pi Coding Agent** with **OpenRouter** — primary AI coding interface.
- **Rootless Podman + Lazydocker + Distrobox** for containers.
- **Restic + KDE Connect + LocalSend** for backup and device sync.
- **Six ready-to-use dev-shell templates** for Python, Node, Rust, Go, C++,
  and Nix.

## Hardware

| Component | Value                                         |
| --------- | --------------------------------------------- |
| Machine   | Framework Laptop 11th Gen Intel               |
| CPU       | 11th Gen Intel(R) Core(TM) i7-1185G7          |
| Graphics  | Intel Iris Xe (integrated)                    |
| RAM       | 16 GB                                         |
| Storage   | NVMe with LUKS-encrypted root + LUKS swap     |

The hardware configuration (`hosts/framework-laptop/hardware-configuration.nix`)
is preserved verbatim from the previous repository. **Do not change UUIDs,
LUKS mappings, boot entries, or `system.stateVersion` without an explicit
migration plan.**

## Repository layout

```
.
├── flake.nix                # flake entry point
├── flake.lock
├── hosts/framework-laptop/  # host-specific configuration
│   ├── default.nix
│   └── hardware-configuration.nix
├── nixos/
│   ├── core/                # NixOS modules shared by every host
│   └── wayland/             # Niri + DMS desktop
├── home/
│   ├── core/                # Home Manager modules shared by every user
│   └── wayland/             # Niri + DMS user config
├── templates/               # per-project dev shells (shell.nix each)
├── secrets/                 # agenix-encrypted secrets
├── pi/                      # Pi Coding Agent configuration
│   ├── AGENTS.md
│   ├── settings.json
│   ├── extensions/          # TS extensions
│   ├── skills/              # SKILL.md files
│   └── prompts/             # prompt templates
├── wallpapers/              # wallpaper assets (optional)
├── README.md
└── MIGRATION.md
```

## Building the configuration

```bash
# Inside the repository:
nix flake check                # evaluate + check everything
nix flake show                 # list outputs

# Build the NixOS system (no switch):
nix build .#nixosConfigurations.framework-laptop.config.system.build.toplevel

# Build the Home Manager activation package:
nix build .#nixosConfigurations.framework-laptop.config.home-manager.users.arush.home.activationPackage

# Build a development shell template:
nix build .#devShells.x86_64-linux.python
```

To enter a development shell:

```bash
nix develop .#python      # python template
nix develop .#node        # node template
nix develop .#rust        # rust template
nix develop .#go          # go template
nix develop .#cpp         # c/c++ template
nix develop .#nix         # nix template
```

Or in any project directory, use `direnv` with `.envrc`:

```
use flake .#python
```

`nix-direnv` is enabled in the configuration; the first time you enter a
project directory it will build the shell and cache the result.

## Applying the configuration

The flake's NixOS configuration is built but **not switched**. To switch:

```bash
sudo nixos-rebuild switch --flake .#framework-laptop
```

This is **destructive** in the sense that it changes the running system.
Confirm with me before issuing this command.

## Initial secrets setup (Pi + OpenRouter)

1. Generate a fresh agenix key on the build host, or reuse the existing
   one. The `secrets.nix` file lists the public keys allowed to decrypt
   each secret.

2. Re-encrypt the OpenRouter key (the previous `.age` file lives in
   `~/.dotfiles-bak/claude-code-openrouter.age`):

   ```bash
   cd ~/.dotfiles
   # If migrating from the old repo, copy the .age file across first.
   # Otherwise, edit a new secret:
   agenix -e secrets/claude-code-openrouter.age
   ```

   This opens your `$EDITOR` with the decrypted contents. Paste your
   OpenRouter API key (`sk-or-v1-...`), save, and exit.

3. Make sure `secrets/secrets.nix` contains the public half of your SSH key
   (or agenix key). Look at the previous repository for the existing
   public key.

4. Rebuild:

   ```bash
   nix build .#nixosConfigurations.framework-laptop.config.system.build.toplevel
   sudo nixos-rebuild switch --flake .#framework-laptop
   ```

5. Pi will pick up `OPENROUTER_API_KEY_FILE` automatically.

## Desktop shortcuts

### Launchers

| Shortcut             | Action                                |
| -------------------- | ------------------------------------- |
| `Super + Return`     | Ghostty                               |
| `Super + D`          | DMS launcher                          |
| `Super + V`          | DMS clipboard                         |
| `Super + E`          | Nautilus                              |
| `Super + B`          | Brave                                 |
| `Super + Shift + E`  | VSCodium                              |
| `Super + Escape`     | DMS power menu                        |

### Window management (Niri)

| Shortcut                  | Action                               |
| ------------------------- | ------------------------------------ |
| `Super + Q`               | Close window                         |
| `Super + F`               | Maximize column                      |
| `Super + Shift + F`       | Fullscreen                           |
| `Super + arrows`          | Focus column / window                |
| `Super + Shift + arrows`  | Move column / window                 |
| `Super + 1..9 / 0`        | Focus workspace 1..10                |
| `Super + Ctrl + 1..9 / 0` | Move column to workspace             |
| `Super + L`               | Lock screen                          |

### Screenshots and media

| Shortcut             | Action                                   |
| -------------------- | ---------------------------------------- |
| `Print`              | Screenshot region                        |
| `Ctrl + Print`       | Screenshot full screen                   |
| `Alt + Print`        | Screenshot window                        |
| `Super + Print`      | Screenshot → open in Swappy              |
| `XF86AudioPlay/Stop` | MPRIS media controls                     |
| `XF86Audio*`         | Volume up / down / mute                  |
| `XF86MonBrightness*` | Brightness up / down                     |

## Pi Coding Agent

Pi is installed declaratively via Nix and configured through files in
`pi/`:

- `pi/AGENTS.md` — global instructions.
- `pi/settings.json` — model, provider, defaults, skill / prompt paths.
- `pi/skills/<name>/SKILL.md` — Agent Skills. Available skills out of the
  box: `nixos-dev`, `python-dev`, `typescript-dev`, `rust-dev`, `go-dev`,
  `git-review`, `nix-validate`.
- `pi/prompts/<name>.md` — slash-command prompt templates.
- `pi/extensions/` — drop TypeScript extension files here.

Models: Pi is configured to start with `openrouter/anthropic/claude-sonnet-4`.
Other enabled models:

- `openrouter/anthropic/claude-haiku-4.5` (fast, low thinking)
- `openrouter/openai/gpt-4.1`
- `openrouter/openai/gpt-4.1-mini` (fast, low thinking)
- `openrouter/google/gemini-2.5-pro`
- `openrouter/google/gemini-2.5-flash` (fast, low thinking)

Use `/model` inside Pi to switch.

To add a new skill:

```bash
mkdir pi/skills/my-skill
# Create pi/skills/my-skill/SKILL.md with frontmatter:
#   ---
#   name: my-skill
#   description: ...
#   ---
```

Then run `pi` and use `/skill:my-skill` to invoke it.

To add a TS extension, drop a `*.ts` file into `pi/extensions/`. Pi loads
them automatically on next start (use `/reload` to refresh mid-session).

## Development shells

Each `templates/<lang>/` directory is a **self-contained flake** with its
own `flake.nix` and `flake.lock`. Use them standalone or via the main flake.

### Quick use from the main flake

```bash
nix develop .#python      # python template
nix develop .#node        # node template
nix develop .#rust        # rust template
nix develop .#go          # go template
nix develop .#cpp         # c/c++ template
nix develop .#nix         # nix template
```

### Use a template directly

```bash
nix develop ./templates/python
cd templates/python && nix develop
```

### Use with direnv in a project

Each template ships an `.envrc.example`. Copy the relevant one into a
project as `.envrc` and edit the path. `nix-direnv` (enabled in the
dotfiles) activates the shell automatically on `cd`.

For example, in a Python project:

```bash
cp /home/arush/.dotfiles/templates/python/.envrc.example .envrc
# Edit .envrc if you moved the dotfiles repo
direnv allow
```

You can either:
- Reference the template by absolute path: `use flake path:/home/arush/.dotfiles/templates/python`
- Or copy `flake.nix` + `flake.lock` into the project and `use flake .`

### What each template includes

| Template | Notable tools                                         |
| -------- | ----------------------------------------------------- |
| python   | uv, ruff, basedpyright, pytest, ipython, common libs  |
| node     | nodejs_22, pnpm, typescript, biome, deno, vite        |
| rust     | rustup, cargo, rust-analyzer, clippy, rustfmt         |
| go       | go, gopls, delve, golangci-lint                       |
| cpp      | gcc, clang, cmake, ninja, gdb, valgrind, clang-tools  |
| nix      | nixfmt, nixd, statix, deadnix, nh                     |

## Updating inputs

```bash
nix flake update                # update all inputs
nix flake update nixpkgs        # update only nixpkgs
nix flake lock --update-input home-manager
```

After updating, run `nix flake check` and a system build before switching.

## Rollback instructions

`nixos-rebuild` keeps a generation of the previous system under
`/nix/var/nix/profiles/system`. To roll back from the bootloader:

1. Reboot and choose an earlier generation from systemd-boot.
2. Or, from the running system:
   ```bash
   sudo nix-env --profile /nix/var/nix/profiles/system --rollback
   sudo /nix/var/nix/profiles/system/bin/switch-to-configuration switch
   ```

## Known limitations

- **`en_IN.UTF-8` locale** is not supported by the upstream `glibc-locales`
  build. The configuration falls back to `C.UTF-8` as `defaultLocale` and
  `en_US.UTF-8` for the LC_* categories. See `MIGRATION.md` for details.
- **No DMS greeter.** The DMS greeter moved to a separate `dank-greeter`
  repo. To enable a graphical greeter:
  1. Add `dank-greeter` to the inputs of `flake.nix`.
  2. Import `inputs.dank-greeter.nixosModules.default` in the
     `framework-laptop` host.
  3. Enable `programs.dms-greeter`.
- **Hostname.** The flake name is `framework-laptop`, but the live hostname
  is `desktop`. To preserve `desktop`, set `networking.hostName = "desktop";`
  in `hosts/framework-laptop/default.nix`.
- **Pi session history** lives under `~/.pi/agent/sessions/` and is
  preserved across rebuilds.
- **API keys** are decrypted into `/run/agenix/<name>` at activation. They
  are not stored in `/nix/store`.

## Operating rules

- Treat `~/.dotfiles-bak` as read-only.
- Never run `nixos-rebuild switch` or `boot`, partitioning, or filesystem
  formatters without explicit approval.
- Never modify UUIDs, LUKS mappings, boot entries, or `stateVersion`.
- Never write secrets into the Nix store.
- Always run `nix flake check` after non-trivial changes.

## License

This configuration is for personal use. Components retain their upstream
licenses; see `LICENSE` for the project's license.
