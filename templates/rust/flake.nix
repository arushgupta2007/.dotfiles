{
  description = "Rust development environment (cargo + rust-analyzer + clippy)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
      {
        devShells.${system} = {
          default = pkgs.mkShell {
            name = "rust-dev";
            packages = with pkgs; [
              rustup
              cargo
              rustc
              rust-analyzer
              clippy
              rustfmt

              pkg-config
              openssl
              libgit2

              git
              gnumake
              gdb

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
          };
        };
      });
}
