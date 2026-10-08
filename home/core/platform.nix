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
  # rootless podman socket, which is activated below.
  programs.lazydocker = {
    enable = true;
    settings = {
      commandTemplates.dockerCompose = "docker compose";
    };
  };

  # Lazydocker reads $DOCKER_HOST; rootless podman listens on the
  # user-level socket at /run/user/$UID/podman/podman.sock.
  home.sessionVariables = {
    DOCKER_HOST = "unix:///run/user/1000/podman/podman.sock";
  };

  # Auto-start the user podman socket so lazydocker / podman CLI work
  # after a fresh login. The `%t` specifier expands to the user's
  # XDG_RUNTIME_DIR at activation time.
  systemd.user.sockets.podman = {
    Unit.Description = "Podman API Socket";
    Socket = {
      ListenStream = "%t/podman/podman.sock";
      SocketMode = "0660";
    };
    Install.WantedBy = [ "sockets.target" ];
  };
}

