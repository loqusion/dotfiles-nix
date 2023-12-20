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
  };

  outputs = inputs @ {
    devenv,
    pre-commit-hooks,
    ...
  }: let
    inherit (inputs.flake-parts.lib) mkFlake;
  in
    mkFlake {inherit inputs;} {
      debug = true;

      systems = ["x86_64-linux"];

      imports = [
        ./home/profiles
        devenv.flakeModule
        pre-commit-hooks.flakeModule
      ];

      perSystem = {
        config,
        pkgs,
        ...
      }: {
        devenv.shells.default = {
          packages = with pkgs; [
            alejandra
          ];
          enterShell = ''
            ${config.pre-commit.installationScript}
          '';
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
