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

    # Per-language dev shell templates. Each is a self-contained flake
    # usable on its own via `nix develop ./templates/python` etc.
    python-template = {
      url = "path:./templates/python";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    node-template = {
      url = "path:./templates/node";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-template = {
      url = "path:./templates/rust";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    go-template = {
      url = "path:./templates/go";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cpp-template = {
      url = "path:./templates/cpp";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-template = {
      url = "path:./templates/nix";
      inputs.nixpkgs.follows = "nixpkgs";
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
      python-template,
      node-template,
      rust-template,
      go-template,
      cpp-template,
      nix-template,
      ...
    }@inputs:
    let
      inherit (nixpkgs) lib;
      system = "x86_64-linux";
      username = "arush";
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

      # Expose the language dev shells via the main flake for convenience.
      # These are also fully self-contained — see templates/<lang>/flake.nix.
      devShells.${system} = {
        python = python-template.devShells.${system}.default;
        node = node-template.devShells.${system}.default;
        rust = rust-template.devShells.${system}.default;
        go = go-template.devShells.${system}.default;
        cpp = cpp-template.devShells.${system}.default;
        nix = nix-template.devShells.${system}.default;
      };

      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt;
    };
}
