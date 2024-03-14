{
  description = "Home Manager configuration of loqusion";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    helix,
    ...
  }: let
    inherit (nixpkgs.lib.systems) flakeExposed;
    inherit (inputs.flake-parts.lib) mkFlake;
  in
    mkFlake {inherit inputs;} {
      debug = true;

      systems = flakeExposed;

      imports = [
        ./home/profiles
      ];

      perSystem = {
        system,
        config,
        pkgs,
        ...
      }: {
        _module.args.pkgs = import nixpkgs {
          inherit system;
          overlays = [
            # helix.overlays.default
          ];
        };
      };
    };
}
