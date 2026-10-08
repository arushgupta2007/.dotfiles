---
name: rust-dev
description: Rust development with Cargo, rust-analyzer, Clippy, and rustfmt. Use when scaffolding, reviewing, or refactoring Rust code.
---

# Rust Development

The user uses stable Rust via `rustup`, `rust-analyzer` for LSP,
`clippy` for linting, and `rustfmt` for formatting.

## Common commands

```bash
cargo init                  # scaffold a binary
cargo new --lib <name>      # scaffold a library
cargo add <crate>           # add dep
cargo build                 # dev build
cargo test                  # run tests
cargo clippy --all-targets -- -D warnings
cargo fmt
```

## Style

- Stable Rust unless the project explicitly targets nightly.
- All public items documented.
- Prefer `Result` over panics; reserve `unwrap` for tests and prototypes.
- Errors via `thiserror` (libraries) or `anyhow` (binaries).

## Workspace layout

For multi-crate workspaces, use `cargo workspace` and keep a top-level
`Cargo.toml` declaring members.
