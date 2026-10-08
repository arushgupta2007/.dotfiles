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
    clang-tools # contains clangd, clang-tidy, clang-format
    gnumake
    cmake
    ninja
    meson

    # Tooling.
    gdb
    valgrind
    cppcheck
    include-what-you-use
    bear

    # System deps.
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
}
