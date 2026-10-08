{
  config,
  pkgs,
  lib,
  ...
}:

let
  hasSecret = config.age.secrets ? openrouter-api-key;
  secretPath = config.age.secrets.openrouter-api-key.path or "";

  # Pi's `auth.json` supports a `!command` prefix for the API key value;
  # the command's stdout is used as the key on first use. This avoids
  # the plaintext key ever living in an environment variable.
  authJson = builtins.toJSON {
    openrouter = {
      type = "api_key";
      key = "!cat ${secretPath}";
    };
  };

  # Helper: shell script that prints the decrypted OpenRouter key.
  # Only included when the secret exists. Useful for downstream tools
  # that need to source the key as an environment variable.
  openrouterKeyScript = lib.optional hasSecret
    (pkgs.writeShellScriptBin "openrouter-key" ''
      set -eu
      cat "${config.age.secrets.openrouter-api-key.path}"
    '');

  # The path that HM creates for skill / prompt / extension files. Pi
  # discovers resources relative to the agent directory (default
  # ~/.pi/agent), so absolute `$HOME`-relative paths via home.file are
  # the right mechanism for declarative deployment.
  piAgentDir = ".pi/agent";
in
{
  # Pi Coding Agent — pinned to the nixpkgs package, plus an optional
  # helper that prints the decrypted key. The helper is only built when
  # the agenix secret exists.
  home.packages = [ pkgs.pi-coding-agent ] ++ openrouterKeyScript;

  # Pi's authentication file. `force = false` lets the user override
  # this declaratively-set value via `/login` if they ever want Pi to
  # manage its own credentials.
  xdg.configFile."${piAgentDir}/auth.json" = lib.mkIf hasSecret {
    text = authJson;
  };

  # Pi's user-level configuration. Stable settings, skill manifests,
  # prompt templates, and (later) extensions are symlinked from the
  # Nix store into ~/.pi/agent/. Pi's runtime state (sessions,
  # compaction cache, /login-managed auth.json overrides) lives in
  # XDG state dirs and is intentionally NOT touched here.
  home.file."${piAgentDir}/AGENTS.md".source = ./../../pi/AGENTS.md;
  home.file."${piAgentDir}/settings.json".source = ./../../pi/settings.json;
  home.file."${piAgentDir}/skills".source = ./../../pi/skills;
  home.file."${piAgentDir}/prompts".source = ./../../pi/prompts;
}
