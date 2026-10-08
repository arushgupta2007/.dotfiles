# Secrets

Agenix-encrypted secrets used by the system and by Home Manager.

## Layout

```
secrets/
├── README.md            ← this file
├── secrets.nix          ← rules file: which public keys may decrypt what
└── <name>.age           ← encrypted secrets (NEVER in Git)
```

The rules file is `secrets/secrets.nix`. Path entries inside it are
resolved relative to this directory, so `"openrouter-api-key.age"`
refers to `secrets/openrouter-api-key.age` and the home module can
reference the same path via `../../secrets/openrouter-api-key.age`.

## Provisioning an OpenRouter key

1. Create a key at https://openrouter.ai/keys.
2. From `secrets/`, encrypt it:

   ```bash
   cd secrets
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
2. Run `cd secrets && agenix -e <name>.age` to create the encrypted file.
3. Reference it from a NixOS or Home Manager module:

   ```nix
   age.secrets.<name>.file = ../../secrets/<name>.age;
   ```

## Why aren't `.age` files in Git?

Each `.age` file is the encrypted ciphertext. It can only be decrypted
on a machine that holds a private key listed in `secrets.nix`. The
encrypted file is machine-specific (or team-specific) and is generated
locally after running `agenix -e`. Committing it to a public repo leaks
no key material but does leak the existence and rough size of the
secret, so we keep them out of version control.

## Troubleshooting

- `agenix -e` complains about a missing identity → ensure the public
  half of your key is listed in `secrets.nix` and that the matching
  private key is at one of the `age.identityPaths` (default: `~/.ssh/id_ed25519`).
- Decryption fails at activation with `no identity available` → re-run
  `agenix -e <name>.age` after adding the new machine's public key to
  `secrets.nix`.
