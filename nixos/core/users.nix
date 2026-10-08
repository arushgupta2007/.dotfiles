{
  pkgs,
  username,
  ...
}:

{
  users.users.${username} = {
    isNormalUser = true;
    description = "Arush Gupta";
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "plugdev"
      "input"
      "libvirtd"
      "qemu-libvirtd"
      "docker"
    ];
    shell = pkgs.zsh;
  };

  # Prevent unprivileged users from running Nix.
  nix.settings.allowed-users = [ "${username}" ];

  # Auto-create /nix/store access for the wheel group via sudo.
  security.sudo.wheelNeedsPassword = true;
}
