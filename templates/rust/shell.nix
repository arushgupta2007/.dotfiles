{
  pkgs ? import <nixpkgs> {
    system = "x86_64-linux";
    config.allowUnfree = true;
  },
}:

pkgs.mkShell {
  name = "rust-dev";

  packages = with pkgs; [
    rustup
    cargo
    rustc
    rust-analyzer
    clippy
    rustfmt
    rustPackages.clippy

    # System dependencies that some Rust crates need.
    pkg-config
    openssl
    libgit2

    # Utilities.
    git
    gnumake
    gdb

    # Linters.
    shellcheck
    shfmt
    editorconfig-checker
  ];

  shellHook = ''
    export RUST_BACKTRACE=1
    if [ ! -d "$HOME/.cargo" ]; then
      echo "Run 'rustup default stable' to set up the toolchain."
    fi
  '';
}
