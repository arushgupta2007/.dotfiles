{ inputs, nixpkgs, self, username, host, ...}:
{
  imports =
       [ (import ./agenix.nix) ]
    ++ [ (import ./bootloader.nix) ]
    ++ [ (import ./c.nix) ]
    ++ [ (import ./hardware.nix) ]
    ++ [ (import ./xserver.nix) ]
    ++ [ (import ./network.nix) ]
    ++ [ (import ./nh.nix) ]
    ++ [ (import ./pipewire.nix) ]
    ++ [ (import ./bluetooth.nix) ]
    ++ [ (import ./program.nix) ]
    ++ [ (import ./python.nix) ]
    ++ [ (import ./security.nix) ]
    ++ [ (import ./services.nix) ]
    ++ [ (import ./system.nix) ]
    ++ [ (import ./user.nix) ]
    ++ [ (import ./wayland.nix) ]
    ++ [ (import ./displaymanager.nix) ]
    ++ [ (import ./virtualization.nix) ]
    ++ [ (import ./fingerprint.nix) ]
    ++ [ (import ./webusb.nix) ]
    ++ [ (import ./ollama.nix) ];
}
