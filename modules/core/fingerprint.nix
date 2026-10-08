{ pkgs, ... }:
{  
  services.fprintd.enable = true;
  # Optional: Enable PAM support for sudo
  security.pam.services.sudo.fprintAuth = true;
  # Optional: Enable PAM support for login (TTY/GDM)
  security.pam.services.login.fprintAuth = true;

  security.pam.services.hyprlock = {
    text = ''
      auth sufficient pam_unix.so try_first_pass likeauth nullok
      auth sufficient pam_fprintd.so
      auth include login
    '';
  };

  security.pam.services.swaylock = {
    text = ''
      auth sufficient pam_unix.so try_first_pass likeauth nullok
      auth sufficient pam_fprintd.so
      auth include login
    '';
  };

  security.pam.services.dms = { # Replace 'dms' with 'dankshell' if this doesn't work
    text = ''
      auth      sufficient pam_unix.so try_first_pass likeauth nullok
      auth      sufficient pam_fprintd.so
      auth      include login
    '';
  };
}

