{
  pkgs,
  config,
  lib,
  ...
}:

{
  # Deploy the curated Niri config.kdl into ~/.config/niri/.
  xdg.configFile."niri/config.kdl".source = ./niri-config.kdl;

  home.packages = [
    # Workspace helper: open Brave with a workspace-specific profile.
    (pkgs.writeShellScriptBin "open-brave" (builtins.readFile ./scripts/open-brave.sh))
  ];
}

