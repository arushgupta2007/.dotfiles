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
  # after a fresh login. `wantedBy = [ "default.target" ]` makes it
  # start at session start.
  systemd.user.sockets.podman = {
    Socket = {
      ListenStream = "%t/podman/podman.sock";
      RuntimeDirectory = "podman";
      SocketMode = "0660";
      Group = "users";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}

