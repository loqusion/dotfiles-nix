{pkgs, ...}: {
  home.packages = with pkgs; [
    alejandra
    cachix
    fh
    nil
    nixfmt-classic
    nixpkgs-fmt
  ];
}
