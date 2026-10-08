{
  config,
  ...
}:

{
  # Agenix pulls in user-level secrets. Identity path is the SSH key on
  # the user's machine; this matches the existing repo's pattern.
  age.identityPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];

  # OpenRouter key for Pi coding agent — managed by agenix, never in the
  # Nix store. Replace the path/owner once you (re)encrypt the file.
  age.secrets.claude-code-openrouter = {
    file = ../../secrets/claude-code-openrouter.age;
  };
}
