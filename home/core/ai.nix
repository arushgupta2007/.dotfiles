{
  config,
  pkgs,
  lib,
  ...
}:

let
  hasSecret = config.age.secrets ? claude-code-openrouter;
  secretPath = config.age.secrets.claude-code-openrouter.path or "";
  # Pi loads the key via a `!command` so the decrypted secret never
  # lives in the env or on disk as a config file. The command is run
  # by Pi on first use and cached for the process lifetime.
  authJson = builtins.toJSON {
    openrouter = {
      type = "api_key";
      key = "!cat ${secretPath}";
    };
  };
in
{
  home.packages = [
    pkgs.pi-coding-agent

    # Legacy wrapper for the `claude` CLI (kept for compatibility with
    # any projects that still reference it). Only built when the
    # OpenRouter secret is configured.
    (lib.mkIf hasSecret (pkgs.writeShellScriptBin "claude-openrouter" ''
      set -eu
      set -a
      . "${config.age.secrets.claude-code-openrouter.path}"
      set +a
      exec claude "$@"
    ''))
  ];

  # Pi auth.json — written from agenix-managed secret path. Pi supports
  # a `!command` prefix in the key field; the command is executed and
  # its stdout used as the API key. This avoids exposing the key in env
  # vars or storing it in plain-text config.
  xdg.configFile.".pi/agent/auth.json" = lib.mkIf hasSecret {
    text = authJson;
    # Pi writes its own auth.json when /login is used, but for our
    # openrouter-only setup we control it here. `force = false` (the
    # default) means user changes via /login can still override.
  };

  # Deploy Pi's user-level configuration. These are symlinks to
  # /nix/store so updates flow through home-manager switch.
  home.file.".pi/agent/AGENTS.md".source = ./../../pi/AGENTS.md;
  home.file.".pi/agent/settings.json".source = ./../../pi/settings.json;
  home.file.".pi/agent/skills".source = ./../../pi/skills;
  home.file.".pi/agent/prompts".source = ./../../pi/prompts;
}
