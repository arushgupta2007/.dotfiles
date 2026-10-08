{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Distrobox / Toolbox for compatibility environments.
    distrobox
    toolbox

    # Misc CLI utilities.
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
