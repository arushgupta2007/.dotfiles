---
description: Run nh os switch on the framework-laptop host. Surfaces the build status; never runs `switch` without explicit user confirmation.
---

# Rebuild

Run `nh os build .` to evaluate the new NixOS configuration without
applying it. Show the resulting diff and any errors.

If the user explicitly approves the rebuild, run `nh os switch` instead.

Do not run this command unless the user asks for it.
