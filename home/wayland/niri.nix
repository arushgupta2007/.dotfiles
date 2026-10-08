{
  pkgs,
  config,
  lib,
  ...
}:

{
  # Deploy the curated Niri config.kdl into ~/.config/niri/.
  xdg.configFile."niri/config.kdl".source = ./niri-config.kdl;

  home.packages = with pkgs; [
    # Workspace helpers.
    (pkgs.writeShellScriptBin "open-brave" (builtins.readFile ./scripts/open-brave.sh))
    (pkgs.writeShellScriptBin "screenshot-region" "grim -g \"$(slurp)\" - | wl-copy")
    (pkgs.writeShellScriptBin "screenshot-screen" "grim - | wl-copy")
    (pkgs.writeShellScriptBin "screenshot-window" "grim -g \"$(slurp -w)\" - | wl-copy")
  ];
}
