{
  pkgs,
  username,
  ...
}:

{
  users.users.${username}.extraGroups = [ "podman" ];

  environment.systemPackages = with pkgs; [
    podman
    podman-compose
    podman-tui
    distrobox
  ];

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      # Drop-in replacement for the docker CLI.
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Lazydocker ships as a home-manager module; here we just need to
  # point it at the user podman socket. The system-level podman module
  # enables the root socket at /run/podman/podman.sock; for rootless
  # use, lazydocker expects $DOCKER_HOST to point at the user socket.
  # We rely on the user enabling `podman.socket` via systemd --user
  # (see home/core/platform.nix).
}
