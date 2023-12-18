{pkgs, ...}: {
  home.packages = with pkgs; [
    alejandra
    discord
    obsidian
  ];
}
