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
      "libvirtd"
      "qemu-libvirtd"
    ];
    # The user is in the `podman` group (added by `nixos/core/podman.nix`)
    # so the rootless podman socket works without giving access to the
    # docker socket. `input` group is intentionally NOT granted — Niri
    # accesses input devices through the logind seat, and raw access to
    # /dev/input/event* is unnecessary for a regular desktop session.
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
