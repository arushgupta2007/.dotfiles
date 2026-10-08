{
  pkgs,
  ...
}:

{
  # Restic for encrypted backups.
  home.packages = with pkgs; [
    restic
    rclone
  ];

  # rclone is configured but its systemd mounts are opt-in via `~/.config/rclone`
  # and `rclone config`. No automatic mounts are started.
}
