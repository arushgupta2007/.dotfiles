{ ... }:

{
  # Agenix reads the SSH host key at /etc/ssh/ssh_host_ed25519_key to
  # decrypt NixOS-level secrets. The key is generated automatically when
  # `services.openssh.enable = true`. We currently declare only Home
  # Manager secrets (see home/core/agenix.nix), so no NixOS-level
  # identity paths are needed here.
  #
  # If you ever add a NixOS-level `age.secrets.<name>` entry, set
  #   age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  # and enable `services.openssh` so the key is generated.
}
