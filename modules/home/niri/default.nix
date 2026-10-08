{ pkgs, ... }: 
let
  open-brave = pkgs.writeShellScriptBin "open-brave" (builtins.readFile ./scripts/open-brave.sh);
in
{
  xdg.configFile."niri/config.kdl".source = ./config.kdl;
  home.packages = with pkgs; [
    open-brave
  ];
}

