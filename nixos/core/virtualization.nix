{
  pkgs,
  username,
  ...
}:

{
  # VM group membership.
  users.users.${username}.extraGroups = [ "libvirtd" "qemu-libvirtd" ];
  users.extraGroups.qemu-libvirtd.members = [ username ];

  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    virtio-win
    win-spice
    adwaita-icon-theme
  ];

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        runAsRoot = false;
      };
    };
    spiceUSBRedirection.enable = true;
  };

  services.spice-vdagentd.enable = true;
}
