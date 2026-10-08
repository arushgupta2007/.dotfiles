{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # API + HTTP tooling.
    bruno
    httpie

    # Database clients.
    sqlite
    postgresql

    # Version control extras.
    gh
    git-lfs

    # Common dev tools.
    gcc
    gnumake
    pkg-config
    openssl

    # Other utilities.
    nix-prefetch-github
    nwg-displays
    nwg-look
  ];
}
