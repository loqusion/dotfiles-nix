{ pkgs, ... }: {
  home = rec {
    username = "loqusion";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";

    packages = [ pkgs.discord pkgs.obsidian ];
  };

  programs.home-manager = { enable = true; };

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [ "electron-25.9.0" ];
  };
}
