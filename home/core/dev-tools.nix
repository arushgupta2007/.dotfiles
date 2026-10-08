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

    # Other utilities.
    nix-prefetch-github
    nwg-displays
    nwg-look
  ];

  # Common dev tools available system-wide.
  environment.systemPackages = with pkgs; [
    gcc
    gnumake
    pkg-config
    openssl
  ];
}
