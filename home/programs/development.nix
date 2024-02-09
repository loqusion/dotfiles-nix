{pkgs, ...}: {
  home.packages = with pkgs; [
    alejandra
    cachix
    nil
    nixfmt
    nixpkgs-fmt
  ];
}
