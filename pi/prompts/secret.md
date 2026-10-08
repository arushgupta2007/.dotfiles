---
description: Decrypt an agenix secret by name and print it to stdout (for one-shot use).
---

# Secret

The user keeps secrets in `~/.dotfiles/secrets/<name>.age`, encrypted
with `agenix`. To use a secret:

1. `agenix -d ~/.dotfiles/secrets/<name>.age`

Never commit decrypted secrets. Never paste them into chat.

If the user asks to edit a secret:

1. `agenix -e ~/.dotfiles/secrets/<name>.age`
