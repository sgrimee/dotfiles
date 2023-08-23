{
  description = "mac/nixos nix-conf, forked from peanutbother/dotfiles";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-23.05-darwin";
    flake-utils.url = "github:numtide/flake-utils";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mkAlias = {
      url = "github:reckenrode/mkAlias";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-search-cli = {
      url = "github:peterldowns/nix-search-cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    embedded_shell = {
      url = "path:./shells/embedded";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    nix_shell = {
      url = "path:./shells/nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    rust_shell = {
      url = "path:./shells/rust";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    web_shell = {
      url = "path:./shells/web";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs =
    { darwin
    , flake-utils
    , ...
    } @ inputs:
    let
      stateVersion = "23.05";
      mkModules = host: (import ./modules/hosts/${host} { inherit inputs; });
    in
    {
      # system configs
      nixosConfigurations.nixair = inputs.nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";

        specialArgs = {
          inherit inputs system stateVersion;
          overlays = import ./overlays;
        };

        modules = mkModules "nixair";
      };

      darwinConfigurations.SGRIMEE-M-J3HG = darwin.lib.darwinSystem rec {
        system = "x86_64-darwin";

        specialArgs = {
          inherit inputs system stateVersion;
          overlays = import ./overlays;
        };

        modules = mkModules "SGRIMEE-M-J3HG";
      };
    }
    // flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = import ./overlays;
      };
    in
    {
      # shells
      devShells.${system} = {
        embedded = inputs.embedded_shell.devShells.${system}.default;
        nix = inputs.nix_shell.devShells.${system}.default;
        rust = inputs.rust_shell.devShells.${system}.default;
        web = inputs.web_shell.devShells.${system}.default;
      };

      # templates
      templates = {
        embedded = {
          description = "embedded development environment";
          path = ./templates/embedded;
        };
        nix = {
          description = "nix development environment";
          path = ./templates/nix;
        };
        rust = {
          description = "rust development environment";
          path = ./templates/rust;
        };
        rust-nix = {
          description = "rust development environment with nix flake";
          path = ./templates/rust-nix;
        };
        web = {
          description = "web development environment";
          path = ./templates/web;
        };
      };
    });
}
