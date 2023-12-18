{ inputs, withSystem, ... }:
let
  sharedModules = [ ../. ];

  username = "loqusion";
  homeImports = {
    "${username}@kuro" = [ ./kuro ] ++ sharedModules;
    "${username}@shiro" = [ ./shiro ] ++ sharedModules;
  };

  inherit (inputs.home-manager.lib) homeManagerConfiguration;
in {
  # imports = [{ _module.args = { inherit homeImports; }; }];

  flake = {
    homeConfigurations = withSystem "x86_64-linux" ({ pkgs, ... }: {
      "${username}" = homeManagerConfiguration {
        modules = homeImports."${username}@kuro";
        inherit pkgs;
      };
    });
  };
}
