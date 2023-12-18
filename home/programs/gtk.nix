{pkgs, ...}: let
  cursorThemeName = "Catppuccin-Mocha-Dark-Cursors";
in {
  home.packages = [pkgs.catppuccin-cursors];
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.mochaDark;
    name = cursorThemeName;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}
