{ config, inputs, ... }:

{
  imports = [ inputs.agenix.homeManagerModules.default ];
  age.identityPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
  age.secrets.claude-code-openrouter.file = ../../claude-code-openrouter.age;
}
