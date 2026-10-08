---
description: Show disk usage, top Nix store entries, and offer to gc old generations.
---

# Clean

Surface the largest entries in the Nix store and old system
generations. Do not delete anything automatically; only list candidates
and ask before running `nh clean` or `nix-collect-garbage`.
