{pkgs, ...}: {
  home.packages = with pkgs; [
    alejandra
    cachix
    nil
  ];
}
