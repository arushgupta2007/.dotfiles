{
  inputs,
  config,
  lib,
  ...
}:

let
  secretFile = ../../secrets/claude-code-openrouter.age;
  hasSecret = builtins.pathExists secretFile;
in
{
  imports = [ inputs.agenix.homeManagerModules.default ];

  # Agenix pulls in user-level secrets. Identity path is the SSH key on
  # the user's machine.
  age.identityPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];

  # OpenRouter key for Pi coding agent — managed by agenix, never in the
  # Nix store. The secret is only loaded when the file exists; the user
  # must generate it with `agenix -e secrets/claude-code-openrouter.age`
  # before the key becomes available at runtime.
  age.secrets.claude-code-openrouter = lib.mkIf hasSecret {
    file = secretFile;
  };
}
