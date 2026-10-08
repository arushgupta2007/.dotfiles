{
  pkgs ? import <nixpkgs> {
    system = "x86_64-linux";
    config.allowUnfree = true;
  },
}:

pkgs.mkShell {
  name = "cpp-dev";

  packages = with pkgs; [
    # Compilers.
    gcc
    clang
    clang-tools
    gnumake
    cmake
    ninja
    meson

    # Tooling.
    gdb
    valgrind
    cppcheck
    include-what-you-use
    clang-tools
    bear

    # Language server.
    clangd

    # System deps.
    pkg-config
    openssl
    boost
    zlib
    zstd

    # Format.
    clang-tools
    llvmPackages.libclang

    git
  ];

  shellHook = ''
    export CC=clang
    export CXX=clang++
  '';
}
