{ pkgs, ... }:

{
  # Distrobox provides containerized environments for non-Nix apps.
  home.packages = with pkgs; [
    distrobox
    toolbox
  ];

  # Useful CLI utilities.
  home.packages = with pkgs; [
    bitwise
    entr
    ncdu
    sl
    cmatrix
    pipes
    tty-clock
    cbonsai
    ani-cli
    gtt
    nitch
  ];
}
