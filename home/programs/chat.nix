{pkgs, ...}: {
  home.packages = with pkgs; [
    cinny
  ];
}
