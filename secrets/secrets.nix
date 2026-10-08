# Agenix rules file. Path entries are resolved relative to THIS file's
# directory, so `"openrouter-api-key.age"` refers to
# `~/.dotfiles/secrets/openrouter-api-key.age`.
#
# The agenix CLI defaults to reading this file as `./secrets.nix` when
# invoked from `secrets/`. Re-encrypt secrets from this directory:
#
#   cd secrets
#   agenix -e openrouter-api-key.age
#
{
  # OpenRouter API key for Pi Coding Agent.
  # Create the encrypted file with:
  #   cd secrets && agenix -e openrouter-api-key.age
  # and paste the key from https://openrouter.ai/keys
  "openrouter-api-key.age".publicKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID3D9KNtWPB9wQORWgrR+Z1+RlGWKybMeYgtRtlmwc2W arush.agu@protonmail.com"
  ];
}
