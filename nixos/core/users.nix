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
    # The user's shell is configured via Home Manager, so the system
    # check is satisfied by HM rather than NixOS modules.
    ignoreShellProgramCheck = true;
  };

  # Prevent unprivileged users from running Nix.
  nix.settings.allowed-users = [ "${username}" ];

  # Auto-create /nix/store access for the wheel group via sudo.
  security.sudo.wheelNeedsPassword = true;
}
