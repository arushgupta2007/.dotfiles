{
  config,
  pkgs,
  ...
}:

{
  # Pi Coding Agent — pinned to a maintained Nix package.
  home.packages = [
    pkgs.pi-coding-agent

    # Legacy wrapper for the `claude` CLI (kept for compatibility with
    # any projects that still reference it).
    (pkgs.writeShellScriptBin "claude-openrouter" ''
      set -eu
      set -a
      . "${config.age.secrets.claude-code-openrouter.path}"
      set +a
      exec claude "$@"
    '')
  ];

  # The agenix secret is decrypted at activation time to a path like
  # /run/agenix/<name>. We point OpenRouter at it via env var so Pi
  # picks the key up on launch.
  home.sessionVariables = {
    OPENROUTER_API_KEY_FILE =
      "${config.age.secrets.claude-code-openrouter.path}";
  };

  # Deploy Pi's user-level configuration.
  home.file.".pi/agent/AGENTS.md".source = ./../../pi/AGENTS.md;
  home.file.".pi/agent/settings.json".source = ./../../pi/settings.json;
  home.file.".pi/agent/extensions".source = ./../../pi/extensions;
  home.file.".pi/agent/skills".source = ./../../pi/skills;
  home.file.".pi/agent/prompts".source = ./../../pi/prompts;
}
