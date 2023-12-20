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
    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    devenv,
    pre-commit-hooks,
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
        devenv.flakeModule
        pre-commit-hooks.flakeModule
      ];

      perSystem = {
        system,
        config,
        pkgs,
        ...
      }: let
        inherit (pkgs.lib) mkForce;
      in {
        _module.args.pkgs = import nixpkgs {
          inherit system;
          overlays = [
            helix.overlays.default
          ];
        };
        devenv.shells.default = {
          packages = with pkgs; [
            alejandra
          ];
          enterShell = ''
            ${config.pre-commit.installationScript}
          '';
          # HACK: Workaround for https://github.com/cachix/devenv/issues/528
          containers = mkForce {};
        };
        pre-commit = {
          settings.excludes = ["flake.lock" ".gitignore"];
          settings.hooks = {
            alejandra.enable = true;
          };
        };
      };
    };
}
