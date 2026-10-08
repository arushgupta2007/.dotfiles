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
    lazydocker
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

  # Rootless container support.
  services.podman.autoStart.enable = false; # Containers started manually.
}
