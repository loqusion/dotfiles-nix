{
  lib,
  inputs,
  withSystem,
  ...
}: let
  username = "loqusion";
  profiles = {
    kuro = {
      name = username;
      system = "x86_64-linux";
      modules = [./kuro];
    };
    shiro = {
      name = "${username}@shiro";
      system = "x86_64-linux";
      modules = [./shiro];
    };
  };

  allHomeManagerConfigurationsFor =
    mapAttrs' (name: profile:
      nameValuePair profile.name (homeManagerConfigurationFor profile));
  homeManagerConfigurationFor = profile:
    withSystem profile.system ({pkgs, ...}: (homeManagerConfiguration {
      modules = profile.modules ++ [../.];
      inherit pkgs;
    }));

  inherit (lib.attrsets) mapAttrs' nameValuePair;
  inherit (inputs.home-manager.lib) homeManagerConfiguration;
in {
  flake = {
    homeConfigurations = allHomeManagerConfigurationsFor profiles;
  };
}
