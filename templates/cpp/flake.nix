{
  description = "C / C++ development environment (gcc + clang + cmake + ninja + clangd)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    {
      devShells = flake-utils.lib.eachDefaultSystem (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        in
        {
          default = pkgs.mkShell {
            name = "cpp-dev";
            packages = with pkgs; [
              gcc
              clang
              clang-tools # contains clangd, clang-tidy, clang-format
              gnumake
              cmake
              ninja
              meson

              gdb
              valgrind
              cppcheck
              include-what-you-use
              bear

              pkg-config
              openssl
              boost
              zlib
              zstd
              llvmPackages.libclang

              git
            ];

            shellHook = ''
              export CC=clang
              export CXX=clang++
            '';
          };
        });
    };
}
