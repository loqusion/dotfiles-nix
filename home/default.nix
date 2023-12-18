{pkgs, ...}: {
  home = rec {
    username = "loqusion";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };

  programs.home-manager = {enable = true;};

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = ["electron-25.9.0"];
  };
}
