# Secrets

Agenix-encrypted secrets used by the system and by Home Manager.

## Files

- `secrets.nix` — the rules file used by the `agenix` CLI. Lists each
  encrypted file and the SSH public keys allowed to decrypt it.
- `*.age` — the encrypted secrets themselves. **Not committed** to git;
  they live only on machines that need them.

## Provisioning an OpenRouter key

1. Create a key at https://openrouter.ai/keys.
2. From this directory, encrypt it:

   ```bash
   agenix -e openrouter-api-key.age
   ```

   This opens an editor; paste the key, save, and the resulting
   `openrouter-api-key.age` file is what Home Manager will consume.

3. After `home-manager switch`, the decrypted key is available to Pi
   Coding Agent at the path exposed by `home/core/ai.nix`. Pi loads it
   via a `!command` entry in `~/.pi/agent/auth.json`, so the plaintext
   key never appears in environment variables or on disk outside the
   agenix tmpfs mount.

## Adding a new secret

1. Append an entry to `secrets.nix` with the file name and the public
   keys allowed to decrypt it.
2. Run `agenix -e <name>.age` to create the encrypted file.
3. Reference it from a NixOS or Home Manager module:

   ```nix
   age.secrets.<name>.file = ../../secrets/<name>.age;
   ```
