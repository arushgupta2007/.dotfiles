# Mission: Build My Ultimate NixOS Developer Workstation

You are my principal NixOS engineer, Linux desktop architect, and developer-experience specialist.

Your task is to **completely redesign and implement my NixOS dotfiles** into a modern, polished, AI-native development workstation.

This is an implementation task, not merely a planning exercise. Inspect my existing configuration, research compatibility where necessary, make architectural decisions, write the new configuration, and validate your work.

## 1. Repository locations

**Existing configuration (reference only):**
`~/.dotfiles-bak`

**New configuration (your working directory):**
`~/.dotfiles`

The new directory is currently empty.

### Critical rules

- Treat `~/.dotfiles-bak` as read-only.
- Never edit, delete, move, or overwrite anything inside `~/.dotfiles-bak`.
- Create the entire new configuration inside `~/.dotfiles`.
- Do not clone the GitHub repository over the new directory.
- Do not rely on the old README. It is outdated since the repository was forked.
- Inspect the actual Nix files, imports, packages, scripts, and application configurations.
- Use the existing configuration as a reference, not as a template that must be copied unchanged.
- Preserve hardware-specific settings, bootloader configuration, filesystem mounts, encryption settings, and existing `system.stateVersion`.
- Preserve the existing Home Manager `home.stateVersion`.
- Never assume an option, package, or flake input exists without checking.
- Never execute a system switch, reboot, partitioning operation, destructive cleanup, or disk modification without my explicit approval.
- Do not modify my current live configuration or application settings outside the new repository.
- You may create and edit files inside `~/.dotfiles`, but ask before changing anything elsewhere.

## 2. Hardware and development requirements

My machine:

- Intel CPU
- Intel integrated graphics
- 16 GB RAM
- Laptop
- NixOS

My development work:

- Web development: JavaScript, TypeScript, Node.js, frontend and backend
- Python development
- Nix and NixOS configuration
- Rust
- Go
- C/C++

Optimize for responsiveness, battery life, maintainability, and reasonable RAM consumption.

Do not install heavyweight background services unnecessarily.

Detect the actual CPU/GPU model and current system configuration before applying hardware-specific optimizations.

## 3. Required desktop stack

These components are non-negotiable:

- **Niri** as the Wayland scrolling compositor
- **DankMaterialShell (DMS)** as the desktop shell
- **Brave** as the primary browser
- **Pi Coding Agent + OpenRouter** as the primary AI coding environment

Use DMS for its supported desktop integrations, including:

- Bar and system widgets
- Application launcher
- Clipboard manager and history
- Notifications
- Quick settings
- Wallpaper management
- Material theming
- Lock screen and power controls, where supported

Avoid duplicate launchers, bars, notification daemons, clipboard managers, wallpaper services, and authentication agents.

Do not blindly remove underlying dependencies used by DMS.

## 4. Application stack

Implement the following preferred applications unless compatibility, reliability, or resource usage provides a compelling reason to choose otherwise.

### Terminal and shell

- Ghostty — primary terminal
- Zsh — interactive shell
- Starship — prompt
- Zoxide — directory navigation
- Fzf — fuzzy finding
- Atuin — searchable shell history
- Zellij — terminal multiplexing
- Yazi — terminal file manager
- Eza — directory listing
- Bat — file viewing
- Ripgrep — text search
- fd — file discovery
- Btop — resource monitoring
- Dust and Duf — disk usage
- Delta — Git diffs
- Lazygit — Git interface
- Just — task runner
- Hyperfine — benchmarking
- Tealdeer — command examples
- jq and yq — structured data

Keep Zsh fast and avoid excessive plugins.

Do not automatically launch Zellij in every terminal.

### Editors

- VSCodium — GUI editor
- Neovim — terminal editor

Configure language servers, formatting, diagnostics, Git integration, and debugging appropriately.

Use modern Neovim plugins, but avoid unnecessary plugin bloat.

Manage editor settings declaratively where practical.

### Browsers

- Brave — primary browser
- Firefox — secondary browser for cross-browser testing

Configure Brave for native Wayland operation and verify Intel hardware acceleration.

Do not replace Brave with another primary browser.

### Developer utilities

- Bruno — API testing
- HTTPie — terminal HTTP client
- Git and GitHub CLI
- Direnv + nix-direnv
- Podman — rootless containers
- Distrobox — compatibility environments
- Lazydocker — container management
- SQLite and PostgreSQL clients
- Playwright support in project environments

Use Podman rather than enabling Docker Engine by default.

Validate Lazydocker compatibility with the rootless Podman socket.

### Everyday utilities

- Nautilus — graphical file manager
- Yazi — terminal file manager
- Papers or another suitable PDF viewer
- Loupe or another suitable image viewer
- mpv — video player
- File Roller — archives
- LocalSend — local file transfer
- KDE Connect — phone integration
- Restic — encrypted backups
- PipeWire + WirePlumber — audio
- Appropriate screenshot and annotation tools
- Appropriate screen recording tools
- Password manager integration, without storing secrets in Nix

Evaluate existing utilities before replacing them.

Do not introduce redundant applications without a clear reason.

## 5. AI coding environment

Pi Coding Agent is the primary AI development interface.

OpenRouter is the primary model provider.

### Requirements

- Install Pi declaratively using a pinned, maintained Nix package or flake.
- Verify the installation method and package availability.
- Configure OpenRouter securely.
- Never place API keys or decrypted secrets in the Nix store.
- Reuse existing Agenix infrastructure if appropriate.
- Keep authentication and session state writable.
- Manage stable Pi configuration, instructions, skills, and extensions declaratively.
- Support switching between inexpensive coding models and stronger reasoning models.
- Do not hardcode outdated model IDs or unverified pricing.
- Preserve Pi session history across rebuilds.

### Pi capabilities

Implement a practical power-user setup with:

- Global `AGENTS.md`
- Project-specific instruction support
- NixOS development skill
- Python development skill
- TypeScript/web development skill
- Rust development skill
- Go development skill
- Git review workflow
- Nix validation workflow
- Custom TypeScript extensions where useful
- Model selection and context management
- Automatic compaction where supported
- Safe command execution policies
- Optional support for future subagent workflows

Review extension APIs against the installed Pi version.

Do not invent configuration keys or extension APIs.

Treat instructions and confirmation hooks as safeguards, not as a substitute for sandboxing.

Do not enable unrestricted autonomous shell execution.

Do not automatically install large local AI models. Local inference is optional and should remain disabled by default.

## 6. NixOS architecture

Build a clean, modular, understandable flake-based configuration.

Use:

- Nix flakes
- Home Manager
- Reusable NixOS modules
- Reusable Home Manager modules
- Host-specific configuration
- Declarative application settings
- Project-specific development shells
- Pinned flake inputs
- Minimal overlays
- Minimal unfree-package exceptions where practical

Prefer existing NixOS and Home Manager modules over custom shell scripts.

Preserve multiple host configurations from the old repository where they remain useful.

Do not change the NixOS release channel merely for novelty. Evaluate the existing unstable configuration before deciding whether a stable base with selected unstable packages would be better.

Keep the new structure practical rather than creating excessive modules for trivial settings.

## 7. Development environments

Do not install every language runtime and SDK globally.

Install common CLI tools globally, but manage project-specific runtimes and dependencies through Nix development shells.

Provide reusable development templates for:

1. Python using uv, Ruff, basedpyright, and pytest.
2. TypeScript/Node.js using pnpm, Biome, and suitable language tooling.
3. Rust using Cargo, rust-analyzer, Clippy, and rustfmt.
4. Go using gopls and Delve.
5. C/C++ using Clang/GCC, clangd, CMake, Ninja, and a debugger.
6. Nix development using nixd, nixfmt, statix, and deadnix.

Integrate direnv and nix-direnv.

Verify that each template evaluates and enters its development shell successfully.

## 8. Desktop shortcuts and workflow

Inspect my existing Niri keybindings and helper scripts.

Retain useful shortcuts where possible, but you are allowed to redesign them for a more consistent workflow.

Suggested defaults:

| Shortcut | Action |
|---|---|
| Super + Enter | Ghostty |
| Super + D | DMS launcher |
| Super + V | DMS clipboard |
| Super + E | Nautilus |
| Super + B | Brave |
| Super + Q | Close window |
| Super + F | Fullscreen |
| Super + L | Lock |
| Super + arrows | Navigate windows |
| Super + Shift + arrows | Move windows |
| Print | Screenshot |
| Super + Print | Screenshot annotation |

These are preferences, not requirements if conflicts exist.

Verify the actual Niri syntax and DMS IPC commands.

Provide consistent shortcuts for:

- Workspace navigation
- Column resizing
- Moving windows
- Screenshots
- Clipboard history
- Brightness
- Volume
- Media playback
- Locking
- Application launching

Preserve working touchpad gestures and monitor-specific settings unless there is a clear improvement.

## 9. Appearance

Create a polished, cohesive desktop using DMS Material theming.

Prefer:

- Consistent application colors
- Good typography
- Subtle rounded corners
- Sensible window gaps
- Clean desktop widgets
- Minimal visual clutter
- Smooth interactions
- Reasonable animation settings
- Consistent GTK/Qt appearance

Use DMS as the primary theme controller.

Avoid competing theme-management systems unless necessary.

Optimize appearance without compromising performance or battery life.

## 10. Performance, security, and reliability

Evaluate:

- Intel Mesa and VA-API configuration
- Hardware video decoding
- Wayland portals and screen sharing
- Laptop power management
- Suspend/resume
- Zram
- Nix garbage collection
- Nix build parallelism
- Firewall configuration
- Rootless containers
- Secure credential handling
- Backup and restore strategy
- Background service overhead

Do not apply speculative kernel tweaks, unsafe sysctl changes, or unnecessary system optimizations.

Avoid automatically enabling services that are only occasionally needed.

Preserve system recovery and rollback capabilities.

## 11. Mandatory workflow

### Phase 1 — Audit

Before writing the new configuration:

1. Inspect the old repository structure.
2. Follow actual Nix imports to identify active modules.
3. Inventory installed applications and enabled services.
4. Inspect Niri, DMS, terminal, shell, editor, and utility configurations.
5. Identify obsolete Hyprland-specific components.
6. Identify duplicate or conflicting utilities.
7. Inspect existing Agenix usage.
8. Identify hardware-specific settings that must be preserved.
9. Determine which host configuration corresponds to this laptop.
10. Produce a concise audit summary.

Do not rely on the README.

### Phase 2 — Architecture

Design the new repository layout.

For every important application, decide whether to:

- Keep and improve
- Replace
- Remove
- Add

Explain non-obvious decisions briefly.

Identify dependencies, integration risks, and potential compatibility problems.

Then proceed with implementation.

### Phase 3 — Implementation

Create the new configuration in `~/.dotfiles`.

Work in logical stages:

1. Flake and host foundation
2. Hardware and essential system modules
3. Niri + DMS desktop
4. Terminal and shell
5. Editors and development tools
6. Pi + OpenRouter
7. Containers and everyday utilities
8. Development templates
9. Formatting, linting, checks, and documentation

Do not modify the old repository.

Do not make changes to the running system.

### Phase 4 — Validation

Validate incrementally rather than waiting until the end.

Use appropriate checks such as:

- Nix formatting
- `nix flake check`
- NixOS configuration evaluation
- `nixos-rebuild build --flake ...`
- Home Manager activation-package evaluation
- Development-shell evaluation
- Static validation of Niri and application configurations
- Detection of conflicting NixOS module definitions
- Verification of referenced package attributes
- Verification of flake input compatibility

Use the actual host names discovered during the audit.

Do not assume a successful evaluation guarantees that graphical services will work at runtime.

Fix errors based on real command output.

Never claim a test passed unless it was actually executed successfully.

### Phase 5 — Documentation

Create a new README describing the real configuration.

Include:

- Repository structure
- Applications and their purposes
- Important shortcuts
- Build and installation instructions
- Safe migration instructions
- Pi + OpenRouter setup
- Secret-management setup
- Development-shell usage
- Updating flake inputs
- Rollback instructions
- Known limitations

Do not copy the outdated README from the old repository.

## 12. Operating rules

You have permission to inspect files and implement the new configuration inside `~/.dotfiles`.

You do not have permission to:

- Modify `~/.dotfiles-bak`
- Switch or boot a new NixOS generation
- Change disk partitions or filesystems
- Modify live system configuration outside the new repository
- Delete existing user data
- Change credentials or secrets
- Make purchases or incur paid API charges beyond the normal model calls needed for this task
- Deploy services externally
- Force-push or rewrite Git history

Ask for approval before any operation outside these boundaries.

When uncertain, inspect the installed configuration, pinned nixpkgs source, upstream documentation, or relevant option definitions instead of guessing.

Prefer maintainable, idiomatic Nix over clever abstractions.

## 13. Context and token efficiency

This is a large repository migration. Work efficiently.

- Do not dump the entire old repository into context.
- Inspect relevant files in batches.
- Use ripgrep and targeted file reads.
- Avoid repeatedly reading unchanged files.
- Keep build logs concise; extract relevant errors.
- Maintain a migration progress document inside the new repository.
- Record architectural decisions and outstanding problems.
- Preserve progress across context compaction and new sessions.
- Use targeted checks after each module group.
- Do not repeatedly retry the same failing command without changing the diagnosis.

Create `MIGRATION.md` to track completed work, decisions, validation results, and remaining tasks.

If the session becomes too long, update `MIGRATION.md` before compacting or ending.

## 14. Definition of done

The task is complete when:

- The new dotfiles exist entirely inside `~/.dotfiles`.
- The old repository remains untouched.
- The configuration has a coherent modular structure.
- Niri and DMS are correctly integrated.
- Brave is configured as the primary browser.
- Ghostty, Zsh, Zellij, and Atuin are configured.
- VSCodium and Neovim are configured.
- Pi + OpenRouter are configured securely.
- Development tools and templates are included.
- Podman, Bruno, Lazydocker, LocalSend, KDE Connect, and Restic are configured appropriately.
- Obsolete and duplicate components are removed from the new configuration.
- The applicable Nix evaluation and build checks pass.
- Any untested runtime behavior is clearly documented.
- Migration and rollback instructions are provided.
- No system switch has been performed without my approval.



## Critical: Preserve and Correctly Migrate Existing Hardware Configuration

My previous NixOS configuration is located at `~/.dotfiles-bak`, and the new configuration must be created in `~/.dotfiles`.

**You MUST reuse the actual hardware configuration from my previous repository rather than generating a generic replacement.**

### Instructions

1. Locate the existing `hardware-configuration.nix`, `hardware.nix`, and any other hardware-specific Nix modules in `~/.dotfiles-bak`.

2. Identify which hardware configuration belongs to my current laptop. Do not accidentally use the desktop or VM configuration.

3. Trace all imports and dependencies of the existing hardware configuration, including any `nixos-hardware` modules.

4. Preserve all hardware-critical settings, including:
   - Filesystem mounts and filesystem UUIDs
   - Root and boot partitions
   - Bootloader and EFI configuration
   - LUKS encryption and swap configuration, if present
   - Kernel modules and initrd settings
   - CPU microcode
   - Intel graphics configuration
   - Firmware configuration
   - Filesystem-specific options
   - Hardware quirks and laptop-specific settings
   - Power-management settings that are required for the hardware

5. Copy the appropriate existing hardware configuration into the new repository, preserving its effective behavior. Adjust import paths only where necessary.

6. If hardware settings are distributed across multiple modules, migrate those modules or explicitly preserve their effective settings in the new structure.

7. Do not blindly copy hardware modules from other hosts.

8. Compare the migrated configuration against the original and verify that no essential hardware settings have been lost.

9. Inspect the current system's `/etc/nixos/hardware-configuration.nix` if available, but do not automatically replace the repository's hardware configuration with it. Investigate differences first.

10. Preserve the original `system.stateVersion` and existing filesystem layout. Never regenerate filesystems, modify partitions, change UUIDs, or alter encryption settings.

### Mandatory validation

Before declaring the new configuration ready:

- Evaluate the complete laptop NixOS configuration.
- Verify that the expected root and boot filesystem declarations are present.
- Verify that required kernel modules and firmware settings are retained.
- Compare the effective hardware-related NixOS options between the old and new configurations wherever possible.
- Run a NixOS build for the new laptop configuration.
- Report any hardware-related differences that could affect booting, graphics, networking, suspend/resume, or storage.

### Safety

Do not run `nixos-generate-config` to replace the existing hardware configuration.

Do not run `nixos-rebuild switch`, `nixos-rebuild boot`, partitioning commands, filesystem formatting, or bootloader installation without explicit approval.

**The new configuration must preserve my laptop's proven hardware setup while modernizing the desktop, applications, and development environment.**

If you cannot confidently identify the correct hardware configuration, stop and ask me rather than guessing.



## Begin now

Start by inspecting `~/.dotfiles-bak` and the current machine's NixOS configuration.

Determine which existing modules and hardware settings are essential, identify obsolete components, and build the new configuration inside `~/.dotfiles`.

Be proactive and make sensible engineering decisions. Do not interrupt for trivial preferences. Ask only when a decision is genuinely ambiguous, risky, or requires permission.

**Your goal is a complete, buildable, maintainable NixOS developer workstation—not just a collection of package recommendations.**
