{
  pkgs,
  ...
}:

{
  # services.fprintd.enable = true;

  # PAM fingerprint integration for sudo / login. DMS uses its own lock
  # screen via the IPC `dms ipc call lock lock` — swaylock PAM is
  # configured as a fallback for users running swaylock directly.
  # security.pam.services = {
  #   sudo.fprintAuth = true;
  #   login.fprintAuth = true;
  #   swaylock = {
  #     text = ''
  #       auth sufficient pam_unix.so try_first_pass likeauth nullok
  #       auth sufficient pam_fprintd.so
  #       auth include login
  #     '';
  #   };
  # };
}
