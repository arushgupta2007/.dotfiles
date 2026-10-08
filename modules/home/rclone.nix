{ pkgs, config, ... }:
{
  home.packages = with pkgs; [ fuse ];
  programs.rclone = {
    enable = true;
  };
  systemd.user.services.rclone-GDrive = {
    Unit = {
      Description = "Rclone mount for Google Drive";
      After = [ "network-online.target" ];
    };

    Service = {
      Type = "notify";

      ExecStart = ''
        ${pkgs.rclone}/bin/rclone mount \
          GDrive: %h/mnt/GDrive \
          --vfs-cache-mode writes
      '';

      ExecStop = "${pkgs.fuse}/bin/fusermount -u ~/mnt/GDrive";

      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  systemd.user.services.rclone-ProtonDrive = {
    Unit = {
      Description = "Rclone mount for Proton Drive";
      After = [ "network-online.target" ];
    };

    Service = {
      Type = "notify";

      ExecStart = ''
        ${pkgs.rclone}/bin/rclone mount \
          ProtonDrive: %h/mnt/ProtonDrive \
          --vfs-cache-mode writes
      '';

      ExecStop = "${pkgs.fuse}/bin/fusermount -u ~/mnt/ProtonDrive";

      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}


