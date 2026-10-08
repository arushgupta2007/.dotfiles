{
  pkgs,
  ...
}:

{
  services.fprintd.enable = true;

  security.pam.services = {
    sudo.fprintAuth = true;
    login.fprintAuth = true;
    # DMS uses swaylock-compatible PAM when fingerprint is available.
    hyprlock = {
      text = ''
        auth sufficient pam_unix.so try_first_pass likeauth nullok
        auth sufficient pam_fprintd.so
        auth include login
      '';
    };
    swaylock = {
      text = ''
        auth sufficient pam_unix.so try_first_pass likeauth nullok
        auth sufficient pam_fprintd.so
        auth include login
      '';
    };
  };
}
