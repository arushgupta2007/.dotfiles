{ ... }:

{
  # DankMaterialShell greeter for the display manager.
  # DMS itself runs as a user service via Home Manager.
  programs.dankMaterialShell.greeter = {
    enable = true;
    compositor.name = "niri";
  };
}
