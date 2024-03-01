{pkgs, ...}: {
  home.packages = with pkgs; [
    alejandra
    cachix
    fh
    nil
    nixfmt
    nixpkgs-fmt
  ];
}
