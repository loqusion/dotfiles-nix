{pkgs, ...}: let
  cursorThemeName = "catppuccin-mocha-dark-cursors";
in {
  home.packages = [pkgs.catppuccin-cursors];
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.mochaDark;
    name = cursorThemeName;
    size = 24;
    gtk.enable = true;
    x11.enable = false;
  };
}
