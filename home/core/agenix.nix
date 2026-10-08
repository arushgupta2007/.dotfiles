{
  inputs,
  config,
  lib,
  ...
}:

let
  secretFile = ../../secrets/openrouter-api-key.age;
  hasSecret = builtins.pathExists secretFile;
in
{
  imports = [ inputs.agenix.homeManagerModules.default ];

  # Agenix pulls in user-level secrets. Identity path is the user's
  # personal SSH key on this machine.
  age.identityPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];

  # OpenRouter API key for Pi Coding Agent. Loaded only when the
  # encrypted file exists; the user provisions it with
  #   agenix -e secrets/openrouter-api-key.age
  # before the key becomes available at runtime.
  age.secrets.openrouter-api-key = lib.mkIf hasSecret {
    file = secretFile;
  };
}
