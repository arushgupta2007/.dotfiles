{
  description = "arush's NixOS developer workstation (Niri + DMS)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    danksearch = {
      url = "github:AvengeMedia/danksearch";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-stable = {
      url = "github:NixOS/nixpkgs/nixos-26.05";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      agenix,
      nixos-hardware,
      dms,
      ...
    }@inputs:
    let
      inherit (nixpkgs) lib;
      system = "x86_64-linux";
      username = "arush";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        framework-laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/framework-laptop
            agenix.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs username;
                };
                users.${username} = import ./home;
              };
            }
          ];
          specialArgs = {
            inherit inputs username;
          };
        };
      };

      # Exposed development shells (templates).
      devShells.${system} = {
        python = (import ./templates/python/shell.nix) { inherit pkgs; };
        node = (import ./templates/node/shell.nix) { inherit pkgs; };
        rust = (import ./templates/rust/shell.nix) { inherit pkgs; };
        go = (import ./templates/go/shell.nix) { inherit pkgs; };
        cpp = (import ./templates/cpp/shell.nix) { inherit pkgs; };
        nix = (import ./templates/nix/shell.nix) { inherit pkgs; };
      };

      formatter.${system} = pkgs.nixfmt;
    };
}
