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

  # Lazydocker — TUI for Docker / Podman. Configured to talk to the
  # rootless podman socket, which is activated by the NixOS podman
  # module (`virtualisation.podman.enable = true` in
  # nixos/core/podman.nix). That module already installs a
  # rootless user socket at $XDG_RUNTIME_DIR/podman/podman.sock and
  # binds it to `sockets.target`, so we don't redeclare it here.
  programs.lazydocker = {
    enable = true;
    settings = {
      commandTemplates.dockerCompose = "docker compose";
    };
  };

  # Lazydocker reads $DOCKER_HOST; rootless podman listens on the
  # user-level socket at $XDG_RUNTIME_DIR/podman/podman.sock. Using
  # $XDG_RUNTIME_DIR (rather than a hardcoded UID) lets this work for
  # any user without modification. Home Manager writes this to
  # ~/.profile / /etc/profile.d, where the shell expands the variable.
  home.sessionVariables = {
    DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/podman/podman.sock";
  };
}
