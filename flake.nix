{
  description = "mac/nixos nix-conf, forked from peanutbother/dotfiles";
  inputs = {
    # nixpkgs
    master.url = "github:nixos/nixpkgs/master";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-21.11";
    nur.url = "github:nix-community/NUR";
    nixpkgs.follows = "unstable";
    # TODO: find how to differentiate stable-nixos from stable-darwin

    flake-utils.url = "github:numtide/flake-utils";

    mkAlias = {
      url = "github:reckenrode/mkAlias";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix/master";

    mactelnet = {
      url = "github:sgrimee/mactelnet";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    flake-utils,
    home-manager,
    mactelnet,
    nixos-hardware,
    self,
    sops-nix,
    ...
  } @ inputs: let
    stateVersion = "23.05";
    mkModules = host: (import ./modules/hosts/${host} {inherit inputs;});
  in {
    nixosConfigurations = {
      nixair = inputs.nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs system stateVersion;
          overlays = import ./overlays;
        };
        modules = mkModules "nixair";
      };
    };

    darwinConfigurations = {
      SGRIMEE-M-4HJT = inputs.nix-darwin.lib.darwinSystem rec {
        system = "aarch64-darwin";
        # inputs = nixpkgs.lib.overrideExisting inputs {nixpkgs = nixpkgs-darwin;};
        specialArgs = {
          inherit inputs system stateVersion;
          overlays = import ./overlays;
        };
        modules = mkModules "SGRIMEE-M-4HJT";
      };
    };
  };
}
