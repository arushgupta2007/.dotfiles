# Secrets

This directory contains agenix-encrypted secrets.

## How to add a secret

1. Generate a new key file with `agenix -e <name>.age`.
2. Add the corresponding public key to `secrets.nix`.
3. Reference the secret in a NixOS or Home Manager module via
   `age.secrets.<name>.file = ../../secrets/<name>.age;`.

## Existing secrets

- `claude-code-openrouter.age` — OpenRouter API key for Pi Coding Agent.

The public key in `secrets.nix` is intentionally left empty until you add
your real SSH key. The configuration will still build, but the OpenRouter
key will not be available at runtime until you populate the secret.
