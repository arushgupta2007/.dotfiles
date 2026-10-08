{ config, pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "claude-openrouter" ''
          set -eu
          set -a
          . "${config.age.secrets.claude-code-openrouter.path}"
          set +a
          exec claude "$@"
        '')
  ];
  programs.zsh.shellAliases.cco = "claude-openrouter";
}
