{ ... }:

{
  # DankMaterialShell itself runs as a user service via Home Manager.
  # The DMS NixOS module exposes optional system-level configuration
  # under `programs.dank-material-shell` (hyphen, not camelCase).
  #
  # NOTE: the dedicated greeter was moved to a separate `dank-greeter`
  # repo. We do not enable it here; users can opt in by adding the
  # input to the flake and configuring `programs.dms-greeter`.
}
